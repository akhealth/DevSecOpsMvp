# Azure App Service

Azure App Service is Azure's PaaS.  You bring the application and they do everything else: infrastructure, logging, monitoring, scaling, etc.

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
az appservice web stop --name $service_name --resource-group $group_name
az appservice web start
az appservice web restart
az appservice web log tail
```

## Notes

If you run into an issue where deploying from your local machine is giving you `403` error, double check the `DEPLOY_USER` and `DEPLOY_PASS` values in the script. Check them against the portal:  Azure Apps -> Deployment Credentials.  You potentially need to re-set the credentials from the portal UI.  I've seen this once, it seems like some sort of caching issue on the Azure side when I destroy/re-create identical resources.