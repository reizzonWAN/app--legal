#!/usr/bin/env bash
# Run on your own machine: build the release/prod branch on the VPS and publish it at legal.onlinebuildstudio.com,
# served by the shared edge Caddy (edge repo "caddy", sites/legal.caddy, mounted read-only at /srv/app--legal).
#
# Usage: scripts/deploy.sh deploy@<server-ip>
#        SSH_PORT=2222 scripts/deploy.sh deploy@<server-ip>
#
# What is published is exactly what has been pushed to origin/release/prod, exported with `git archive`.
# Jekyll runs on the server in a throwaway Ruby container (gems cached in the volume "legal-jekyll-gems"),
# with _config.vps.yml on top (url and empty baseurl). The live folder is only replaced after a good build.
# GitHub Pages keeps publishing main at reizzonwan.github.io/app--legal/ independently.
#
# Emergency override (a hotfix not yet on release/prod): DEPLOY_REF=<commit-or-ref>.
set -euo pipefail

target="${1:?usage: scripts/deploy.sh deploy@<server-ip>}"
ssh_port="${SSH_PORT:-22}"
root="$(cd "$(dirname "$0")/.." && pwd)"
release_branch=release/prod
ref="${DEPLOY_REF:-origin/$release_branch}"
site_dir=/opt/sites/app--legal
build_dir=/opt/sites/.build/app--legal
ruby_image=ruby:3.3
jekyll_version=4.3.4

rsync_bin="${RSYNC:-}"
for candidate in /opt/homebrew/bin/rsync /usr/local/bin/rsync rsync; do
	[[ -n "$rsync_bin" ]] && break
	command -v "$candidate" >/dev/null && rsync_bin="$candidate"
done
[[ -n "$rsync_bin" ]] || {
	echo "rsync not found" >&2
	exit 1
}

echo "Fetching origin"
git -C "$root" fetch --quiet origin
revision="$(git -C "$root" rev-parse --verify --quiet "$ref^{commit}")" || {
	echo "Cannot resolve $ref. Has $release_branch been pushed?" >&2
	exit 1
}
if [[ -n "${DEPLOY_REF:-}" ]]; then
	echo "WARNING: deploying $DEPLOY_REF instead of $release_branch. Merge it into $release_branch afterwards." >&2
fi

export_dir="$(mktemp -d)"
trap 'rm -rf "$export_dir"' EXIT
git -C "$root" archive --format=tar "$revision" | tar -x -C "$export_dir"
printf '%s %s\n' "$revision" "$(git -C "$root" log -1 --format=%s "$revision")" >"$export_dir/REVISION"

echo "Uploading $ref ($(git -C "$root" rev-parse --short "$revision")) → $target:$build_dir/src"
ssh -p "$ssh_port" "$target" "test -d $site_dir && mkdir -p $build_dir/src $build_dir/out" || {
	echo "$site_dir is missing on the server (see README: hosting on the VPS)" >&2
	exit 1
}
"$rsync_bin" -rlptz --delete -e "ssh -p $ssh_port" "$export_dir/" "$target:$build_dir/src/"

echo "Building with Jekyll $jekyll_version on the server"
ssh -p "$ssh_port" "$target" bash -s -- "$build_dir" "$site_dir" "$ruby_image" "$jekyll_version" <<'REMOTE'
set -euo pipefail
build_dir="$1" site_dir="$2" image="$3" version="$4"
rm -rf "$build_dir/out" && mkdir -p "$build_dir/out"
# Runs as root inside the container (the cached gem volume is root-owned), then hands the output back to deploy.
docker run --rm \
	-e GEM_HOME=/gems \
	-v legal-jekyll-gems:/gems \
	-v "$build_dir/src:/src:ro" -v "$build_dir/out:/out" \
	"$image" sh -c "
		set -e
		export PATH=/gems/bin:\$PATH
		gem list -i jekyll -v $version >/dev/null || gem install --no-document jekyll:$version kramdown-parser-gfm
		cd /src && jekyll build --quiet --disable-disk-cache --source /src --destination /out --config _config.yml,_config.vps.yml
		chown -R $(id -u):$(id -g) /out
	"
[ -f "$build_dir/out/index.html" ] || { echo "build produced no index.html; the live site was not touched" >&2; exit 1; }
cp "$build_dir/src/REVISION" "$build_dir/out/REVISION"
chmod -R a+rX "$build_dir/out"
rsync -a --delete "$build_dir/out/" "$site_dir/"
echo "Published $(cut -c1-12 "$site_dir/REVISION") to $site_dir ($(find "$site_dir" -name '*.html' | wc -l) pages)"
REMOTE
echo "Check: curl -sSI https://legal.onlinebuildstudio.com/"
