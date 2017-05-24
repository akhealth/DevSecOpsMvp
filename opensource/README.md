# OpenSource

We value open source. VSTS doesn't really do open source but Github does.
So we push all changes to `master` branch in VSTS to a repository in Github as a build task.

`push-to-github.ps1` is a script to run from the build pipeline.
Interestingly, if github responds "Everything up-to-date", the return code is read as an error in VSTS/build. This might be good?