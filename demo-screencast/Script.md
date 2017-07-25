# Script

Title: DevOps change management overview

## Part 1: Starting new work

**Open VSTS HOME page**

> We're using Microsoft Visual Studio Team Services for project management, source control, and a continuous integration build pipeline. We'll touch on each, but for now we start with project management.

> When I'm ready for new work I choose an item assigned to me in our current sprint's kanban board. 

Examine one card, mark it "in progress"

> We use Git for source control. The first thing I do is make sure I have the latest code. I'll check out the staging branch and cut a new feature branch from there.

`git checkout staging && git pull && git branch update-welcome-message`

> Now I'm ready to make the changes from my story.

```
code .  #Then make the change and save
git status
git diff
```

> There are my changes. It all looks good so I'm ready to commit them to my branch.

```
git add .
git commit
Closes #<VSTS-Number>. Did _________
git log
```

## Part 2: Continuous Integration

> VSTS has a continuous integration build server.  That just means it can listen to our git commits for changes, then do things like run tests and security scans.  It can even deploy our app. 

> We committed our changes to our local repo, but we still need to push them to VSTS.

`git push`

> We should be able to see our CI build now.

**Open VSTS Builds page**
Watch build until a test fails

> Uh oh, we didn't pass the build.  I wonder what happened... Oh, a test failed.
> Before I pushed my changes I should have made sure that tests were passing locally. Let's do that now.

`dotnet test`

> Ok, let's fix this test.

Fix test
```
dotnet test
git add .
git commit
git push
```
Watch build succeed in VSTS.

> Hopefully you can see how having good test coverage, and running tests on every push can catch lots of errors.  Even security can have its place at every push. 

Explore Veracode scan results

> Your teams will be alerted when builds succeed or fail.

## Part 3: Pull Requests

> Now that I'm done with my changes and my build is passing my code needs to be reviewed. We use Pull Requests for this.  It might be easiest to just see it in action.

**Open new PR page**

> We'll create a new Pull Request.  We want to merge the changes from my feature branch into the staging branch, which corresponds with the staging environment.

Set up PR

> There are conditions like number of reviewers that must be met before a PR can be merged. So we'll dust our hands and come back once other people have had a chance to review our changes.

## Part 4: Continuous Delivery

Note: bug a couple people to review and approve the PR.

View the PR feedback

> We've gotten good feedback on our PR.  If there were any issues we would push more commits onto our feature branch, which would then be reflected in our PR.

> Usually the person that opens a PR does not merge it, but in this case I'm going to.  Changes to the staging branch trigger our continuos delivery server.  This is similar to CI that we saw before, except the goal is deployment.

> We're hosting our staging environment in Microsoft Azure's App Service -- a platform as a service running in Azure. 

Visit app running in app service, see the old changes.

Merge PR

> Now CI will run on the staging branch.  We expect the same results.  A successful build on the staging branch triggers CD

Watch CI and CD

Visit app again and verify the change is there.

> This is how changes are made and monitored in our environment. 