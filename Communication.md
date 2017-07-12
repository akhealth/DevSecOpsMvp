# DevOps Communication Plan
DevOps is a new practice for DHSS.  Adopting this practice requires us to identify a communication plan.  The communication plan should address any regular/ongoing communication needs and methods.  This communication plan will also include known blocking-issue topics for Development, Operations and Security units at DHSS to address and resolve.  These topics can be further detailed and addressed as they become relevant in the work through the product team's backlog management tool.

## Regular/standing Communications
There are several standing communication methods to use for both planning and executing work, including:
* Bi-weekly sprint review/retro/grooming/planning meetings
* DevOps weekly standing show and tell meeting
* Daily product team standup/scrum
* Trello (tagged comments on individual cards)
* VSTS (tagged comments in pull requests)
* Slack (out-of-email-band messaging)

### Security and Operations Participation
Whenever possible, the product team should have a delegate of the security and operations domain organizations on the product team.  However, whenever there are proposed environment changes in the sprint scope, we _must_ have security and operations delegates on the product team for at least that sprint.

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