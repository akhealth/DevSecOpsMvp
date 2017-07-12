# DevOps Communication Plan
DevOps is a new practice for DHSS.  The goal of the practice is to improve change management and remove delivery walls between the development, operations and security domains.  Ideally, the delivery processes ensure that all domain stakeholders' requirements are met as part of the process and, as a result, delivery speed _and quality_ of change to our customers and end-users increases.  _If quality is not good, delivery speed **will not** increase._

Adopting this practice requires us to identify a communication plan that supports improving our DevOps and agile practices and addressing requirements that arise from the development, operations and security domain organizations at DHSS.  The communication plan addresses:
* Regular/standing communication needs and methods
* Security and operations participation expectations
* DevOps education resources
* Opportunities within each of the development, operations and security domains to improve how we do business by unblocking traditionally long and sticky processes

This communication plan can and should be refined.  In particular, the product team will update and use the [Unblocking Opportunities](#unblocking-opportunities) section content to identify and implement improvements, as needs/sticking points arise in the work managed via the product team's backlog.

## Regular/standing Communications
There are several standing communication methods to use for both planning and executing work, including:
* Bi-weekly sprint review/retro/grooming/planning meetings
* DevOps weekly standing show and tell meeting
* Daily product team standup/scrum
* Trello (tagged comments on individual cards)
* VSTS (tagged comments in pull requests)
* Slack (out-of-email-band messaging)

## Development, Security and Operations Participation
The product team will have at least one member of the DHSS development domain organizational unit at all times.  Whenever possible, the product team should have a delegate of the security and operations domain organizations on the product team participating in the sprint.  However, we must have two types of security and operations activity/participation/support at all times:
* There must always be a designated security and operations representative on the team.  The designated individual(s) are responsible for identifying security and operations related concerns that may unexpectedly arise in the course of a sprint, and working with the product team to scope and address security and operations domain requirements.  These individuals could be assigned directly from the DHSS security and operations support organization units or delegated to others, as the security and operations units see fit.
* Whenever there are proposed environment changes in the sprint scope, we _must_ have security and operations delegates on the product team for at least that sprint (including planning) to task and execute work-products that meet the security and operations requirements.

## DevOps Education Resources
The EIS-R project has developed a number of resources to support individuals new to DevOps and/or new to the EIS-R team.  These resources include:
| Resource | Purpose |
|----------------|:-------------------|
| [Project Readme](https://github.com/18F/acq-alaska-dhss-modernization/blob/master/README.md)|Background information on the EIS-R project.  Includes our approach/strategy and links to mission model canvas and product roadmap | 
| [Project DevOps Vision](https://github.com/dhssalaska/DevOpsMvp/blob/master/DevOps.md) | Our project vision for the value of DevOps and our goals in using it |
| [Project DevOps MVP](https://github.com/dhssalaska/DevOpsMvp) | Our project repository containing the documentation, sample code, and learning we've done for our DevOps tool and process "minimum viable product" (MVP) |

## Unblocking Opportunities
This section identifies opportunities to unblock work that we need to address by communicating across development, operations and security to support DevOps work getting done and ensure each domain's requirements are met.

### Development Related Opportunities
The following topics identify opportunities that might inform improved DevOps practices related the Development area of responsibility:
* How can the Dev domain work be formalized?  E.g., procedures, design and communication templates/standards, checklists (e.g., P Wilkins email to S Taylor)
* How do we educate our team to understand the question, "When is a change just another day of development and when is a change a _change_?"
* Development => change, including environment change.  Environment change => security risks.  Security risks => security documentation and and security office review, education and approval.  Security documentation and SO review, ed, and approval => weeks or months of time.  _The existing process does not seem to scale to multiple environment changes in short periods of time._  How can we structure our development processes, artifacts and teams to efficiently address the security risks of development?

### Operations Related Opportunities
The following topics identify opportunities that might inform improved DevOps practices related to the Operations area of responsibility:
* What is the infrastructure team's role in the design process for an application that communicates across datacenters?
* What are the operational responsibilities the infrastructure team carries that are impacted by Azure App Service PaaS?
* What are the enterprise services the infrastructure/ops team owns that we are relying on (is there an implicit or explicit service/operating level agreement we are correctly/incorrectly engaging)?
* How do we engage infrastructure/ops team if we're asking them to do something new?
* Do we have preferences for future operational support about who is responsible for technical service monitoring and first response for cloud hosted applications?

### Security Related Opportunities
The following topics identify opportunities that might inform improved DevOps practices realted to the Security area of responsibility:
* Assessing MS Azure FedRamp docs and understanding which controls the application developer/product team are responsible for (i.e., that we own and MS does not)
* What is the Security MVP that supports new or changed non-production (dev/staging/etc) environments?
* How can a security plan be broken up into small enough chunks to get definable work done inside a series of two week sprints?  Note: "done" means done - no technical debt left to discover at the end?
    - Sketching a boundary diagram
    - Drafting the business needs, owners, data classification, solution description portions of a security plan
    - Drafting NIST 800-53 controls - can we draft these in some sort of sub-grouping (e.g., specific control families) that would let us draft, review and receive preliminary approval of a small subset within each two week sprint?