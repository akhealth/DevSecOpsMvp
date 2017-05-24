# OpenSource

We value open source. VSTS doesn't really do open source but Github does.
So we push all changes to `master` branch in VSTS to a repository in Github as a build task.

## Running the script
`push-to-github.ps1` is a script to run from the build pipeline.

Script variables are set up in VSTS/build.  The $token is a Github "Personal access token".
Generate one here: [https://github.com/settings/tokens](https://github.com/settings/tokens)


Interestingly, if github responds "Everything up-to-date", the return code is read as an error in VSTS/build. This might be good?