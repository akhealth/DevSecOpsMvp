# VSTS Build Pipeline

Previously, XAML templates were used to define TFS build pipelines.
XAML is now deprecated. VSTS doesn't have a good replacement (yet?).

In VSTS on the Builds screen you can click the "..." menu for an existing build and "Save as a template...".  This could be useful for managing many similar builds, but it doesn't help us start from scratch.

Another option worth investigating is the VSTS REST API.  It looks like it supports creating build definitions and other things: https://www.visualstudio.com/en-us/docs/integrate/api/build/definitions

Setting up VSTS Builds from scratch isn't terribly hard. It should take around 15 min, so I'll just document.

## General Build settings

These apply to all builds.

- Options -> Default agent queue should be "Hosted VS2017".
- Triggers -> Continuous Integration is "Enabled", at least "master" branch is selected.

**Note** You can set the branch to `*`, which will build commits to all branches. It might make sense to have one build definition for "master" and one for "*". The master build may export to open source, and other small differences.

## .NET Core settings

These apply to .NET Core apps

- "+New" -> ASP.Net Core.  This adds Restore, Build, Test, Publish, and Publish Artifact tasks.
- I think because I didn't follow convention in our demo project, I have to change the "Test" task's "Project(s)" setting to "*\*/\*.csproj".

## Powershell

We can do lots of things in the build pipeline with Powershell. Here are a few:

- Log in to Azure using powershell cmdlets -- this opens up a whole world of Azure management from Active Directory to VPNs. 
- Use other system tools like `git`


Here are some best practices

- Run powershell scripts from your repo, don't do "inline" scripting.
- Declare secrets and other variables as Params in your script
- Inputs for Params come from VSTS/Build Variables. Click the lock to encrypt and hide secret values.
- Uncheck the "Fail on Standard Error" feature of VSTS build steps if your script should _not_ consider writing to STDERR a failure, and instead soley use `$LASTEXITCODE`.  This is handy in `push-to-github.ps1` because git always writes to STDERR. 

This repo contains a couple examples of Powershell scripts meant to be run as a build step.
See `dsc/upload-dsc.ps1`, `opensource/push-to-github.ps1`, `deploy/start-azure-app.ps1`.


# VSTS Release Pipeline

The build and release pipelines function very similiarly in VSTS.  We have a release set up that targets the Azure AppService (see `/appservice`). Here's how to recreate it:

- On the Releases page, click "+" -> Create release definition.
- Select Tempalte "Azure App Service Deployment".
- Select the Source Build that you set up above. This release will happen after the Source Build successfully finishes.
- Specify the auth for the "Deploy Azure App Service" task
- Add an "Azure Powershell script"* to stop the app before the deploy
- Add an "Azure Powershell script"* to star the app after the deploy

***Types of Powershell scripts**: There are a couple kinds of Powershell scripts that you can add as tasks in both build and release pipelines:

1) Azure Powershell: this runs PS commands in the context of your Azure subscription, and must be authenticated in its settings pane.  This method lets us write simple scripts like this one-liner start command mentioned above: `Start-AzureRmWebapp -Name akstaging -ResourceGroupName akstaging`.

2) (Plain) Powershell: here you must manage your own Azure context. See `dsc/upload-dsc.ps1` for an example of getting context. This option makes for longer scripts, but is arguably more obvious/visible.
