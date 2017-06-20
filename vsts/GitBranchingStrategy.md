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