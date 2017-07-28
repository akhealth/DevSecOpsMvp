# Azure App Service Security

## Introduction
This document contains information learned about `Azure App Service` security.  In this version, we touch on a number of security features of the Azure App Service and provide a brief overview of patching and App Service permission management.

Azure App Service is architected to function on a global scale.  We highly recommend reading our [brief architectural overview of App Service](/appservice/Architecture.md) before proceeding with the security information in this document.

## General App Service Security Information
[Microsoft Azure provides substantial security documentation for App Service](https://docs.microsoft.com/en-us/azure/app-service/app-service-security-readme).  This includes a variety of security capabilities and topics such as:

- Authentication and authorization
- Enabling and forcing TLS
- Whitelisting client by client's IP address
- Restricting access based on request frequency and concurrency
- Scanning the application for vulnerabilities with Tinfoil Security Scanning (at additional cost)
- Hybrid connections
- Web application firewalls

## App Service Patching
According to Microsoft Azure support, the Operating System on the underlying hosts are patched with the latest security updates for a given month after patch-Tuesday.  This includes patching for both .NET Framework components and .NET Core.  See this [App Service forum thread](https://social.msdn.microsoft.com/Forums/en-US/83f74799-d269-49e6-9d1d-8f8fa1c55a03/updates-for-net-core-aspnet-core-runtime-and-net-core-sdk-versions?forum=windowsazurewebsitespreview) for more info about patching .NET Core in App Service.

Microsoft further describes a patching protocol in their FedRAMP Moderate SSP in which they meet the following schedule:
- 30 days for high vulnerabilities
- 90 days for moderate vulnerabilities
- 180 days for low vulnerabilities

Microsoft does not, obviously, patch the custom code of the application.  Microsoft includes integration points for static code scanning of the application code itself in their Visual Studio Team Services build/continuous-integration feature.  They also offer integration within the App Service for cost-add scanning with Tinfoil, as noted above.  It is up to the application  DevOps team to leverage these capabilities for identifying and correcting vulnerabilities in the application code itself.

## App Service Administration

Azure permissions are managed via user-identities established in the Azure portal and `resource based access control` (RBAC) applied at an `Azure Resource Group` and `Azure Resource` level to grant those user-identities permissions. An `App Service Plan`, an `App Service Deployment-slot` and an `App Service App` are all resources within Azure and each can be secured via Azure RBAC.

It is important to note that authentication and authorization for access to the business features of a specific App Service hosted application is a separate topic from App Service administration, and can be designed and configured in a number of ways.  

In our prototyping efforts and this DevOps MVP, we are assuming that authentication is architecturally separated from the application to support single sign on with legacy on-premise resources.  The App Service hosted application is then configured to receive the authenticated user-identity token with the request and to apply authorization rules native to the application to that user-identity for validating whether the user-identity has access to a specific application resource/feature.