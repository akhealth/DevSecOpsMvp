# IBM WebSeal Authentication and Authorization Conceptual Design
This document outlines the conceptual design approach for authentication and authorization using the IBM WebSeal product that is currently used in the ARIES Release 1 environment.  For key technical strategy background on the EIS-R project approach to continuing product development, see [Modular product design strategy: Incremental Transition](https://github.com/18F/acq-alaska-dhss-modernization/blob/master/modular-experience.md#incremental-transition).  One key concept to understand is the [encasement pattern](TBD Link), which is the strategic approach the EIS-R product team envisions using to incrementally eclipse our legacy systems.  Here, "legacy systems" refers to both the legacy mainframe "EIS" and the unwieldy and poorly functioning ARIES Release 1.

## The Approach
WebSeal currently implements 4 key architectural services for applications in ARIES today:
1. App service/resource decoupling (reverse-proxy)
2. Load-balancing and scaling
3. Federated Authentication and Single-sign-on
4. Large grained authorization

Our approach is to re-use these services for the cloud hosted first product increment to give the user a seamless authentication and authorization experience that ties together the new product increment with the legacy ARIES Release 1 product.

### App service/resource decoupling (reverse-proxy)
WebSeal provides reverse-proxy services for ARIES that abstract and decouple the resource requested from the backend services that implement that resource.  This is both a security boon, and change enabler.

### Load-balancing and scaling
WebSeal provides load-balancing services across backend services.  This supports scaling out services by adding new service nodes, when the service does not have built-in scaling capability.  This improves the ability to address certain performance scenarios.

### Federated Authentication and Single-sign-on
WebSeal supports federated, SAML 2.0 authentication and single-sign-on.  This allows end-users to authenticate once across backend services managed by WebSeal, and allows those user authentications to occur against different authentication stores, e.g., different Microsoft Active Directory forests. 

### Authorization
WebSeal includes functionality to grant/restrict access to users for specified backend services.  This provides an additional layer of security authorization in addition to the application-based authorization functions implemented in the ARIES worker portal.

## Why WebSeal?
With the current position of the product that the EIS-R team is working to develop, and the requirement to incrementally improve that product, authentication and authorization functions are working and are not the highest priority problem to address.  The services WebSeal implements for ARIES outlined above are not trivial to replace, and the user experience must be as close to seamless as possible.  This means that a user who is accessing the improved search components identified for the upcoming first EIS-R acquisition, must be able to access those components without having to authenticate a second time.  If we can use WebSeal, then we don't have reimplement all these services for legacy ARIES Release 1.

## Shouldn't we not use WebSeal if ARIES is eventually going away?
DHSS now has federated authentication services.  SOA OIT datacenters also include NetScaler devices that can address load-balancing and scaling (and reverse-proxy?).  The gaps in equivalent services that DHSS and OIT can better support seem to be with the backend service level authorization.  There may also be a gap in being able to re-implement single sign on using some combination of DHSS and OIT resources that could be retro-fitted to legacy ARIES Release 1.  Unless we have proven high-confidence solutions for these problems, we need to invest in educating ourselves about WebSeal, implementing the required solution for the first product increment in the short term and put moving off of WebSeal into the right place on the product backlog.

