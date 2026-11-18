---
layout: policy
app: vault
title: Vault
description: Vault is an Android password manager and personal-document wallet by Reizon Games. Everything is encrypted on your phone, with no server in between.
permalink: /vault/
updated: 2026-11-18
glance:
  - label: Platform
    value: Android
  - label: Account needed
    value: None
  - label: Our servers
    value: None
  - label: Ads or tracking
    value: None
---

**Vault** is a password manager and personal-document wallet for Android, developed by Reizon Games and published
under the Online Build Studio name. It keeps your logins, IDs, cards and notes in one place that only you can open.

> **In short:** everything you put in Vault is encrypted on your phone. There is no Vault account and no Vault server,
> so we never see your data and cannot read your vault.

## What Vault does

- **Stores what matters:** logins, passkeys, ID documents (passport, citizenship, PAN, voter ID), bank accounts,
  insurance policies, payment cards, Wi-Fi networks (with a QR code to join), passphrases, addresses and secure notes.
- **Fills for you:** an Android Autofill service for apps and Chrome, and passkey and password sign-in through
  Android's Credential Manager (Android 14 and later).
- **Makes strong passwords:** a password and passphrase generator, plus a health check that flags weak or reused
  passwords.
- **Reminds you:** expiry reminders for documents such as passports and insurance.
- **Locks down:** unlock with your master password or fingerprint, auto-lock, and a recovery key for the day you
  forget the password.

## Your data stays with you

Each item is encrypted on your phone with a random vault key (XChaCha20-Poly1305). That key is locked by your master
password, which is stretched with Argon2id, and by your recovery key. Nothing readable is kept while the vault is
locked.

An encrypted backup to your own Google Drive is available if you turn it on. It goes to a hidden app-data folder that
only Vault can see, and it cannot be read without your master password or recovery key. The full details are in the
[privacy policy]({{ '/vault/privacy/' | relative_url }}).

## Policies

- [Privacy policy]({{ '/vault/privacy/' | relative_url }})
- [Terms of use]({{ '/vault/terms/' | relative_url }})

## Contact

Questions about Vault or its policies: use the contact address at the bottom of this page.
