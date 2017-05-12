#Introduction 
This repository tracks assets of the minimum viable product for a DevOps continuous integration, continuous deployment pipeline for the [Alaska DHSS modernization project](https://github.com/18F/acq-alaska-dhss-modernization).  This project aims to transform the way Alaska approaches implementation and support activities for its mission critical technology products.  We plan to do this by taking deeper ownership of the product definition and the foundational processes and tools used in exchange for steeply reduced financial and functional risks of traditional, monolithic approaches.  The foundation of this will be a State managed DevOps pipeline.

##Why DevOps?
The following material is borrowed liberally from concepts in Ben Day's _DevOps Skills for Developers with Visual Studio & TFS 2015_ Pluralsight.com class.
###For Everyone
Software development has made great strides over the last 10 years by employing methodologies like Agile and Scrum.  These methodologies envision a product, break that product into a backlog of incremental product improvements, prioritize that backlog and then create the product in small chunks of effort over short sprints of development time.  This approach drastically reduces risks and it allows the product team to react quickly when a priority changes, or a good product improvement idea doesn't deliver the expected results.

The problem with Agile and Scrum is that it's only half the story: how do we efficiently write software?  Agile and Scrum do really well answering that question, but when it comes to actually delivering software into production, Agile and Scrum are relatively mute.  Typically, this translates into the moment when the "development team" hands the written and tested software off to one or more operations teams, who have no exposure to what it took to make the software work in development, integration or quality assurance environments, and have completely separate process for how they build and configure servers and the platform software requried to run the product.  Whether it is differences in process or differences in team members or both, this impedance mismatch between how software is developed and how it is actually delivered to customers creates a barrier between development and production that increases risks and slows down delivery time. The purpose of DevOps is to break down this barrier.

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

###For Security and audit
The automation focus of DevOps solves a number of important challenges.  Automating infrastructure ensures that infrastructure configuration is known, prescribed and protected from configuration errors made by skipping installation and configuration steps or building up configurations inconsisently across peer level resources.  By automating build, test and deployment, changes are auditable from the time they are merged to the mainline all the way through the pipeline to production.  In turn, these capabilities tighten change control, and allow deploying change to production without direct access to production.  Thus direct, administrative production access is reduced to a smaller pool of staff who are only responsible for basic monitoring, and wider access can be handled on an audit exception basis.  Finally, automated testing lends itself to incorporation of security testing tools.  DevOps _does not_ directly simplify the documentation of security controls.  However, when adopted by both the development and operations organizations, the DevOps approach of coded installation and configuration institutionalizes visibility of how environments are configured, ensuring access to provable configuration documentation. 
TBD write out the story about controlled change and tamper proof change promotion pipelines.

###For Operations
TBD write out the story about visibility, and quality of both software product *and* the deployment products used to rapidly and consistently deploy the software.

###For Development
TBD write out the derisking story of removing deployment technical debt and the security/confidence in knowing that change can be delivered quickly 

###For the customer
TBD write out the story of value for the customer.

##Outcomes from DevOps
We believe that DevOps capabilities must support and include:
1.  Rapid onboarding of vendors and other project contributors via pre-packaged development environment
2.  Consistent, prescribed development and continuous integration processes
3.  Measured, minimum standard code quality via automated and enforced unit test and code coverage standards
4.  Rapid feedback via automated, continuous delivery processes
5.  Strongly controlled, easily managed and auditable change via automated, common deployment processes across all environments
6.  Complete change management 
7.  Modern change capabilities that meet the demands of the ever changing business and technology landscape 

###Rapid onboarding
Onboarding will be support via a combination of application and/or OS image virtualization using technologies like Azure Dev/Test Labs, Docker, and possibly other virtualization.  New contributors should be able to onboard with a standard development toolset without having to install tools, etc.  Development, integration, test and production environmental differences should be minimized.

###Conistent and Prescribed Development and Continuous Integration
Development and integration processes will be built on top of Visual Studio Team Services and Git.  These processes will leverage pull requests and continuous integration triggers to ensure that all code merged into the mainline is immediately built and passed or rejected.

###Measured, Minimum Standard Code Quality
Continuous integration build processes will automatically execute unit tests.  Code coverage by unit tests will be measured and minimum code coverage standards will be defined as an accept/reject criterion for build success or failure.

###Rapid Feedback via Continuous Delivery
Successful CI builds will be automatically deployed to Azure hosted test infrastructure [TBD: I'm inclined to address automated GUI testing, but it feels a little far off right now...]

###Strongly Controlled Change
All changes to any target CD environment must go through each of the DevOps processes.  Additionally, individuals should not have or need direct access to the CD environments, except by auditable exception.

###Complete Change Management
In traditional development and operations practices, development manages change by tracking the code changes that comprises the product, and operations manages change via an entirely separate set of processes.  In DevOps we bridge the development and operations change management practices.  We accomplish this by writing and version controlling code that leverages automated platform build tools to build the target non-production and production environments.  In concert with the other DevOps practices, this removes the barriers between development and operations, allowing members from both teams the same level of confidence that a product increment will function the same across all environments because the same processes are applied to promote change throughout those environments.

###Modern Change Capabilities
We expect this definition of DevOps to evolve over time as we build the initial pipeline and then learn through the first several product increment acquisitions what works and what needs to improve.  The modern business delivery and technology landscape requires technology products that can rapidly adapt to changes in both business requirements and tools that support those requirements.  The core mission behind the DevOps approach must be to enable and demonstrate success with delivery rapid, high-quality change.

##DevOps Pipeline
The "DevOps pipeline" joins the capabilities identified in the DevOps definition.  It functions to ensure that all changes are managed consistently.

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