---
layout: page
title: Pages Settings
---

[GitHub Docs - publishing source](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)  
[GitHub Docs - custom DNS](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/about-custom-domains-and-github-pages)  
[GitHub Docs - HTTPS](https://docs.github.com/en/pages/getting-started-with-github-pages/securing-your-github-pages-site-with-https)

1. Go to your GitHub Pages repo on [GitHub](https://github.com/asagedev/github.io/settings)
   - At the top, click the settings tab
   - On the left menu, click Pages under Code and automation
   - For Build and deployment, select Deploy from a branch, and select whichever branch you want - typically main
   - Under Custom domain, enter the domain you want to use - whatever you set up in [Set up DNS](set-up-dns)
   - Click Save then wait for the DNS Check to finish
   - Once the DNS check is done a Let's Encrypt certificate will be generated for your custom domain.  This can take a little bit and sometime the page has to be refreshed before the Enforce HTTPS checkbox is enabled to be toggled.  Remember to select the setting you need based on if you are proxying the DNS record with Cloudflare [Set up DNS](set-up-dns)
2. At this point your page should be available by going to your custom domain.  Unless you've published something else, you should now see the same very basic single line "Hello world" in your browser.  You can now start coding a better home page and "Hello world" will be replaced as you push it to the main branch.  This will give you the ability to code your own site, but setting up Jekyll is a good next step [Set up Jeykll](jekyll/set-up-jekyll)
