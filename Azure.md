# Azure

## Permissions needed in order to create infrastructure

Adding resources to Azure requires "Contributor" permissions.  This can be granted in two ways:
- At the Azure subscription level
- At the Azure resource group level 

### Add an Azure subcription contributor
1.  Select _More services >_ from the bottom of the Azure Portal services menu (the services list panel opens)
2.  Search for "Subscriptions" and click the Subscriptions tile (the Subscriptions list panel opens)
3.  Click on the subscription you want to add a new contributor to (the management panel for that subscription opens)
4.  Click on _Access control (IAM)_ (the access management panel opens)
5.  Click on the _Roles_ toolbar button (the roles panel opens)
6.  Click on the _Contributor_ role (the contributor group membership panel opens)
7.  Add the user to the group and close the panels

### Add an Azure resource group contributor
1.  Select _Resource groups_ from the Azure Portal services menu
2.  Click on the resource group you want to add a new contributor to (the management panel for that resource group opens)
3.  _Continue as from step 4 of the procedure for adding an Azure subscription contributor_
