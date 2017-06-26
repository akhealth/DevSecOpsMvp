# Git branching strategy

We will have two long-lived git branches, `master` and `staging`.

`master` will continuously deploy to our production environment.

`staging` will continuously deploy to our staging environment.
Our staging environment exists as an Azure AppService [Deployment Slot](http://blog.amitapple.com/post/2014/11/azure-websites-slots/)

## Starting new work

When someone begins new work, they cut a new branch from `staging` and name it after their work, perhaps `feature1`.  New changes are pushed to the feature branch origin (VSTS) often. CI is configured to build all branches, new commits to `feature1` will trigger CI (not CD).

## Merging to `staging`

When new work is complete, we set up a Pull Request (PR) from `feature1` to `staging`. Discussion about, and approval of changes happens in the PR interface in VSTS.

Once this new work is approved we close the PR, which merges the code.
From here, our CI pipeline will build the new changes on the `staging` branch.  Next, our CD pipeline will deploy the new work to our staging environment.

## Merging to `master`

Once a new body of work is merged to `staging` (likely via multiple PRs) and any manual QA work has finished in the staging environment, we set up a PR from `staging` to `master`.

This constitutes a new production release.  Any last-minute discussion, as well as approval happens in the PR interface. Once approved and merged, CI runs for `master`.  Finally, CD runs and deploys the `master` branch to the production environment.

## Race conditions on merges to staging

Imagine two PRs called A and B are open against the `staging` branch. The two PRs both change code in the same file. Now, we merge PR A to staging.  After this merge PR B will report that it is "unmergeable" in VSTS.  This is because `staging` contains the changes from PR A, but PR B does not contain those changes -- git doesn't know what to do.

In this case we have a couple options.

1. Rebase: `git rebase B_branch staging`.  Rebasing the branch replays all of the commits from B on top of the _new_ `staging` branch (which now contains changes from A). Rebasing is the preferred method for handling these issues.  Push the `B_branch` and you'll be able to use VSTS to close the PR.
2. Manual conflict resolution. Instead of using the VSTS UI to merge the PR, execute the merge locally. `git checkout staging && git merge B_branch`. Git will report merge conflicts, which you can resolve locally, manually, using your editor.  When you're done push the `staging` branch and VSTS will automatically close the open PR.

## Patching production/master

Imagine that many PRs have been merged to `staging`, and you find a problem in production that needs a quick fix. At this point `staging` has moved far past `master`.  In this case we code the fix to production in a new branch cut from `master`, maybe called `prod_fix`. We set up a PR against `master` for reiew and discussion.

Any QA or manual testing will take place in a one-off environment deployed from the `prod_fix` branch; with the Azure PaaS we could manually deploy to an empty Deployment Slot. Once the PR on `master` is merged CI/CD takes care of deployment to the production environment.

Now we have to bring those new changes in master back into staging.  We use rebase again: `git rebase staging master`.