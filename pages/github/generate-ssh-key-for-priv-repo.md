---
layout: page
title: Generate an SSH Key to Pull a Private Repo
---

1. Generate a new SSH key
   - `ssh-keygen -t ed25519 -C email@example.com`
2. Add it to your account's SSH keys
   - [Add New SSH key](https://github.com/settings/ssh/new)
3. Give it a Title and paste in the output from the cat command below in the key file text area
   - Use Powershell to copy directly to the clipboard `cat ~/.ssh/id_ed25519.pub | clip`
