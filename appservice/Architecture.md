# App Service Architecture Summary
App Service is a Platform as a Service (PaaS) offering intended to support building and implementing Web, mobile and API applications/services.  App Service is intended to scale from simple marketing and digital presence applications to hyper-scale customizable applications.

App Service is fully managed.  No administrative tasks are required to manage the underlying compute infrastructure that the applications run on.  The platform patches the OS and frameworks automatically.

App Service applications run on virtualized servers and the platform handles scaling automatically, including adding more servers and load balancing, when the application needs additional compute resources.  The App Service allows application administrators to set the maximum number of server instances in order to throttle resource usage and corresponding costs.

App Service clusters virtual servers into a single unit called a `scale unit`. An App Service scale unit is a collection of servers that host and run applications.  A typical scale unit can have more than 1,000 servers.  Each scale unit is autonomous and can operate on its own.  The fundamental build block of an Azure App Service scale unit is an `Azure Cloud Service deployment`.

## Global, Geo-Distributed Architecture
App Service is designed to scale globally.  To support this, every Azure region leverages sets of `regional control units`, including one special control unit used as a gateway for all management API calls.  For example, when a customer makes a request to create a new aplication (via portal, CLI or Azure REST API), the reqeust is routed to a central Azure endpoint.  `Azure Resource Manager` (ARM) lets you work with different Azure resources in a specific application as a single group.  the ARM API provides a management interface, but proxies management commands to individual Azure resources, via the service API of that resource.  The Azure App Service service API is called the App Service 'Geo-Master'.

The Geo-Master has context about all scale units worldwide.  For example, when creating a new App Service application, Geo-Master finds the most suitable scale unit for your application and then forwards the create request to that scale unit.

## Scale Unit Architecture

Azure App Service scale unit's virtual server compute resources are architecturally divided to fulfill a number of different functions, or `roles`, within the scale unit.  The majority of servers in a scale unit are `Web Workers` that actually execute the application's functions.  The Web Worker and other roles within the scale unit are defined below.

### Web Worker Role

Applications in Azure App Service are run on Windows or Linux servers and are referred to as `Web Workers` or `Workers` for short.  

Web Workers can either be `Dedicated Workers` or `Shared Workers`.  The type of Worker depends on selections in the `App Service Plan`.

### Front End Role

The `Front End` is a layer-seven load-balancer, acting as a proxy, distributing incoming HTTP requests between different applications and their respective Workers.  The Front End uses a simple round robin algorithm to route requests to the available servers for a given application.

### File Server Role

Applications need storage to hold content, such as HTML, .js, image, or code files.  A `File Server` mounts `Azure Storage blobs` and exposes them as drives to the Worker.  A Worker, in return, maps these drives as local, allowing an application running on any given Worker to use the "local" drive, just as if the application were running on a host using that host's local disk.  All file-related read/write operations pass through a file server.

### API Controller Role

`API Controllers` fulfill incoming Geo-Master requests within the scale unit.  For example, when Geo-Master passes an API call to create a new application, the API controller orchestrates the steps to createe the application.  When you reset your application via the Azure portal, it is the API controller that notifies all Web Workers allocated for your application to restart your app.

### Publisher Role

Azure App Service supports FTP access to any application.  The App Service `Publisher` exposes FTP functionality to access application content and logs stored in Azure Storage blobs.  While application deployment might more typically occur via `Visual Studio` or `Visual Studio Team Services` `Release Manager`, Publisher functionality also supports classic FTP web application deployment.

### SQL Azure Database Role

Each App Service scale unit uses `Azure SQL Database` to persist application metadata.  It is important to distinguish that this is built-in functionality of the scale unit, separate from any business information that the application is built to persist.

### Data Role

Each of the roles within the scale unit require specific metadata about the application to perform their function within the scale unit.  The `Data Role` fulfills a caching layer between the SQL Azure Database role and all other roles in a given scale unit.  It abstracts the data layer from the rest of the roles, improving scale and performance, as well as simplifying software development and maintenance.

## Application Slots

App Service has a feature called `deployment slots`.  Deployment slots support deploying a separate runtime of an application, with either the same or different bits, that can be used, for example, to test a staged new version of your application before swapping into production.

Each deployment slot is a full copy of the application in its own right.  This means that the application can have its own custom domain, different SSL certificates, different application settings, etc.  It also means each slot can be assigned to its own App Service Plan, though by default, the slots are assigned to the same App Service Plan.

Application deployment slots on the same App Service Plan run on the same servers.  So, running in the same App Service Plan can lead to problems in certain scenarios.  For example, running a performance load test against a staging copy of the application in one slot, while running production in another slot on the same plan can result in CPU or memor constraints.

## Scale Unit Networking
Each scale unit is deployed on a specific `Cloud Service` and has a single virtual IP (VIP) address exposed to the world.  All applications allocated to a given unit of scale are serviced through this VIP.

App Service applications only serve HTTP (port 80) and HTTPS (port 443) traffic.  Each App Service application has default built-in HTTPS support for the azurewebsites.net domain name.  App Service supports both `Server Name Indication` (SNI) and IP-based Secure Sockets Layer (SSL) certificates.

For additional details see the following article that was extensively quoted and paraphrased in this architecture summary:
- [Azure - Inside the Azure App Service Architecture](https://msdn.microsoft.com/en-us/magazine/mt793270)

