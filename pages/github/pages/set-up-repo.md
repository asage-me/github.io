---
layout: page
title: Set Up Repo
---

Here are the [GitHub Docs](https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site) for GitHub Pages

1. Create a new GitHub repo
2. Name it `(GitHub username).github.io` - basically just name it github.io since your username should already be filled in
3. Install VSCode and Git for Windows
4. In VSCode click source control on the left menu bar and click clone repository - if you don't see this you may have to relaunch VSCode if you had it open while installing Git
5. Sign in with GitHub
   - Click the accounts icon above the settings cog in the bottom left to sign in
6. When your repos load at the top, click the github.io repo you created then select a location to clone to.  I use OneDrive so I can just open the folder on other devices but using a standard storage location and pulling the repo from other machines works just as well
7. Create a new file called index.html and just put some text in it.  Hello world is a good first test
8. Save the file then in source control click the down arrow next to Commit.  Click Commit & Push
9. You will get a warning that there are no staged changes to commit.  This is fine, since we did not commit anything first.  Click the Yes button.  Later on, as you are working on files, it is a good idea to regularly commit your changes to a dev branch so you can better track and test your changes.  Each commit will have a commit message that should describe what it is for, for example: adding a feature, removing a feature, or fixing a bug.  It is helpful to reference an issue or project number if there is one.
  - After you click Yes, you should see a new tab open, this is your commit message.  Below the comments (lines that start with #) put in whatever you would like to show up as your commit message.  Typically with new files "Initial commit" is sufficient.  Once you have something in there save the file then click the check mark in the upper right to complete the push.  Note: the push will hang until this is completed
  - If you get an error that says `Make sure you configure your "user.name" and "user.email" in git.` click the Open Git Log button
    - Scroll up a little in the Git Log and you should see a line that says Author identity unknown.  A little below that you should see the 2 commands you need to set your name and email.  Copy those to a note pad, edit to contain the values you want, then go back to VSCode.  Where you scrolled up in the Git logs (in the OUTPUT tab) you should see another tab called Terminal.  Click that and paste the 2 commands in to set the values - alternatively you can just paste it in a PowerShell window but the terminal here is handy to use.  The 2 commands should be
      - `git config --global user.email "your@example.com"`
      - `git config --global user.name "Your Name"`
    - Once those are set go ahead and do a Commit & Push again, following the steps above for the commit message (this is needed for every commit)
10. Now that the repo is set up and you have something to serve, the page should load.  Go to your browser and load the URL for your page - (GitHub username).github.io  If you followed the steps above you should see a very basic single line "Hello world" in your browser
11. Next, set up your custom domain if you have one [Set up DNS](set-up-dns)
