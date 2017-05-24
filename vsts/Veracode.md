# Veracode Visual Studio Team Services Integration
See [Instructions for the VSTS Veracode plugin](https://marketplace.visualstudio.com/items?itemName=Veracode.veracode-vsts-build-extension&targetId=3a6fdb87-28e4-40c1-95d9-87028e93af8f) for information used to create the following procedure.  You will need to do the following to integrate VSTS and Veracode:

## Veracode configuration
1. Obtain a valid Veracode login with access to the State of Alaska portal and the ARIES-WP application
2. Login to [Veracode portal](https://analysiscenter.veracode.com)
3. Hover over the "State of Alaska" dropdown link - a menu drops down
4. Click on "API Credentials" menu item - the _API Credentials_ page loads
5. Click on "Generate API Credentials, this will create an API ID and Secret Key
6. Copy and store these credentials in a secure place (after creation you can revoke the credentials, but cannot access them)
7. Go to the target application in Veracode and ensure a Sandbox is setup associated with the API credentials.

VSTS Veracode plugin configuration
1. Add the "Upload and scan" Veracode plugin task to the VSTS build definition
2. In the Upload and scan Veracode VSTS build plugin task, select the _Endpoint_ connection source from the _Select Connection Source_ radio button options
3. Click the _+_ symbol to the right of the _Select Endpoint_ field
4. Choose the _Veracode Endpoint_ radio button
5. Name the endpoint
6. Paste the Veracode API ID obtained in step 4 of Veracode configuration into the _ID_ field
7. Paste the Veracode API Secret Key obtained in step 4 of Veracode configuration into the _key_ field
8. Click _OK_
9. Create a build definition variable called Veracode.AppName, e.g., "ARIES-WP" as the value (note: this ties the code scan to the licensed app in Veracode, in these instructions the example "ARIES-WP" ties to the Aries worker portal license.  Work with the DHSS Veracode adminstrator if setting up for scan of something besides the ARIES worker portal.)
10. In the Upload and scan Veracode VSTS build plugin task, enter _$(Veracode.AppName)_ into the _Application Name_ field
11. Expand _Advanced Scan Settings_ and enter the name of the Veracode Sandbox
12. Enable the Upload and scan Veracode VSTS build plugin task
13. Click the _Save & queue_ button to save the build definition and queue a build to test the task

## Troubleshooting
### No files found
If VSTS build reports the build artifacts were not found, ensure there is a publish step that moves the build artifacts to the Build.ArtifactStagingDirectory
