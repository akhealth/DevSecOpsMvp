#Introduction 
This repository tracks assets of the minimum viable product for a DevOps continuous integration, continuous deployment pipeline for the [Alaska DHSS modernization project](https://github.com/18F/acq-alaska-dhss-modernization).  This project aims to transform the way Alaska approaches implementation and support activities for its mission critical technology products.  We plan to do this by taking deeper ownership of the product definition and the foundational processes and tools used in exchange for steeply reduced financial and functional risks of traditional, monolithic approaches.  The foundation of this will be a State managed DevOps pipeline.

#Why DevOps?
The following material is borrowed liberally, and extended significantly, from concepts in Ben Day's _DevOps Skills for Developers with Visual Studio & TFS 2015_ Pluralsight.com class.  It's a great class and worth checking out!
##For Everyone
Software development has made great strides over the last 10 years by employing methodologies like Agile and Scrum.  These methodologies envision a product, break that product into a backlog of incremental product improvements, prioritize that backlog and then create the product in small chunks of effort over short sprints of development time.  This approach drastically reduces risks and it allows the product team to react quickly when a priority changes, or a good product improvement idea doesn't deliver the expected results.

The problem with Agile and Scrum is that it's only half the story: how do we efficiently write software?  Agile and Scrum do really well answering that question, but when it comes to actually delivering software into production, Agile and Scrum are relatively mute.  Typically, this translates into the moment when the "development team" hands the written and tested software off to one or more operations teams.  These teams typically have no exposure to what it took to make the software work in development, integration or quality assurance environments, and have completely separate processes for how they build and configure the "equivalent" target production environment for the product.  Whether it is differences in process or differences in team members or both, this impedance mismatch between how software is developed and how it is actually delivered to customers creates a barrier between development and production that increases risks and slows down delivery time. The purpose of DevOps is to break down this barrier, improve quality and speed up delivery time.

DevOps is a mindset focused on:
- Reliability
- Repeatability
- Traceability
- Minimal or no manual intervention

DevOps is also a set of practices focused on automation:
- Automated build
- Automated test
- Automated deploy
- Automated monitoring
- Automated infrastructure (container tech, etc.)

Through this core story of automation, DevOps is always looking for new ways to eliminate human intervention.  Adding all of these capabilities up leads to "Continuous Deployment".

##For Security and audit
The coded configuration and automation focus of DevOps solves a number of important security challenges.  Automating infrastructure ensures that infrastructure configuration is known, prescribed and protected from configuration errors made by skipping installation and configuration steps or building up configurations inconsisently across peer level resources.  By automating build, test and deployment, changes are auditable from the time they are merged to the mainline all the way through the pipeline to production.  In turn, these capabilities tighten change control, and allow deploying change to production without direct access to production.  Thus direct, administrative production access is reduced to a smaller pool of staff who are only responsible for basic monitoring, and wider access can be handled on an audit exception basis.  Finally, automated testing lends itself to incorporation of security testing tools.  DevOps _does not_ directly simplify the documentation of security controls.  However, when adopted by both the development and operations organizations, the DevOps approach of coded installation and configuration institutionalizes visibility of how environments are configured, ensuring access to provable configuration documentation. 
TBD write out the story about controlled change and tamper proof change promotion pipelines.

##For Operations
DevOps focuses on visibility and repeatability, and it does so with quality of both the software product *and* the deployment products used to rapidly and consistently deploy the software.  Additionally, the emphasis on automating infrastructure affords the operations team to bring their own requirements to the table and realize those requirements through version controlled code and configuration artifacts.  Building servers and configuring infrastructure this way reduces or eliminates configuration drift and yields consistent and documented families of infrastructure resources.

##For Development
DevOps extends the proven practices of Agile and Scrum by removing deployment technical debt and de-risking the ultimate goal: delivering the product.  DevOps provides developers with the security/confidence of knowing that change can be delivered quickly, and there are no mystery variables that span the non-production and production environments. 

##For the Team
DevOps brings down the wall between development and operations, and puts everyone on the same team, providing equal visibility into changes aimed at both the customer products and the operating environment of those products.  Additionally, through automation, tight change control and limited need for direct access to production environments, DevOps realizes the solution to limited resources in IT organization that cannot support full separation of duties.

##For the customer
For the customer, DevOps yields a better product that is delivered faster than with traditional processes that separate development from oprations.

#Outcomes from DevOps
We believe that DevOps capabilities must support and include:
1.  A secure and consistent set of development, non-production and production environments
2.  Rapid onboarding of vendors and other project contributors via pre-packaged development environment
3.  Consistent, prescribed development and continuous integration processes
4.  Measured, minimum standard code quality via automated and enforced unit test and code coverage standards
5.  Rapid feedback via automated, continuous delivery processes
6.  Strongly controlled, easily managed and auditable change via automated, common deployment processes across all environments
7.  Complete change management 
8.  Modern change capabilities that meet the demands of the ever changing business and technology landscape 

##Secure and consistent environments
Environments will be build using code, configuration scripts and automation tools.  The goal is to ensure that configuration is consistent, change is deliberate and security is baked into the evnrionments from the ground up.

##Rapid onboarding
Onboarding will be supported via a combination of application and/or OS image virtualization using technologies like Azure Dev/Test Labs, Docker, and possibly other virtualization.  New contributors should be able to onboard with a standard development toolset without having to install tools, etc.  Development, integration, test and production environmental differences should be minimized.

##Conistent and Prescribed Development and Continuous Integration
Development and integration processes will be built on top of Visual Studio Team Services and Git.  These processes will leverage pull requests and continuous integration triggers to ensure that all code merged into the mainline is immediately built and passed or rejected.

##Measured, Minimum Standard Code Quality
Continuous integration build processes will automatically execute unit tests.  Code coverage by unit tests will be measured and minimum code coverage standards will be defined as an accept/reject criterion for build success or failure.

##Rapid Feedback via Continuous Delivery
Successful CI builds will be automatically deployed to Azure hosted test infrastructure [TBD: I'm inclined to address automated GUI testing, but it feels a little far off right now...]

##Strongly Controlled Change
All changes to any target CD environment must go through each of the DevOps processes.  Additionally, individuals should not have or need direct access to the CD environments, except by auditable exception.

##Complete Change Management
In traditional development and operations practices, development manages change by tracking the code changes that comprises the product, and operations manages change via an entirely separate set of processes.  In DevOps we bridge the development and operations change management practices.  We accomplish this by writing and version controlling code that leverages automated platform build tools to build the target non-production and production environments.  In concert with the other DevOps practices, this removes the barriers between development and operations, allowing members from both teams the same level of confidence that a product increment will function the same across all environments because the same processes are applied to promote change throughout those environments.

##Modern Change Capabilities
We expect this definition of DevOps to evolve over time as we build the initial pipeline and then learn through the first several product increment acquisitions what works and what needs to improve.  The modern business delivery and technology landscape requires technology products that can rapidly adapt to changes in both business requirements and tools that support those requirements.  The core mission behind the DevOps approach must be to enable and demonstrate success with delivery rapid, high-quality change.

#DevOps Pipeline
The "DevOps pipeline" joins the capabilities identified in the DevOps definition.  It functions to ensure that all changes are managed consistently.  the DevOps pipeline consists of:
- development environments
- continuous integration servers
- continuous deployment servers
- target non-production and production infrastructure

## Development environments
This is a DevOps MVP based around an example ASP.NET Core web app. The webapp was generated by `dotnet new mvc`.  Setup documented below for Windows(Local and Cloud), and Mac/OSX.

### Windows Local 
First install the [latest .NET Core SDK](https://www.microsoft.com/net/core#windowscmd) TODO: automate this upgrade

```ps1
cd aspnetapp
# rd obj #to remove cache
dotnet restore
dotnet run
```

your app is running on `http://localhost:5000`

Windows / virtualization notes:
- Virtualizaiton still seems young on the Windows platform.
- Windows does not support nested virtualization -- i.e. Docker running on Windows that is already under virtualization.
- Windows Docker containers like `windows/nanoserver` only run on Windows.
- Azure has some support for nested virtualization ("Server2016 with Containers", running on special hardware) but it seems buggy.
- ATM, docker-compose doesn't work on Server2016
- ATM, Server2016 has a bug that prevents connecting to Docker containers on localhost

### OSX Local
On OSX we use a Docker container to run our ASP.Net app.  [Make sure "Docker for Mac" is installed](https://docs.docker.com/docker-for-mac/install/#download-docker-for-mac)

```sh
docker build -f Dockerfile.mac -t aspnetapp .
docker run -p 5000:5000 aspnetapp
```

Your app is running on `http://localhost:5000`.  Note that your `Project.cs` must be listening on `http://*:5000/`. 

Debug container build:
```sh
docker ps
docker run -it <container-id> sh
```

### Azure DevTestLabs
After investigation, [Azure DevTestLabs](https://azure.microsoft.com/en-us/services/devtest-lab/) seem like a good product, we can:
- automate creation of DTL VMs with Windows or Linux
- automate provisioning of DTL VMs with things like git, VSCode, etc.
- automate shutdown of these VMs at the end of a workday to save money
- DTL VMs can be provisioned on "Server2016 with Containers" for potential future Dockering
- Users connect to DTL VMs via RDP
- There is VSTS/DTL integration that I didn't investigate

A rough estimate puts cost of this service at **$50/developer/month**.
Leaving DTL notes here. We are not using DTL right now -- it doesn't give us better virtualization and they cost money.

##Continuous Integration servers
TBD - VSTS build

##Continuous Deployment Servers
TBD - VSTS build deployment

##Non-production and Production Infrastructure
TBD - Azure

## Staging environments

We plan to highlight a couple options for cloud-based staging environments.

### Cloud.gov
[Cloud.gov](https://cloud.gov) is Platform as a Service(PaaS) running on AWS and operated by 18F.  It can run .NET Core appliations.
Unfortunately cloud.gov only services federal customers right now. We use it as a free stand-in for other PaaS choices.

First, [Get a cloud.gov](https://cloud.gov/docs/getting-started/accounts/) account and [Set up the CLI](https://cloud.gov/docs/getting-started/setup/)

```
# Set up
cf login -a api.fr.cloud.gov --sso
cf target -o sandbox-gsa -s clinton.troxel

# Deploy
cd  aspnetapp
cf push aspnet-clint

# Get more information
cf apps
cf logs aspnet-clint --recent
open https://aspnet-clint.app.cloud.gov
```

Note: with default setup, we need to comment out `//.UseUrls("http://*:5000/")` in order for this app to run under cloud.gov.  This setting was added to support Docker.

## Azure

We demonstrate the sample app running on a VM in Microsoft Azure.

### Powershell, CLI infrastructure
We can use powershell modules or the Azure CLI to manage Azure VMs.  See more in [`powershell_infra/README.md`](./powershell_infra/README.md)

### Raw ARM infrastructure
With Powershell and CLI we can only run the script.  If a VM exists our script will error.  It does not handle existing infra.
To handle existing infrastructure -- deleting things that aren't supposed to be there, creating things that are missing -- we need to use something like Terraform or raw ARM with mode=complete.

Learn more in [`raw-arm-infra/README.md`](./raw-arm-infra/README.md)

#### Terraform
We include an example of using [Terraform](https://terraform.io) to build cloud infrastructure.

### Permissions needed in order to create infrastructure

Adding resources to Azure requires "Contributor" permissions.  This can be granted in two ways:
- At the Azure subscription level
- At the Azure resource group level 

####Add an Azure subcription contributor
1.  Select _More services >_ from the bottom of the Azure Portal services menu (the services list panel opens)
2.  Search for "Subscriptions" and click the Subscriptions tile (the Subscriptions list panel opens)
3.  Click on the subscription you want to add a new contributor to (the management panel for that subscription opens)
4.  Click on _Access control (IAM)_ (the access management panel opens)
5.  Click on the _Roles_ toolbar button (the roles panel opens)
6.  Click on the _Contributor_ role (the contributor group membership panel opens)
7.  Add the user to the group and close the panels

####Add an Azure resource group contributor
1.  Select _Resource groups_ from the Azure Portal services menu
2.  Click on the resource group you want to add a new contributor to (the management panel for that resource group opens)
3.  _Continue as from step 4 of the procedure for adding an Azure subscription contributor_
