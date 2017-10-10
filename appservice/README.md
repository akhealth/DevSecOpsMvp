# Azure App Service

Azure App Service is Azure's PaaS.  You bring the application and they do everything else: infrastructure, logging, monitoring, scaling, etc.

See App Service [Architecture](/appservice/Architecture.md) and [Security](/appservice/Security.md) for information about those topics.

## Deployment

Deployment Slots are like extra environments in the Azure PaaS. We might name ours `staging`, `development` or `pre-prod`.  Deployment slots each get their own url.

You can associate each slot with a git branch by adding an App Setting called `deployment_branch`. Be sure to mark any slot-specific settings like this as a "Slot Setting". This way we can deploy the `staging` branch to the `staging` slot.

When you create a Deployment Slot, the "Copy Configuration from" option lets you copy App Settings into the new environment.

You must also add your existing Hybrid Connection(s) to each new Deployment Slot created.  

### One-off deployment

To set this up select Deployment Options and Local Git.
Get the git remote url 
```
az webapp deployment source config-local-git --name ProtoWebAPI --resource-group Prototype --slot development --query url --output tsv
```
Add the url it returns as a remote
```
git remote add azure-development <url>
```
See `create-app-service.bash` for an automated way to do this.

Now, `git push azure-development development` to deploy to the development slot.

## Automation

### TF/ARM
If we need to automate the tooling that creates appservices, perhaps for creating new ones in a build pipeline, we'll need to use Terraform or raw ARM. Terraform does not support  this specific resource yet, but it does support [treating raw ARM templates as a resource](https://www.terraform.io/docs/providers/azurerm/r/template_deployment.html).

I've also included the raw ARM that specifies our current App-service in `appservice-ARM.json`.

### CLI

As usual, the `az` cli is lightest-weight solution.  This might be OK if we don't end up needing to automate the creation of these app services.

Customize and load your ENV
```sh
cp .env.bash.example .env.bash
source .env.bash
```

See `create-app-service.bash` to create the AppService, and for an example of deploying to the service using `git push`


## Some other cool tricks
```bash
az webapp stop --name $service_name --resource-group $group_name
az webapp start
az webapp restart
az webapp log tail --name $service_name --resource-group $group_name
```

Note: It can take a while (5 min?) for log streams to start appearing.  Sometimes it happens very fast.

## Debugging

There are a couple ways to debug 500 errors in AppService.

0. The best and easiest way to get full errors is to set an environment variable `ASPNETCORE_ENVIRONMENT` to `Development`.  This can be done in the portal under AppService -> Appliation Settings -> App Settings. Setting this ENV variable will make your stack traces visible to the whole world.
1. The "Diagnostic Logs" screen has FTP endpoints where you can view all logs, etc.  This is kinda klunky.
2. Appliation Insights is a feature that lets us instrument apps, including 500 errors. This takes extra setup that we haven't done.
3. We can include a `web.config` with `CustomErrors-off` in our app.  It gets merged with the AppService file. I can see correct results in the deployed file... still this seems to work for others but not me.

## Notes

If you run into an issue where deploying from your local machine is giving you `403` error, double check the `DEPLOY_USER` and `DEPLOY_PASS` values in the script. Check them against the portal:  Azure Apps -> Deployment Credentials.  You potentially need to re-set the credentials from the portal UI.  I've seen this once, it seems like some sort of caching issue on the Azure side when I destroy/re-create identical resources.