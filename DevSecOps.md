# Why DevSecOps?
The following material is borrowed liberally, and extended significantly, from concepts in Ben Day's [DevOps Skills for Developers with Visual Studio & TFS 2015](https://www.pluralsight.com/courses/devops-skills-developers-visual-studio-tfs-2015) Pluralsight.com class.  It's a great class and worth checking out!

## It's for Everyone
Software development has made great strides over the last 10 years by employing methodologies like Agile and Scrum.  These methodologies envision a product, break that product into a backlog of incremental product improvements, prioritize that backlog and then create the product in small chunks of effort over short sprints of development time.  This approach drastically reduces risks and it allows the product team to react quickly when a priority changes, or a good product improvement idea doesn't deliver the expected results.

The problem with Agile and Scrum is that it's only half the story: how do we efficiently write software?  Agile and Scrum do really well answering that question, but when it comes to actually delivering software into production, Agile and Scrum are relatively mute.  Typically, this translates into the moment when the "development team" hands the written and tested software off to one or more operations teams.  These teams typically have no exposure to what it took to make the software work in development, integration or quality assurance environments, and have completely separate processes for how they build and configure the "equivalent" target production environment for the product.  Whether it is differences in process or differences in team members or both, this impedance mismatch between how software is developed and how it is actually delivered to customers creates a barrier between development and production that increases risks and slows down delivery time. The purpose of DevSedOps is to break down this barrier, improve quality and speed up delivery time.

DevSecOps is a mindset focused on:
- Reliability
- Repeatability
- Traceability
- Minimal or no manual intervention

DevSecOps is also a set of practices focused on automation:
- Automated build
- Automated test
- Automated deploy
- Automated monitoring
- Automated infrastructure (container tech, etc.)

Through this core story of automation, DevSecOps is always looking for new ways to eliminate human intervention.  Adding all of these capabilities up leads to "Continuous Deployment".

## For Security and audit
Expressing configuration and automation as code solves a number of important security challenges.  

Automating infrastructure ensures that infrastructure configuration is known, prescribed and protected from configuration errors made by skipping installation and configuration steps or building up configurations inconsisently across peer level resources.  By automating build, test and deployment, changes are auditable from the time they are merged to the mainline all the way through the pipeline to production.  In turn, these capabilities tighten change control, and allow deploying change to production without direct access to production.  Thus direct, administrative production access is reduced to a smaller pool of staff who are only responsible for basic monitoring.  

During incident response wider access is temporarily granted, if necessary.  These permissions changes can be managed through the same automated and auditable pipeline as other environment changes, addressing key audit concerns like COBIT access control and program change management.  

Automated build and testing lends itself to incorporation of security scanning and testing tools.  DevSecOps _does not_ directly simplify the documentation of security controls.  However, when adopted by the development, operations and security organizations, the DevSecOps approach of coded installation and configuration institutionalizes visibility of how environments are configured, ensuring access to provable configuration documentation.

When Security participates in the DevSecOps agile processes, they ensure the work to address security practices and processes within the sprint cycle is better defined and distributed.  DevSecOps helps to meet the _fail fast_ principle and significantly improves the security outcomes.

## For Operations
DevSecOps focuses on visibility and repeatability, and it does so with quality of both the software product *and* the deployment products used to rapidly and consistently deploy the software.  Additionally, the emphasis on automating infrastructure lets the operations team bring their own requirements to the table and realize those requirements through version controlled code and configuration artifacts.  Building servers and configuring infrastructure this way reduces or eliminates configuration drift and yields consistent and documented families of infrastructure resources.

## For Development
DevSecOps extends the proven practices of Agile and Scrum by removing deployment technical debt and de-risking the ultimate goal: delivering the product.  DevSecOps strengthens the presence of security as a first order requirement.  It provides developers with the confidence of knowing that change can be delivered quickly, and there are no mystery variables that span the non-production and production environments, and no part of the transition to production that is not addressed during development. 

## For the Team
DevSecOps brings down the wall between development, operations and security, and puts everyone on the same team, providing equal visibility into changes aimed at both the customer products and the operating environment of those products.  Additionally, through automation, tight change control and limited need for direct access to production environments, DevSecOps realizes the solution to limited resources in IT organization that cannot support full separation of duties.

## For the customer
For the customer, DevSecOps yields a better product that is delivered faster than with traditional processes that separate development from oprations.

# Outcomes from DevSecOps
We believe that DevSecOps capabilities must support and include:
1.  A secure and consistent set of development, non-production and production environments
2.  Rapid onboarding of vendors and other project contributors via pre-packaged development environment
3.  Consistent, prescribed development and continuous integration processes
4.  Measured, minimum standard code quality via automated and enforced unit test and code coverage standards
5.  Rapid feedback via automated, continuous delivery processes
6.  Strongly controlled, easily managed and auditable change via automated, common deployment processes across all environments
7.  Complete change management 
8.  Modern change capabilities that meet the demands of the ever changing business and technology landscape 

## Secure and consistent environments
Environments will be build using code, configuration scripts and automation tools.  The goal is to ensure that configuration is consistent, change is deliberate and security is baked into the evnrionments from the ground up.

## Rapid onboarding
Onboarding will be supported via a combination of application and/or OS image virtualization using technologies like Docker.  New contributors should be able to onboard with a standard development toolset without having to install tools, etc.  Development, integration, test and production environmental differences should be minimized.

## Consistent and Prescribed Development and Continuous Integration
Development and integration processes will be built on top of Visual Studio Team Services and Git.  These processes will leverage pull requests and continuous integration triggers to ensure that all code merged into the mainline is immediately built and passed or rejected.

## Measured, Minimum Standard Code Quality
Continuous integration build processes will automatically execute unit tests.  Code coverage by unit tests will be measured and minimum code coverage standards will be defined as an accept/reject criterion for build success or failure.

## Rapid Feedback via Continuous Delivery
Successful CI builds will be automatically deployed to Azure hosted test infrastructure [TODO: I'm inclined to address automated GUI testing, but it feels a little far off right now...]

## Strongly Controlled Change
All changes to any target CD environment must go through each of the DevSecOps processes.  Additionally, individuals should not have or need direct access to the CD environments, except by auditable exception.

## Complete Change Management
In traditional development and operations practices, development manages change by tracking the code changes that comprises the product, and operations manages change via an entirely separate set of processes.  In DevSecOps we bridge the development and operations change management practices.  We accomplish this by writing and version controlling code that leverages automated platform build tools to build the target non-production and production environments.  In concert with the other DevSecOps practices, this removes the barriers between development and operations, allowing members from both teams the same level of confidence that a product increment will function the same across all environments because the same processes are applied to promote change throughout those environments.

## Modern Change Capabilities
We expect this definition of DevSecOps to evolve over time as we build the initial pipeline and then learn through the first several product increment acquisitions what works and what needs to improve.  The modern business delivery and technology landscape requires technology products that can rapidly adapt to changes in both business requirements and tools that support those requirements.  The core mission behind the DevSecOps approach must be to enable and demonstrate success with delivery rapid, high-quality change.

# DevSecOps Pipeline
The "DevSecOps pipeline" joins the capabilities identified in the DevSecOps definition.  It functions to ensure that all changes are managed consistently.  the DevSecOps pipeline consists of:
- development environments
- continuous integration pipeline
- continuous deployment pipeline
- target non-production and production infrastructure
