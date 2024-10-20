---
layout: page
title: Pages Settings
---

[GitHub Docs - publishing source](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)  
[GitHub Docs - custom DNS](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/about-custom-domains-and-github-pages)  
[GitHub Docs - HTTPS](https://docs.github.com/en/pages/getting-started-with-github-pages/securing-your-github-pages-site-with-https)

- Go to your GitHub Pages repo on GitHub `https://github.com/(your username)/github.io/settings`
   - At the top, click the settings tab
     - ![Settings](/assets/img/github/pages/pages-settings.png)
   - On the left menu, click Pages under Code and automation
     - ![Pages](/assets/img/github/pages/pages.png)
   - For Build and deployment, select GitHub Actions
     - ![Build and deployment](/assets/img/github/pages/build-and-deployment.png)
   - Under Custom domain, enter the domain you want to use - whatever you set up in [Set up DNS](/pages/github/pages/set-up-dns)
     - ![Custom domain](/assets/img/github/pages/custom-domain.png)
   - Click Save then wait for the DNS Check to finish
   - Once the DNS check is done a Let's Encrypt certificate will be generated for your custom domain.  This can take a little bit and sometime the page has to be refreshed before the Enforce HTTPS checkbox is enabled to be toggled.  Remember to select the setting you need based on if you are proxying the DNS record with Cloudflare [Set up DNS](/pages/github/pages/set-up-dns)
     - ![Enforce HTTPS](/assets/img/github/pages/enforce-https.png)
