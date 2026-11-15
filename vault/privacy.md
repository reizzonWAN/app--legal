---
layout: policy
app: vault
title: Vault privacy policy
description: How the Vault password manager by Reizon Games handles your information. Your vault is encrypted on your phone and we cannot read it.
permalink: /vault/privacy/
updated: 2026-11-15
glance:
  - label: Data we collect
    value: None
  - label: Leaves your phone
    value: Encrypted backup, if you turn it on
  - label: Who can read your vault
    value: Only you
  - label: Ads or tracking
    value: None
---

Vault ("the app") is a password manager and personal-document wallet for Android, developed by Reizon Games ("we",
"us"). This policy explains what happens to the information you keep in it.

> **In short:** everything you put in Vault is encrypted on your phone. We run no server, collect nothing and cannot
> read your vault. The only thing that can leave your phone is an encrypted backup in your own Google Drive, and only
> if you turn it on.

## What we collect

Nothing. We don't run a server, and the app sends us no data of any kind.

- You don't create an account with us.
- The app contains no analytics, advertising, crash-reporting or tracking software.
- We never see your passwords, documents, notes or anything else in your vault.

## Your vault, on your phone

What you save in Vault stays on your phone, encrypted. This includes logins, passkeys, ID documents, bank and
insurance details, payment cards, Wi-Fi networks, passphrases, addresses and notes.

- Each item is encrypted separately with a random vault key (XChaCha20-Poly1305).
- The vault key is itself locked by your **master password** (stretched with Argon2id), by your **recovery key**,
  and, if you turn it on, by a fingerprint-protected key held in your phone's secure hardware.
- While the vault is locked, nothing readable is kept in memory or on disk.
- Android's own cloud backup is switched off for Vault, so your vault is never copied into it.

We can't recover your vault. If you lose both your master password and your recovery key, nobody, including us, can
open it.

## Google Drive backup (optional)

You can choose to back up your vault to your own Google Drive. If you turn this on:

- **What is uploaded:** one file, `vault-backup.json`, holding your vault exactly as it is stored on your phone. It
  stays encrypted. It can't be read without your master password or recovery key, by Google or anyone else.
  Fingerprint unlock is not part of it.
- **Where it goes:** a hidden app-data folder in your Google Drive. It doesn't appear in your Drive files, and other
  apps can't see it.
- **What Vault can access:** Vault asks Google only for permission to manage its own app-data folder
  (`drive.appdata`). It can't see, open or change any of your other Drive files.
- **Your Google account email:** Vault reads the email address of the Google account you connect and keeps it on
  your phone, only to show which account holds the backup. It's never sent anywhere else.
- **Turning backup off** deletes the backup file from your Drive.

Data is sent to Google over an encrypted connection (HTTPS). Google's own privacy policy applies to your Google
account and to Drive.

Vault's use and transfer of information received from Google APIs follows the
[Google API Services User Data Policy](https://developers.google.com/terms/api-services-user-data-policy),
including its Limited Use requirements. We don't use this information for advertising, we don't sell it, and we
don't let people read it.

## Autofill and passkeys

If you turn Vault on as your autofill service or passkey provider in Android settings:

- When you sign in to an app or a website in Chrome, Android shows Vault the sign-in form so it can find the
  username and password fields. Vault uses this only to offer matching logins and to offer to save new ones. It
  doesn't keep or send what's on the screen.
- When you use a login in an app, Vault remembers that app's package name inside your encrypted vault, so it can
  suggest the same login next time.
- Passkeys are created and used on your phone and stored encrypted in your vault. The website or app you sign in to
  gets only what the passkey standard (WebAuthn) sends it.

## Other apps on your phone

To show the names of apps linked to your logins, and to check that a website really comes from Chrome, Vault can see
which apps on your phone can be opened. It uses this only on your phone, it doesn't keep a list of your apps, and it
never sends that information anywhere.

## Phone features Vault uses

| Feature | Why | What stays where |
| --- | --- | --- |
| Fingerprint | Unlock the vault without typing the master password | Android checks your fingerprint. Vault never receives fingerprint data. |
| Notifications | Remind you before an ID document or card expires | Reminders are planned and shown on your phone only. |
| Run at start-up | Set the next reminder again after the phone restarts | Nothing is sent anywhere. |
| Internet | Google Drive backup only | Only the encrypted backup file and the account email lookup described above. |
| Clipboard | One-tap copy of a password or other field | Copies are marked as sensitive so Android hides them from previews. |

Vault doesn't use your location, camera, microphone, contacts or photos.

## Keeping and deleting your data

- **On your phone:** your vault stays until you delete items or uninstall the app. Uninstalling removes it from
  your phone.
- **In Google Drive:** turn backup off in Vault to delete the backup file. You can also remove it yourself in Google
  Drive under **Settings → Manage apps**, by choosing **Delete hidden app data** for Vault.

Because we hold no data about you, there is nothing for us to export or delete on our side.

## Security

Vault is designed so that your data is protected even if your phone or your Drive backup ends up in the wrong
hands. No method is perfect, so choose a strong master password and keep your recovery key somewhere safe.

## Children

Vault isn't directed at children under 13, and we don't knowingly collect personal information from anyone.

## Changes to this policy

If this policy changes, the new version will be published at this address with a new "last updated" date. The
change history link at the bottom of this page shows every past version.

## Contact

Questions about this policy: email [{{ site.contact_email }}](mailto:{{ site.contact_email }}).
