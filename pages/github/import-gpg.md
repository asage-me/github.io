---
layout: page
title: Import GPG
---

> If you change your key you will have issues committing in the Dev Container.  There seems to be a disconnect with the git on your computer and the git in the container once the Dev Container is set up.  The easiest way I found to fix this is to just delete all the containers, images, volumes, and builds in Docker Desktop and then clone the repo in a named volume again.  I'm sure there is a way to fix this but for as simple as this process is, I did not feel like investing the time to figure it out.
{: .prompt-tip }

1. Install [Gpg4win](https://gpg4win.org) or [whatever version you need](https://gnupg.org/download)
2. Open Kleopatra and import your key backup
   - ![Kleopatra Import](/assets/img/github/kleopatra-import.png)
3. Confirm you imported the correct key and click `Yes, it's mine`
   - ![Kleopatra Key](/assets/img/github/kleopatra-key.png)
4. Click ok on the import results box
5. Get the ID for your key
   - `gpg --list-secret-keys --keyid-format=long`
     - The ID is the 16 characters after `sec rsa4096/`
6. Configure git to use your key
   - `git config --global gpg.program "C:\Program Files (x86)\GnuPG\bin\gpg.exe"`
     - Use whatever path you installed gpg to.  The above path is the default for Windows, but Linux and Mac will obviously be different
   - `git config --global user.signingkey (ID from above)`
   - `git config --global commit.gpgsign true`
7. Make sure the email you configured in git matches the email in the GPG key. If the email is not the same the commit will not show as verified.
   - Show configured email
     - `git config --global user.email`
   - Update email
     - `git config --global user.email "your@example.com"`
