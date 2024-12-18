---
layout: page
title: Set Up DNS
---

Here are the [GitHub Docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site) for using a custom domain name

1. Log in to your DNS nameserver
   - I recommend Cloudflare for both the registrar and nameserver.  If you did not purchase your domain through Cloudflare, you can either use them just for the nameserver or you can transfer your domain to them.  They sell domain names at cost and offer a lot of nice features, such as email, a lot of which are free
2. At this point you can choose whether you want to use a Cloudflare proxied DNS record or not.  There are pros and cons to each.  If you do not proxy the record it makes SSL much easier, but you do not get the advanced features of Cloudflare such as WAF, page rules, reports, pretty much anything in the Cloudflare dashboard.  You can still proxy the record, but you have to disable the Enforce HTTPS checkbox in the GitHub Pages settings and set the Cloudflare SSL/TLS mode to flexible for that domain.  This means when someone visits your site, the data is encrypted from them to the Cloudflare proxy, but from Cloudflare to GitHub the traffic is not encrypted.
   - The reason for this is that GitHub needs your DNS record to be publicly set to (GitHub username).github.io for Let's Encrypt to issue them a certificate for your domain.  If GitHub cannot prove you want them to have a certificate for your domain, Let's Encrypt will not issue them a certificate.  This is for security.  You don't ever want an unauthorized party to have a valid certificate for you domain.  When you set the DNS record to proxy mode and do a dig or nslookup for the value, you will get a response with a Cloudflare server, not GitHub.  Another way around this is to change your DNS record from proxy to not proxied every 90 days, let GitHub request the certificate, then change it back.  However, this is a lot of manual work that needs to be scheduled and completed before the certificate expires, or your site will not be accessible
3. Once you decide on proxied/not proxied, create a CNAME entry for the apex of your domain, example.com, and point it to your GitHub page (GitHub username).github.io.  If you are not using Cloudflare you may need to make this an ANAME or ALIAS.  In cloudflare you will see a note that says "CNAME records normally can not be on the zone apex. We use CNAME flattening to make it possible. [Learn more](https://developers.cloudflare.com/dns/additional-options/cname-flattening/)."
4. If you also want the www record to point to your GitHub page, create a second CNAME entry and point it to the same thing - (GitHub username).github.io.  Decide at this point if you want www or the apex to be the domain you want to use.  www will forward to the apex and vice versa.  If you look at the URL for this page, you can see I chose www to be my GitHub page domain, but going to [https://asage.dev](https://asage.dev) will automatically redirect you to [https://www.asage.dev](https://www.asage.dev).  The GitHub documentation says the forward only works with apex/www records, which is somewhat true.  After looking at the process, what actually happens is you get a certificate error for anything other than those 2 records.  GitHub generates a certificate for whatever you put in as your custom domain and also with www. in front of it.  This can be verified by looking at the Subject Alternate Name of the certificate
5. Add your custom domain to your Verified domains in GitHub [here](https://github.com/settings/pages)
   - Click Add a domain
     - ![Add Domain](/assets/img/github/pages/add-domain.png)
   - Enter your custom domain name and click Add domain
     - ![Add Domain](/assets/img/github/pages/add-domain-2.png)
   - Copy the TXT record name and value and add it to your DNS entries on your nameserver
     > Depending on your nameserver it could take up to 24 hours for verification to be successful, but I have found that Cloudflare is usually active within a minute or two.  You can go to a DNS Propagation checker like [https://www.whatsmydns.net](https://www.whatsmydns.net/) to see the status of your changes
     {: .prompt-tip }
     - ![GitHub TXT Record](/assets/img/github/pages/github-txt-record.png)
     - ![Cloudflare TXT Record](/assets/img/github/pages/cloudflare-txt-record.png)
   - Once the changes are active click Verify to verify your domain.  Github will periodically check this value, so leave it in your DNS records
     - ![TXT Record Propagation Check](/assets/img/github/pages/txt-propagation-check.png)
     - ![Successfully Verified](/assets/img/github/pages/successfully-verified.png)
6. The custom domain will be set on GitHub Pages later in the Jekyll guide
