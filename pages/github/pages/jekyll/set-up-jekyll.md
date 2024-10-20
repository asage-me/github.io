---
layout: page
title: Set Up Jekyll
---

This guide will walk you through hosting a page on a custom domain for free through GitHub Pages  
Click [here](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/about-github-pages-and-jekyll) for GitHub docs

1. You will need the [Jekyll Prerequisites](/pages/github/pages/jekyll/jekyll-prerequisites) for this guide
2. I chose to go with the [Chripy theme](https://chirpy.cotes.page/) because it fits most of what I wanted in the template.  Dark mode and blog like were the 2 main things I was looking for.  [Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/docs/installation/) was a very close second.  In my opinion, Chirpy is much more complete on the publishing site.  I really like how the author took the time to set up a preconfigured Dev Container and GitHub workflows.  Also, the docs for setup are very easy to follow
3. From the [starter repo](https://github.com/cotes2020/chirpy-starter) choose Use this template, then Create a new repository
   - ![Create New Repo.png](/assets/img/github/pages/jekyll/create-new-repo.png)
   - Name it github.io and keep it public, then click Create repository
   - ![Name Repo](/assets/img/github/pages/jekyll/name-repo.png)
4. Open Docker Desktop so the services that are needed for Dev Containers are started
5. Open VSCode and clone the repo
   - Create a local directory for where you want to store your GitHub repos
   - Press `F1` or `Ctrl+Shift+P` (command palette) and type in git clone in the search bar
     - ![Git Clone](/assets/img/github/pages/jekyll/git-clone.png)
   - Choose Clone from GitHub
     - ![Clone From Github](/assets/img/github/pages/jekyll/clone-from-github.png)
   - If you haven't signed in yet, allow VSCode to sign in to GitHub
     - ![Sign in Using Github](/assets/img/github/pages/jekyll/sign-in-using-github.png)
     - Follow browser actions to log in
   - Choose the repo we just created `github.io`
     - ![Select Repo to Clone](/assets/img/github/pages/jekyll/select-repo-to-clone.png)
   - Choose the folder you created.  Cloning the repo will create a sub directory here with the name of the repo so as long as you don't have conflicting names you will not have any naming issues 
   - Click Open to open the cloned repo
     - ![Open Cloned Repo](/assets/img/github/pages/jekyll/open-cloned-repo.png)
   - It will ask you if you trust the authors, I hope you do
   - You should see a pop up in the bottom right telling you VSCode detected a Dev Container config file and it will ask you if you want to use it.  Click on Clone in Volume
     - ![Reopen in Container](/assets/img/github/pages/jekyll/reopen-in-container.png)
        > Any changes you make in the Dev Container that are not pushed to the remote repo will ONLY be stored in your docker volume and not synced to any other device.  This means that if you delete the volume, those changes are gone.  It is a good idea to periodically open the folder you created above with VSCode and sync it to your computer so you have a local backup just in case something happens
        {: .prompt-danger }
   - You will get a security pop up.  As long as you're not using Vlad's template you should be ok
     - ![Trust Dev Container Authors](/assets/img/github/pages/jekyll/trust-dev-container-authors.png)
   - You should see the page refresh.  In the top left the you should see an empty explorer and in the bottom right it will tell you it is connecting to the dev container
     - ![Explorer](/assets/img/github/pages/jekyll/explorer.png)
     - ![Connecting to Dev Container](/assets/img/github/pages/jekyll/connecting-to-dev-container.png)
   - After a little bit you should see all the files from your repo show up in the explorer and the Terminal will open to show you the Docker build status.  Wait for it to get through all the steps and it will say `Done. Press any key to close the terminal.`  You can press a key to close if you want, we will reopen the terminal later
     - ![Terminal Install Output](/assets/img/github/pages/jekyll/terminal-install-output.png)
   - At this point everything you need to start making changes to your site is ready.  [The docs for config](https://chirpy.cotes.page/posts/getting-started/#configuration) leave a bit to be desired, but fortunately the `_config.yml` is straight forward.  Here are the main points to hit:
     - `timezone: America/New_York`
     - `title: ASage.dev`
     - `tagline: A blog for semi-useful stuff`
     - The line under description: `Sometimes I document my interesting encounters with Technology.`
     - `url: "https://www.asage.dev"`
     - Under github:  
       - `username: asagedev # change to your GitHub username`
     - Comment the Twitter account with #
     - Under Social
       - `name: Adam Sage`
       - `email: public@asage.dev # change to your email address`
       - Links
         - Comment Twitter account line
         - `- https://github.com/asagedev`
     - `theme_mode: dark # [light | dark]`
     - !!! Project for later, set up Site Verification Settings, Web Analytics Settings, CDN, and Comments !!!
   - Save the file, then build the site to preview
     - After you save you should see an M on `_config.yml`.  This means the file has been modified locally but has not been committed.  We will want to test these changes before we do that, so click Terminal and then `Run Build Task...` or press `Ctrl+Shift+B`
       - ![Open New Terminal](/assets/img/github/pages/jekyll/open-new-terminal.png)
     - You will see the Terminal open up again and when it's done building you'll get a popup to Open in Browser.  Click the button to see what your changes did to your page
       - ![Terminal Window](/assets/img/github/pages/jekyll/terminal-window.png)
     - Once you are happy with your changes, click the Source Control button on the left, or press `Ctrl+Shift+G`
       - ![Source Button](/assets/img/github/pages/jekyll/source-button.png)
     - Make sure the only files you changed are the ones listed.  If there is something other than `_config.yml` either revert it or modify the commit message later in the guide
       - ![Changed Files](/assets/img/github/pages/jekyll/changed-files.png)
     - Click the + on the line for `_config.yml` to stage the changes, then you can close the editor for `_config.yml`.  Staging tells git we made a change to the file and want to commit it.  If you don't stage anything VSCode is smart enough to ask you if you want to stage and commit everything at once
     - Open the file `Gemfile` and add this line to the end of the file `gem 'jekyll-compose', group: [:jekyll_plugins]` to install [Jekyll-Compose](https://github.com/jekyll/jekyll-compose).  This Jekyll plugin will be used to create templates for new posts
       - ![Gemfile](/assets/img/github/pages/jekyll/gemfile.png)
       - After you save the file, open a normal terminal and type in bundle to install it
       - ![Bundle Install](/assets/img/github/pages/jekyll/bundle-install.png)
     - Go back to the Source Control and stage the changes for `Gemfile`
     - Open the terminal again and enter the following command to generate a new post `bundle exec jekyll post "My First Post" --timestamp-format "%Y-%m-%d %H:%M:%S %z"`
       - ![Jekyll Compose New Post](/assets/img/github/pages/jekyll/jekyll-compose-new-post.png)
     - Open the new post and add some text
       - ![Edit Post](/assets/img/github/pages/jekyll/edit-post.png)
     - Run the build task again and refresh your browser page to test the change.  If you still have one running from before it should automatically detect the changes and rebuild.  If not, just click the trash can icon to stop the container, then run the build task again
       - ![Stop Jekyll Server Container](/assets/img/github/pages/jekyll/stop-jekyll-server-container.png)
       - The line above this is the terminal for the container.  You can close and reopen terminals as you need them as well, but it's pretty rare to need the terminal
     - You should see a new post on the home page, and you should see the post after clicking it
       - ![New Post](/assets/img/github/pages/jekyll/new-post.png)
       - ![View Post](/assets/img/github/pages/jekyll/view-post.png)
     - Go back to the Source Control and stage the changes for `Gemfile`
   - Set up the Pages settings for the repo
     - [Pages Settings](/pages/github/pages/pages-settings)
   - If you're not using Linux, run this command in your terminal in VSCode `bundle lock --add-platform x86_64-linux`
   - If you are happy with your changes, go ahead and commit them and push to the repo:
      >Pay attention to the bottom right.  If the Prettier icon is red you likely have a formatting error  
      >![Prettier Error Icon](/assets/img/github/pages/jekyll/prettier-error-icon.png)  
      >Click the red icon to show you where the issue is.  Scroll up until you see the error  
      >![Prettier Error Message](/assets/img/github/pages/jekyll/prettier-error-message.png)  
      >When you fix the error, resave and the red icon should go away.  Prettier checks are triggered on saves
      {: .prompt-tip }
   - Enter a descriptive message for the commit, for this simple commit `Set up config and publish first post` will be good.
   - Click the Commit button and enter your GPG key - you should have [Commit Signing](/pages/github/commit-signing) set up
   - After the commit is complete, sync changes to the remote repo (GitHub)
     - ![Sync Changes](/assets/img/github/pages/jekyll/sync-changes.png)
   - Back on the GitHub repo, you should see some files now have a new commit message, and a yellow dot next to the latest commit message at the top.  This dot means GitHub is building the changes.  If you wait a little while and click it, you will see the status has changes to success and on a page refresh the dot will turn in to a green check mark
     - ![View Commit On GitHub](/assets/img/github/pages/jekyll/view-commit-on-github.png)
     - ![Build Checks Passed](/assets/img/github/pages/jekyll/build-checks-passed.png)
   - You can also see build status by going to Actions
     - ![Build Status](/assets/img/github/pages/jekyll/build-status.png)
     - You can see your build action errors by clicking on the commit name, then the error in the Annotations.  The most common error will be links that are broken.  The initial commit always fails because the config is not yet correct
       - ![Actions Error Commit Name](/assets/img/github/pages/jekyll/actions-error-commit-name.png)
       - ![Actions Error Annotations](/assets/img/github/pages/jekyll/actions-error-annotations.png)
       - ![Actions Errors](/assets/img/github/pages/jekyll/actions-errors.png)
   - Once you have a successful build you should see your changes live on your site
     - ![Live Site](/assets/img/github/pages/jekyll/live-site.png)
6. Add a plugin to make all external links open in a new tab
   - Follow instructions [here](https://mrinalcs.github.io/open-external-links-in-new-tab-in-jekyll) copied below as well, in case the page disappears
     - I chose to not have my links be appended with `ref=site.com` or the `rel` tag so I modified the code a bit.  Below is what I am using
      ```ruby
      [:documents, :pages].each do |hook|
        Jekyll::Hooks.register hook, :post_render do |item|
          content = item.output
          site_url = item.site.config['url']
          whitelist = [site_url, '/', 'localhost', 'mailto:', 'tel:']  # whitelist domains

          # Add target="_blank" to external links
          content.gsub!(%r{<a\s+href="((?!#{whitelist.map { |d| Regexp.escape(d) }.join('|')})[^"]+)"(?![^>]*rel=)},
                  "<a href=\"\\1\" target=\"_blank\"")
          # Update the item content
          item.output = content
        end
      end
      ```
       - This is not in the code below so modify accordingly
    - Create file `_plugins/external_links.rb` and paste in the code below
      ```ruby
      [:documents, :pages].each do |hook|
        Jekyll::Hooks.register hook, :post_render do |item|
          if item.output_ext == ".html"
            content = item.output
            site_url = item.site.config['url']

            # Add rel="nofollow noopener noreferrer" to external anchor tags and ref parameter
            content.gsub!(%r{<a\s+href="((?!mailto:|tel:|#{Regexp.escape(site_url)}|http://localhost:4000|/|#)[^"]+)"(?![^>]*rel=)},
                          "<a href=\"\\1?ref=#{site_url.gsub('https://', '')}\" target=\"_blank\" rel=\"nofollow noopener noreferrer\"")
            # Update the item content
            item.output = content
          end
        end
      end
      ```
   - Explaination of the code above
     - The `[:documents, :pages].each do |hook|` line iterates over an array containing `:documents` and `:pages`. This suggests it’s registering a hook for both Jekyll documents and pages.
     - `content.gsub!(%r{<a\s+href="((?!mailto:|tel:|#{Regexp.escape(site_url)}|http://localhost:4000|/|#)[^"]+)"(?![^>]*rel=):` Uses a regex to identify external links (not mailto, tel, internal links, or anchors) and adds `rel="nofollow noopener noreferrer"` attributes. It also appends a ref parameter with a simplified site URL.
   - Whitelisting domains
    - You may want to whitelist some domains. The whitelist array contains domains that should be excluded from having the `rel` attributes added. This ensures that trusted domains or local links do not have unnecessary attributes.
      ```ruby
      [:documents, :pages].each do |hook|
        Jekyll::Hooks.register hook, :post_render do |item|
          if item.output_ext == ".html"
            content = item.output
            site_url = item.site.config['url']
            whitelist = ['cloudinary.com', 'example.com', 'localhost', 'mailto:', 'tel:']  # whitelist domains

            # Add rel="nofollow noopener noreferrer" to external anchor tags and ref parameter
            content.gsub!(%r{<a\s+href="((?!#{whitelist.map { |d| Regexp.escape(d) }.join('|')})[^"]+)"(?![^>]*rel=)}, 
                          "<a href=\"\\1?ref=#{site_url.gsub('https://', '')}\" target=\"_blank\" rel=\"nofollow noopener noreferrer\"")
            # Update the item content
            item.output = content
          end
        end
      end
      ```
