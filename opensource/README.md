# OpenSource

We value open source. VSTS doesn't really do open source but Github does.
So we push all changes to `master` branch in VSTS to a repository in Github as a build task.

## Running the script
`push-to-github.ps1` is a script to run from the build pipeline.

Script variables are set up in VSTS/build.  The $token is a Github "Personal access token".
Generate one here: [https://github.com/settings/tokens](https://github.com/settings/tokens)


Interestingly, if github responds "Everything up-to-date", the return code is read as an error in VSTS/build. This might be good?

## Incorporating downstream changes

Someone may file a PR on our open-source repo that we want to include in our private upstream repo.  One way to accept those changes is:

1. Discuss, approve, and merge the PR in the open-source downstream repo, i.e. github.
2. Add a `oss-github` remote to your VSTS repo and cherry-pick the commit(s).

```sh
# From your VSTS repo:
git remote add oss-github git@github.com:AlaskaDHSS/DevSecOpsMvp.git
git fetch oss-github
git cherry-pick <targeted-commit>
git push
```