# IBM IBM SAM Authentication and Authorization Conceptual Design
This document outlines the conceptual design approach for authentication and authorization using the IBM IBM SAM product that is currently used in the ARIES Release 1 environment.  For key technical strategy background on the EIS-R project approach to continuing product development, see [Modular product design strategy: Incremental Transition](https://github.com/18F/acq-alaska-dhss-modernization/blob/master/modular-experience.md#incremental-transition).  One key concept to understand is the [encasement pattern](https://18f.gsa.gov/2014/09/08/the-encasement-strategy-on-legacy-systems-and-the/), which is the strategic approach the EIS-R product team envisions using to incrementally eclipse our legacy systems.  Here, "legacy systems" refers to both the legacy mainframe "EIS" and the unwieldy and poorly functioning ARIES Release 1.

## The Background
IBM SAM currently implements 4 key architectural services for applications in ARIES today:
1. App service/resource decoupling (reverse-proxy)
2. Load-balancing and scaling
3. Federated Authentication and Single-sign-on
4. Large grained authorization

### App service/resource decoupling (reverse-proxy)
IBM SAM provides reverse-proxy services for ARIES that abstract and decouple the resource requested from the backend services that implement that resource.  This is both a security boon, and change enabler.

### Load-balancing and scaling
IBM SAM provides load-balancing services across backend services.  This supports scaling out services by adding new service nodes, when the service does not have built-in scaling capability.  This improves the ability to address certain performance scenarios.

### Federated Authentication and Single-sign-on
IBM SAM supports federated, SAML 2.0 authentication and single-sign-on.  This allows end-users to authenticate once across backend services managed by IBM SAM, and allows those user authentications to occur against different authentication stores, e.g., different Microsoft Active Directory forests. 

### Worker portal access (backend service authorization)
IBM SAM includes functionality to grant/restrict access to users for specified backend services.  In this document, we focus on the ARIES Release 1 Worker Portal as the "backend service".  There are three groups defined under `SAM Groups`:
* Production
    - wpusers (Production)
* Non-production
    - wpuserstrn (Training)
    - wpusers (UAT)

User accounts are added to the appropriate `SAM Group` to allow them to access specific production and non-production worker portal instances.  This configuration provides an additional layer of security authorization in addition to the application-based authorization functions implemented in the ARIES worker portal.  See the [ARIES  User Security Reference Guide](https://extranet.dhss.alaska.gov/pmo/home/DPA-EIS-Replacement/OPS/Shared%20Documents/ARIES%20State%20Project%20Team%20Training%20Materials/ARIES%20User%20Security%20Reference%20Guide.docx), section 4, especially section 4.4, for more information aobut worker portal access.

### ARIES Worker Portal user authorization note
Authorization to access individual resources within the ARIES worker portal is managed as an administrative function of the worker portal, _not via SAM Groups_.  A user account is setup in the ARIES worker portal `Security Module`.  That user account is then mapped to a role and, finally, an `Employee Profile` is created for the user account. 

### Worker Portal access versus Worker Portal authorization
Worker Portal access - defined by SAM Group membership - and Worker Portal authorization - defined by Worker Portal Security Module role mapping - are two different and separate layers of authorization.  _There is no indication that Worker Portal resource authorizations granted via role mappings are related in any way to the SAM Group authorization layer._

### User Request Authentication and Authorization Diagram
The following diagram shows the flow of a user request through authentication and authorization services:
![ARIES SAM TDS Conceptual Design](AriesSamTdsConceptualDesign.jpg)

**It is critical to understand that user-identity authentication and ARIES Worker Portal user-identity authorization are completely separated in the ARIES architecture.** A user first authenticates via IBM SAM processes.  That authenticated user-identity is then used mapped to an ARIES Worker Portal security role to authorize actions the user attempts to take on specific resources within the Worker Portal. **The ARIES Worker Portal knows about the user-identity but _has no knowledge_ of the authenticator.**  Whatever solution we arrive at, we believe it is a good idea to keep using this type of architecture that clearly separates the authentication function from authorization function, and _avoids requiring the application/services layer to "know" about the authentication layer._

## What we might want to do
Our approach is to see if we can re-use these services for the cloud hosted first product increment to give the user a seamless authentication and authorization experience that ties together the new product increment with the legacy ARIES Release 1 product.  If this won't even work, we need to "fail fast"; as fast as possible to avoid wasting time on something that doesn't work.  So, unless it makes approval of activities take longer, we should separate this work from the other prototype activities that relate to potentially more sensitive systems/data.

# FAQ
The following are frequently asked questions related to the authentication and authorization prototyping work.

### Do we plan to keep using IBM SAM long term?
IBM SAM is not well aligned in the DHSS and SOA OIT environment. It duplicates existing and better supported services provided by Citrix NetScaler and Microsoft Active Directory Services.  In the long term, it makes better sense to stop using IBM SAM.  In the short term, it may make sense to use IBM SAM for the first product increment/acquisition currently planned for late summer / early fall 2017.

### Why use IBM SAM?
IBM SAM includes single-sign-on functionality and works today.  If we can quickly show it would work for the proposed Microsoft Azure hosted App Service app to be developed in the first acquisition, this would save substantial short term effort that would otherwise be required to replace the IBM SAM authentication and authorization services for both the first acquisition and the existing legacy ARIES Release 1 Worker Portal.  

We also don't know if we have comparable technical services to use in place of IBM SAM for single-sign-on.  With limited fiscal resources and major eligibility backlog challenges, DPA's top priority is to find the shortest path to addressing the application backlog, even if this means some re-work later.

### If ARIES is going away eventually, shouldn't we start using something else now before we build a whole new set of services around IBM SAM?
DHSS and OIT now have federated authentication services.  SOA DHSS and OIT datacenters also include NetScaler devices that can address load-balancing and scaling (and reverse-proxy?).  The gaps in equivalent services that DHSS and OIT can better support seem to be with the backend service level access/authorization.  There may also be a gap in being able to re-implement single sign on using some combination of DHSS and OIT resources that could be retro-fitted to legacy ARIES Release 1.  Moving to better supported DHSS and OIT technical services also invokes a number of design questions we haven't answered about whether to implement using DHSS technical services or OIT technical services.  We don't have a proposed architecture to work with in place of IBM SAM.

While we should start using something else besides IBM SAM, we don't have any proposed full replacement to do that.  As the product team matures into our agile and DevSecOps processes, this work could be defined and implemented concurrently with or between future product increments.

### Is it acceptable for the user to authenticate twice?  I.e., if we did not implement single-sign-on?
Two authentications would reduce functionality significantly and would create additional delays in user workflows that are the main focus of trimming extra time and clicks from the DPA eligibility application processing workflow.  This would also create pressure to replace working ARIES Release 1 functionality sooner than desired in the product road map.

### Would using a different authentication service even create a second authentication if the authenticator is the DHSS domain
The question implies that the Azure PaaS cloud app is configured to use the DHSS AD as it's authenticator, while ARIES authentication remains as-is (via IBM SAM).  In this scenario, the idea is that the DPA worker logged into a workstation joined to the DHSS domain would not even be prompted for credentials.  Their browser would present the DHSS domain credentials and the App Services app would authenticate the user.  There are some stops/problems in this scenario:
1. Implies we commit to hybridizing between Azure PaaS App Service app and DHSS domain.  Approach for this is undefined and might create additional blockers from a security perspective while we assessed and documented risks of "exposing our domain to the Azure cloud".
2. While authentication would possibly not be a problem, the flow from what would typically appear as two separate domains would likely be a problem.  This might be solvable with some Netscaler magic; not sure.

# Blockers, assumptions, follow-ups

## Blockers
### Environment changes required to test WebSeal front-end for prototype
* Using IBM SAM to front-end cloud will require an outbound connection to the cloud from IBM SAM.  
* This means we will need appropriate security documentation to request the firewall/DMZ changes to allow the IBM SAM WebSeal server to make an outbound connection from the SOA DMZ to the Azure hosted App Service app.
* This also means the DHSS DSO will have to understand how this impacts the risk surface of the ARIES IBM SAM components by allowing these servers to make outbound connections to at least one defined external resource

## Follow-ups
### Would we move forward with a 2 domain requirement for authentication, or could we migrate everyone to the SOA domain and simplify our architecture?
* P Wilkins asserts soa and dhss domain would either need to be replicated outside of an IBM SAM implementation, or we would move everyone to soa domain
* S Taylor thinks we may have some shared understanding gaps about the design goals of the current authentication and authorization architecture.  Specifically, the application never knows about the Microsoft Active Directory `DHSS domain` or  `SOA domain`.  The application only knows about the user-identity that has been authenticated, and then uses that user-identity to authorize access requests for that user-identity.  Some of our discussion has focused on the idea that the application will need to be connected to or talk to one or more of the Active Directory domains.  We need to get a shared understanding of this and agree on preserving this architecture.

### Anticipated environment changes
* The non-production ARIES IBM SAM servers we would be leveraging to prototype this authentication architecture are hosted in the OIT DMZ
* Communications in the OIT DMZ are disallowed by default and allowed by exception
* Thus, we need to have IBM SAM exception to allow communicating to the internet to reach the cloud app from the IBM SAM/WebSeal server.
* Do we need a security plan of some sort to support this change in the environment (expect answer is yes).

### What is the shortest path to test the validity of using the IBM SAM components to handle authentication, etc., for the Azure hosted App Service app?
* We need to discover whether we can even successfully configure IBM SAM to front of the cloud hosted app.  
* We need to fail fast. Do we have to have a security plan for this?  
* Should we need to update the broader prototype security plan for this, or should we submit a separate security plan?

# Document History
| Author | Date | Comments |
|-------|:--------|:--------|
| S Taylor | 2017.07.14 | Completed initial draft for Trello #105|