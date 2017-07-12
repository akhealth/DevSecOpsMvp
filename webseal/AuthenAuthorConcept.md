# IBM IBM SAM Authentication and Authorization Conceptual Design
This document outlines the conceptual design approach for authentication and authorization using the IBM IBM SAM product that is currently used in the ARIES Release 1 environment.  For key technical strategy background on the EIS-R project approach to continuing product development, see [Modular product design strategy: Incremental Transition](https://github.com/18F/acq-alaska-dhss-modernization/blob/master/modular-experience.md#incremental-transition).  One key concept to understand is the [encasement pattern](TBD Link), which is the strategic approach the EIS-R product team envisions using to incrementally eclipse our legacy systems.  Here, "legacy systems" refers to both the legacy mainframe "EIS" and the unwieldy and poorly functioning ARIES Release 1.

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

User accounts are added to the appropriate `SAM Group` to allow them to access specific production and non-production worker portal instances.  This configuration provides an additional layer of security authorization in addition to the application-based authorization functions implemented in the ARIES worker portal.  See the [ARIES  User Security Reference Guide](https://extranet.dhss.alaska.gov/pmo/home/DPA-EIS-Replacement/OPS/Shared Documents/ARIES State Project Team Training Materials/ARIES User Security Reference Guide.docx), section 4, especially section 4.4, for more information aobut worker portal access.

### ARIES Worker Portal Authorization Note
Authorization to access individual resources within the ARIES worker portal is managed as an administrative function of the worker portal.  A user account is setup in the ARIES worker portal `Security Module`.  That user account is then mapped to a role and, finally, an `Employee Profile` is created for the user account. 

### Worker Portal access versus Worker Portal authorization
Worker Portal access - defined by SAM Group membership - and Worker Portal authorization - defined by Worker Portal Security Module role mapping - are two different and separate layers of authorization.  _There is no indication that Worker Portal resource authorizations granted via role mappings are related in any way to the SAM Group authorization layer._

### User Request Authentication and Authorization Diagram
The following diagram shows the flow of a user request through authentication and authorization services:
![ARIES SAM TDS Conceptual Design](AriesSamTdsConceptualDesign.jpg)

**It is critical to understand that user-identity authentication and ARIES Worker Portal user-identity authorization a wholly separated in the ARIES architecture.** A user first authenticates via IBM SAM processes.  That authenticated user-identity is then used mapped to an ARIES Worker Portal security role to authorize actions the user attempts to take on specific resources within the Worker Portal. **The ARIES Worker Portal knows about the user-identity but _has no knowledge_ of the authenticator.**  Whatever solution we arrive at, we believe it is a good idea to keep using this type of architecture that clearly separates the authentication function from authorization function, and _avoids requiring the application/services layer to "know" about the authentication layer._

## What we might want to do
Our approach is to see if we can re-use these services for the cloud hosted first product increment to give the user a seamless authentication and authorization experience that ties together the new product increment with the legacy ARIES Release 1 product.  If this won't even work, we need to "fail fast"; as fast as possible to avoid wasting time on something that doesn't work.  So, unless it makes approval of activities take longer, we should separate this work from the other prototype activities that relate to potentially more sensitive systems/data.

# FAQ
The following are frequently asked questions related to the authentication and authorization prototyping work.

### Do we plan to keep using IBM SAM long term?
IBM SAM is not well aligned in the DHSS and SOA OIT environment. It duplicates existing and better supported services provided by Citrix NetScaler and Microsoft Active Directory Services.  In the long term, it makes better sense to stop using IBM SAM.  In the short term, it may make sense to use IBM SAM for the first product increment/acquisition currently planned for late summer / early fall 2017.

### Why use IBM SAM?
IBM SAM includes single-sign-on functionality and works today.  If we can quickly show it would work for the proposed Microsoft Azure hosted App Service app to be developed in the first acquisition, this would save substantial short term effort that would otherwise be required to replace the IBM SAM authentication and authorization services for both the first acquisition and the existing legacy ARIES Release 1 Worker Portal.  

We also don't know if we have comparable technical services to use in place of IBM SAM.  With limited fiscal resources and major eligibility backlog challenges, DPA's top priority is to find the shortest path to addressing the application backlog, even if this means some re-work later.

### If ARIES is going away eventually, shouldn't we start using something else now before we build a whole new set of services around IBM SAM?
DHSS now has federated authentication services.  SOA OIT datacenters also include NetScaler devices that can address load-balancing and scaling (and reverse-proxy?).  The gaps in equivalent services that DHSS and OIT can better support seem to be with the backend service level access/authorization.  There may also be a gap in being able to re-implement single sign on using some combination of DHSS and OIT resources that could be retro-fitted to legacy ARIES Release 1.  We don't have a proposed architecture to work with in place of IBM SAM.

So, while we should start using something else besides IBM SAM, we don't have any proposed full replacement to do that.

### Is it acceptable for the user to authenticate twice?  I.e., if we did not implement single-sign-on?
Two authentications would reduce functionality significantly and would create additional delays in user workflows that are the main focus of trimming extra time and clicks from.  This would also create pressure to replace working ARIES Release 1 functionality sooner than desired in the product road map.

### Would using a different authentication service even create a second authentication if the authenticator is the DHSS domain
If the authenticator is the DHSS domain, then a second authentication might not be required.  This remains untested for the cloud app, as we have not yet tested configuring authentication from the cloud app back to the DHSS domain.

# Blockers, assumptions, follow-ups

## Blockers
### Environment changes required to test WebSeal front-end for prototype
* Using IBM SAM to front-end cloud will require an outbound connection to the cloud from IBM SAM.  This means we will need appropriate security documentation to request the firewall/DMZ changes to allow the IBM SAM WebSeal server to make an outbound connection from the SOA DMZ to the Azure hosted App Service app.

## Follow-ups
### Would we move forward with a 2 domain requirement for authentication, or could we migrate everyone to the SOA domain and simplify our architecture
* P Wilkins asserts soa and dhss domain would either need to be replicated outside of an IBM SAM implementation, or we would move everyone to soa domain

### Follow-ups
* We need to discover whether we can even successfully configure IBM SAM to front of the cloud hosted app.  We need to fail fast.  What is the shortest path to test this?
* We need to have IBM SAM exception to allow communicating to the internet to reach the cloud app.  This exception will require a sufficient level of documentation to test configuring the ARIES non-prod IBM SAM services to support this test.  Can we separate this "Azure App Service App front-ended by ARIES non-prod IBM SAM system" from the full prototype system and get approval, or do we have to be blocked by keeping it all together and waiting on separate concerns like testing an EIS non-prod connection?