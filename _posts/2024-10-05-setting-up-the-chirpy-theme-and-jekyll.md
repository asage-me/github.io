---
layout: post
title: Setting up the Chirpy Theme and Jekyll
date: '2024-10-05 15:33:34 -0400'
---

I figured a good first post would probably be how I set up this site.  It was quite a learning experience and took me way longer that I thought due to all the rabbit holes I ventured down that I probably should have avoided.

I opted to go the free hosting route because I'm cheap.  Unfortunately, as with almost everything free, it required quite a bit of work on my end to figure out how to make it work and to make it look nice.  GitHub Pages and Jekyll seemed to fit pretty much everything I wanted so I chose that stack for my website build.  This stack satisfies the main requirement, cost, as well as a few other nice features:

- All site updates are tracked in my repository
- Jekyll has a ton of themes to choose from
- Working with Markdown is easy
  - Just be aware that a lot of themes will have their own special markdown for advanced things like callouts
- There is a pre-built Dev Container for VSCode to build the site locally for preview before pushing to GitHub
  - My only complaint with the Dev Container is it does not check for broken links at build.  Sometimes I will accidentally link to the .md file instead of .html or make a typo.  Unless I actually inspect the links these errors are not caught until the change is pushed to GitHub and I see the build fails
- There are a ton of VSCode extensions to help with coding

The resources for this guide are all in pages on this site.  [Here](/pages) is a sitemap for all my pages.

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
