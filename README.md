# app--legal

Privacy policies and terms of use for apps by Reizon Games, published with GitHub Pages so the Google Play Console and
App Store Connect can link to them.

**Site:** <https://reizzonwan.github.io/app--legal/>

| App | Privacy policy | Terms of use |
| --- | --- | --- |
| Ludo | <https://reizzonwan.github.io/app--legal/ludo/privacy/> | <https://reizzonwan.github.io/app--legal/ludo/terms/> |
| Vault | <https://reizzonwan.github.io/app--legal/vault/privacy/> | <https://reizzonwan.github.io/app--legal/vault/terms/> |

These URLs are what the stores and the apps link to. **Never rename or move a published page**, or every store
listing and app build pointing at it breaks.

## How it works

GitHub Pages builds the site from `main` with its own Jekyll. There is no Gemfile, no Actions workflow and no build
step to maintain: push to `main` and the site updates within a minute or two.

## Hosting on the VPS (legal.onlinebuildstudio.com)

The same site is also served from the VPS by the shared edge Caddy (edge repo `caddy`, `sites/legal.caddy`) at
<https://legal.onlinebuildstudio.com/>, with no `/app--legal` prefix. The GitHub Pages copy stays, so the store links
above keep working.

**The VPS ships only `origin/release/prod`.** Work lands on `main` (GitHub Pages publishes it); to release to the
VPS, fast-forward `release/prod` to `main`, push both (as `reizzonWAN`), then in a visible terminal:

```bash
scripts/deploy.sh deploy@2.29.152.218
```

It exports `origin/release/prod` with `git archive`, builds it on the server with Jekyll in a throwaway Ruby
container (`_config.yml` plus `_config.vps.yml`), and replaces `/opt/sites/app--legal` only after a good build.
Emergency hotfix only: `DEPLOY_REF=<commit> scripts/deploy.sh …`, then merge it into `release/prod`.

First-time setup on the server: `sudo install -d -m 755 -o deploy -g deploy /opt/sites/app--legal /opt/sites/.build`.

```
_config.yml           site settings, including the public contact email
_data/apps.yml        one entry per app: name, publisher, icon, accent colours, its documents
_layouts/base.html    page shell: header, footer, contact link, change-history link
_layouts/policy.html  policy page: app header, document tabs, "at a glance" tiles, contents list
assets/css/site.css   all styles (light and dark); no web fonts, scripts or third-party requests
assets/icons/         app icons and the favicon
index.html            the hub listing every app
<app>/privacy.md      an app's privacy policy
<app>/terms.md        an app's terms of use
404.html
```

The contents list on each policy page is built from its `##` headings, so a policy needs no extra markup.

## Add an app

1. Add an entry to `_data/apps.yml` (copy an existing one; `id` is the folder name).
2. Add its icon to `assets/icons/` (square, at least 256 px).
3. Add `<id>/privacy.md` (and `<id>/terms.md` if wanted), copying the front matter of an existing policy and changing
   `app`, `title`, `description`, `permalink`, `updated` and `glance`.
4. Make the policy match the app: what it collects, every SDK in it, what leaves the device, and its permissions.
   Google checks the privacy policy against the app's Data safety form, and Apple against its privacy labels.

## Update a policy

1. Edit the Markdown and set `updated:` in its front matter to today's date.
2. If the change is material (new data collected, a new SDK, data now leaves the device), update the store's Data
   safety form or privacy labels in the same release.

Every past version stays visible through the "Change history" link on each page (the file's commit history).

## Contact address

`contact_email` in `_config.yml` is shown on every page. While it is empty, pages point to this repo's GitHub issues
instead. Both stores expect a way to contact the developer, so set it before an app is submitted.

## Preview locally (optional)

Not needed to publish. With Ruby installed:

```bash
gem install jekyll kramdown-parser-gfm
jekyll serve --livereload
```

Then open <http://localhost:4000/app--legal/>.
