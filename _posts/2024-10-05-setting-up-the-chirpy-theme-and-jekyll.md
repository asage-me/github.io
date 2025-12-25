---
layout: post
title: Setting up the Chirpy Theme and Jekyll
date: '2024-10-05 15:33:34 -0400'
---

I thought a good first post would be how I set up this site. It was quite a learning experience and took longer than expected due to all the rabbit holes I ventured down that I probably should have avoided.

I opted to go the free hosting route because I'm cheap. Unfortunately, as with almost everything free, it required quite a bit of work on my end to figure out how to make it work and to make it look nice. GitHub Pages and Jekyll seemed to fit pretty much everything I wanted so I chose that stack for my website build. This stack satisfies the main requirement, cost, as well as a few other nice features:

- All site updates are tracked in my repository
- Jekyll has many themes to choose from
- Working with Markdown is straightforward
  - Just be aware that a lot of themes will have their own special markdown for advanced things like callouts
- There is a pre-built Dev Container for VSCode to build the site locally for preview before pushing to GitHub
  - One limitation is that the Dev Container doesn't check for broken links during the build process. Sometimes I will accidentally link to the .md file instead of .html or make a typo. These errors go undetected unless I manually inspect the links, which isn't caught until the change is pushed to GitHub and I see the build fails
- There are many VSCode extensions to help with coding

The resources for this guide are all in pages on this site. [Here](/pages) is a sitemap for all my pages.

1. The first step is to get a new domain if you plan on using a custom domain
   - [Set up DNS](/pages/github/pages/set-up-dns)
2. [Install WSL](/pages/wsl/install)
3. [Install Docker Desktop](/pages/docker-desktop/install)
      > Make sure you installed WSL so Docker Desktop can use it
      {: .prompt-tip }
4. [Install git](/pages/git/install) 
5. [Install VSCode](/pages/vscode/initial-setup)
6. [Set up Jekyll](/pages/github/pages/jekyll/set-up-jekyll)

Once you follow through the steps above you should have a shiny new web page on a custom domain waiting for you to add content.
