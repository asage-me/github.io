---
layout: page
title: Configure git
---

1. You can configure git by running commands in Powershell or CMD.  Here are the values that should be configured in git.  You can view all current values with `git config --list` or a specific one by omitting the part in quotes, ex: `git config --global user.email`
   - `git config --global user.email "your@email.com"`
   - `git config --global user.name "Your Name"`
   - `git config --global gpg.program "C:\Program Files (x86)\GnuPG\bin\gpg.exe"`
     - Use whatever path you installed gpg to.  The above path is the default for Windows, but Linux and Mac will obviously be different
   - `git config --global user.signingkey (ID from GPG key)`
   - `git config --global commit.gpgsign true`
