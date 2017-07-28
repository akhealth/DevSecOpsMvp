# DevOps Communication Plan

## Introduction
DevOps is a new practice for DHSS.  The goal of the practice is to improve change management and remove delivery walls between the development, operations and security domains.  Ideally, the delivery processes ensure that all domain stakeholders' requirements are met as part of the process and, as a result, delivery speed _and quality_ increase.  _If quality is not good across development, operations and security, the poorly met requirements will create domain resistance to change, and delivery speed **will not** increase._

Adopting this practice requires a communication plan that improves our DevOps and agile practices and addresses the DHSS organization's development, operations and security domain requirements.  The communication plan includes:
* Regular/standing communication needs and methods
* Security and operations participation expectations
* DevOps education resources
* A case study of actual development, operations and security domain collaboration
* How we improve across the development, operations and security domains 

The last bullet above is critical.  We run into problems with what seems to be a straight forward task.  An example is the prototype application we've been working on this sprint and early summer 2017.  See [Case Study: DHSS IT Development, Operations and Security Research & pPototyping](#case-study-dhss-it-development-operations-and-security-research-prototyping) for a draft case study that points to real world challenges the development, operations and security teams have encountered working together to deliver work within the EIS-R project sprint cycles.

Agile and DevOps practices focus on a culture that values defining and doing small pieces of work, inspecting that work, and "failing fast" - all inside a short sprint timebox.  Small pieces of work means the work is broken down into pieces that we can start and complete within a single sprint.  Inspecting the work means we build inspection into our daily standups and into our sprint review and retrospective meetings.  Failing fast means reducing the time we spend on ideas that can't or won't work.  To succeed, we need to learn how to apply agile and DevOps in a cross-functional development, operations and security team where the work getting done supports requirements from all those domains.   

This communication plan can and should be refined.  In particular, the product team will add case studies as we practice.  Additionally, we will update and use the [Other Challenges and Opportunities](#other-challenges-and-opportunities) section content to identify and implement challenges and opportunites, as needs/sticking points arise in the work managed via the product team's backlog.  While theoretical challenges and opportunities can be useful, challenges and opportunities we actually experience should be the first focus and primary driver of proposed improvements.

## Regular/standing Communications Resources
There are several standing communication methods to use for both planning and executing work, including:
* Bi-weekly sprint review/retro/grooming/planning meetings
* DevOps weekly standing show and tell meeting
* Daily product team standup/scrum
* Trello (tagged comments on individual cards)
* VSTS (tagged comments in pull requests)
* Slack (out-of-email-band messaging)

All Development, Operations and Security domain staff on the product team should be granted access to these resources and should be committed to effectively using them to complete the work.

## Development, Security and Operations Participation
The product team will have at least one member of the DHSS development domain organizational unit at all times.  Whenever possible, the product team should have a staff member of the security and operations domain organizations on the product team participating in the sprint.  However, we must have two types of security and operations activity/participation/support at all times:
* There must always be at least one designated security and operations representative on the product team.  The designated individual(s) are responsible for:
    - Identifying security and operations related concerns that may unexpectedly arise in the course of a sprint
    - Working with the product team to scope and address security and operations domain requirements.
    - Working on security stories during each sprint.

    These individuals could be assigned directly from the DHSS security and operations support organization units or delegated to other DHSS staff, as the security and operations units see fit.
* Whenever there are proposed environment changes in the sprint scope, we _must_ have security and operations domain staff members on the product team for at least that sprint (including planning) to task and execute work-products that meet the security and operations requirements related to those environment changes and to keep the changes moving forward and keep related work unblocked.

## DevOps Education Resources
The EIS-R project has developed a number of education resources to support individuals new to DevOps and/or new to the EIS-R team.  These resources include:

| Resource | Purpose |
|----------------|:-------------------|
| [Project Readme](https://github.com/18F/acq-alaska-dhss-modernization/blob/master/README.md)|Background information on the EIS-R project.  Includes our approach/strategy and links to mission model canvas and product roadmap | 
| [Project DevOps Vision](./DevOps.md) | Our project vision for the value of DevOps and our goals in using it |
| [Project DevOps MVP](https://github.com/dhssalaska/DevOpsMvp) | Our project repository containing the documentation, sample code, and learning we've done for our DevOps tool and process "minimum viable product" (MVP) |
| [Change management screencast](./demo-screencast/change-management-screencast.mp4) | A screencast covering basic change management, featuring VSTS, Git, .NET Core, CI, CD, Azure AppService |

## Case Study: DHSS IT Development, Operations and Security Research & Prototyping
This section describes an actual scenario of a backlog item scheduled in an EIS-R project sprint, and how the DHSS IT Development, Operations and Security staff responded to support the work.  In this draft, Development has attempted to capture our experience.  In order to serve as an effective example to improve our DevOps practice, we believe we must revise this draft to include detailed input from the Operations and Security staff involved.  It should be noted that there are limited procedures and rules at DHSS that guide how development requests work from operations and security.  The experience is, no doubt, challenging for staff from each domain.   

### The Scenario: Testing connectivity from Azure PaaS app to AK on-premise SQL Server
Project Trello card #136 "Build MVP SQL Server on-prem with HCM" referred to proving a configuration that tested connectivity between an Azure PaaS App Service application and an Alaska datacenter hosted server.  The product team had already proven the software could work outside the Alaska datacenter.  So, this task focused on validating the functionality worked when the SQL Server with hybrid connection manager (HCM) node moved into a State of Alaska hosting environment.  Technically, the product team saw this as a simple task to:

1. Build a Windows server
2. Install and configure Microsoft Hybrid Connection Manager (HCM)
3. Install and configure Microsoft SQL Server
4. Add a dummy database and dummy data to SQL Server
5. Test connecting from the existing prototype Azure PaaS App Service app to the AK hosted SQL Server and reading the dummy data.

The intention for this product backlog item was to succeed or fail without asking for any environment changes beyoned creating the HSSARIES-SQEXT host in the OIT internal data center (IDC).  We expected to complete this task within a two week sprint scheduled from 6/5/2017 - 6/16/2017.

### Case Study Events
This section documents signficant meetings, discussions and activities the EIS-R product team engaged in to work Trello #136.(TBD interview DSO and Ops to improve with their versions of what happened)

#### Consulting Operations: Development and Operations "SQL Gateway" meeting
On 5/24/2017 (prior to the 6/5 - 6/16 sprint) DHSS Business Applications (Development) and Operations met to discuss how to proceed with installing "SQL Gateway" on a server.  SQL Gateway is a software component that supports .NET based data access to mainframe ADABAS services that the product team planned to use to test connectivity to EIS Test data.  SQL Gateway was required for Trello card #141 "Set up Linked Server to SQL Gateway (ODBC)", which was related to Trello card #136, but different scope.  Trello #161 was anticipated as either a completely separate test, or a later test than Trello #136. Implicit in the meeting agenda was that we expected to need a new server host and we were looking for input on whether it should be created in the DHSS or OIT datacenter.  The feedback was that Operations did not really understand our request and would want to understand what we were really trying to do before making any recommendations.  Either during or as a follow-up to this meeting, Operations also recommended Development may want to check with the DSO to get their input.

#### Consulting Security: Development and Security Discussions/meetings and Approval
Development met with the DSO who suggested we set up the HCM and SQL Server configuration on a Windows 7 desktop outside both the DHSS and OIT datacenters.  Development attempted that, but the software would not run correctly on a Windows 7 desktop.

Development advised the DSO that the desktop configuration would not work and we needed a Windows Server host.  The DSO indicated that under the condition it was a prototype, and was not connecting to ARIES Test or EIS Test we could move forward with creating a server and doing the test.  (_Development believes there was probably some miscommunication at this point about the conditions the DSO wanted to convey. We should follow up on this._)

#### Preparing the Test: Creating and Configuring the HSSARIES-SQEXT Host 
Development contacted Chris Jones with OIT and discussed the requested host.  Development then created SDM ticket 105366 and requested a new server host, "HSSARIES-SQEXT", with the stipulation that the new host must have no access to ARIES.

Development then granted access to the 18F technical resource attempting to execute the test and worked with the 18F technical resource to install and configure the HCM and SQL Server components.

#### Executing the Test: Testing Azure PaaS App Service app connection to HSSARIESSQ-EXT
At this point, the 18F technical resource proceeded with the testing.  The first attempt did not succeed.  So, the 18F technical resource began troubleshooting.  

#### Stopping Work: Security Office Determination of Unknown Risks
Before 18F could complete troubleshooting the failed test, the DSO heard something (_follow-up: what did they hear?  Something in the weekly DevOps Show and Tell on 6/14?_) that made them worried we were doing something very risky to production ARIES.  Around 6/15/2017, the DSO contacted Chris Jones at OIT and suggested that the server should be shutdown due to unacceptable security risks.  Based on the report from the DHSS DSO, OIT heard a request that the server be shutdown and complied, which terminated the testing and troubleshooting 18F was performing.  

#### Assessing Risk: Meetings and a "Security Plan"
At this point, meetings and discussions ensued to understand what we were "really doing" and what the risks were.  Development tried to comply with the request by articulating the big picture of the full prototype testing objectives, i.e., all objectives including those beyond Trello #136.  Development also tried to clarify that, while less than ideal, we did not need to do everything at once.  I.e., If it would reduce risk to an acceptable level, we could test the Azure PaaS App Service to HSSARIESSQ-EXT and then disconnect that link completely before testing the data access to ARIES Test.  

The DSO indicated their view that our efforts were creating a "$2 billion" risk to the ARIES production system.  Development found this very confusing because we were not connected in any way to ARIES Test.  Additionally, while we _did_ plan to connect to ARIES Test at some point, we expected the approved ARIES System Security Plan indicated that ARIES Production was sufficiently secured from ARIES Test to be considered safe from changes made to the ARIES Test environment.

These meetings and discussions resulted in an agreement to complete an "abbreviated security plan".  An abbreviated security plan is not a formally recognized work-product in DHSS policy and procedure.  Even the abbreviated security plan involves significant effort.  During the first review of the abbreviated security plan with the DSO, the plan invoked additional questions and the Development and Operations staff are currently in process of revising the plan.

### Initial Conclusions
Culturally and organizationally, this scenario invoked a number of challenges and opportunities, which we have drafted below.  Operations and Security were unable to provide input during the sprint in which we draft this initial plan.  We intend to update this document with additional Operations and Security input at later point in time.

#### Secure Development Infrastructure (and Practice)
There is no agreed procedure that explicitly allows assigned DHSS technical Development staff to securely establish and leverage development and test infrastructure.  The procedure that is recognized treats all infrastructure equally.  So, any development infrastructure is expected to meet the same bar as a fully fledged production system in both understanding a complete picture of what that infrastructure does, and in documenting that it does so securely.  Since the effort to achieve this prior to testing technical software and service features is actually untenable when integrating new software components, there is effectively no procedure. 

#### Datacenter and Hosting Design
The DHSS Operations staff historically owns the "what, where, why, how" of creating hosts.  Operations staff have substantial expertise in the DHSS and OIT datacenter environments that Development has no other source to rely upon for design concepts.  Additionally, Operations staff have significant influence over Development's ability move forward.  When a proposed design concept from Development is not understood by Operations, Operations may choose to block the effort.  Like any good technical team, Operations is hesitant to sanction or approve any design concepts they do not understand.  

Development and Operations do not have a published and shared set of design standards, and do not have an operating level agreement (OLA) that dictates what Development can request from Operations and how Development must request it.  So, Development initiatives inevitably end up bogged down in a series of meetings and exercises where Operations staff want to know "what we're doing" when we make such a request.  Note that all of these problems are exacerbated in infrastructure as a service scenarios like the OIT flex-pod hosting environment and, in the future, Azure cloud.  Without policy and procedure that delegates a clear level of authority to support research and design work by Development, Development is always subject to Operations and Security veto of exploring technical ideas.

#### Trust, Procedures and DevOps
One area that DHSS Development, Operations and Security staff excel at is interpersonal relations and trust-building.  The IT management team recognizes the pitfalls of getting stuck, and they have evolved a team with good communications skills.  This results in a base level of trust: the shared perception that everyone is on the same team and - while first and foremost covering their own domain - everyone is genuinely working to help the rest of the team.  

Throughout this case study, we talk about "Development, Operations and Security" as separate entities.  The traditional domain walls that DevOps aims to remove are fully intact throughout much of the story.  The flexibility in these walls at DHSS is likely mostly due to good management communication and a minimum of procedural walls insulating each domain from the other.  In some ways, we are not positioned so far from a DevOps world.

The most significant challenge DHSS may face, however, is that our agreed upon procedures do not provide enough support for really accelerating the work; trust by itself is not enough for domain experts to know their requirements are being met.  The opportunity at DHSS is that a minimum of procedures can more easily be tailored to a DevOps world.  The retrofit/remodel to move from a traditional Development, Operations, Security silo organization to a DevOps organization may be easier than elsewhere.

## Other Challenges and Opportunities
This section identifies more general challenges and opportunities to unblock work that we need to address by communicating across development, operations and security to support DevOps work getting done and ensure each domain's requirements are met.  The information in this section should be refined and also turned into specific backlog work, where appropriate, to improve our DevOps practice.

### Development Related Opportunities
The following topics identify opportunities that might inform improved DevOps practices related the Development domain concerns:
* How can the Dev domain work be formalized?  E.g., procedures, design and communication templates/standards, checklists (e.g., P Wilkins email to S Taylor)
* How do we educate our team to understand the question, "When is a change just another day of development and when is a change a _change_?"
* Development => change, including environment change.  Environment change => security risks.  Security risks => security documentation and and security office review, education and approval.  Security documentation and SO review, ed, and approval => weeks or months of time.  _The existing process does not seem to scale to multiple environment changes in short periods of time._  How can we structure our development processes, artifacts and teams to efficiently address the security risks of development?

### Operations Related Opportunities
The following topics identify opportunities that might inform improved DevOps practices related to the Operations domain concerns:
* What is the infrastructure team's role in the design process for an application that communicates across datacenters?
* What are the operational responsibilities the infrastructure team carries that are impacted by Azure App Service PaaS?
* What are the enterprise services the infrastructure/ops team owns that we are relying on (is there an implicit or explicit service/operating level agreement we are correctly/incorrectly engaging)?
* How do we engage infrastructure/ops team if we're asking them to do something new?
* Do we have preferences for future operational support about who is responsible for technical service monitoring and first response for cloud hosted applications?

### Security Related Opportunities
The following topics identify opportunities that might inform improved DevOps practices realted to the Security domain concerns:
* Assessing MS Azure FedRamp docs and understanding which controls the application developer/product team are responsible for (i.e., that we own and MS does not).  This will be a large effort that should be broken up into sprints.
    - Create backlog stories corresponding to specific sets of controls or to control families
    - Stories are about work-products that meet three specific requirements:
        + Identify what we have to add to the control (something we can refer back to in the future)
        + Determine whether already meet our identified obligations for the control (fully, partially, unmet)
        + Document how we meet the control and an plan of action and milestones story required as a backlog item categorized under the control identifier
* What is the Security MVP that supports new or changed non-production (dev/staging/etc) environments?
* How can a security plan be broken up into small enough chunks to get definable work done inside a series of two week sprints?  Note: "done" means done - no technical debt left to discover at the end?
    - Sketching a boundary diagram
    - Drafting the business needs, owners, data classification, solution description portions of a security plan
    - Drafting NIST 800-53 controls - can we draft these in some sort of sub-grouping (e.g., specific control families) that would let us draft, review and receive preliminary approval of a small subset within each two week sprint?
* How can we ensure security is part of development and does not wait until the end?  Is this DSO participation on the team, or DSO delegation to members of the team?

# Document History
| Author | Date | Comments |
|-------|:--------|:--------|
| S Taylor | 2017.07.14 | Completed initial draft for Trello #156|