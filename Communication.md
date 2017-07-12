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

## Opportunities
This section identifies blocking opportunities that we need to address by communicating across development, operations and security to support DevOps work getting done and ensure each domain's requirements are met.

### Development Related Opportunities
TBD

### Operations Related Opportunities
The following topics identify blockers that might inform improved DevOps practices related to the Operations area of responsibility:
* What is the infrastructure team's role in the design process for an application that communicates across datacenters?
* What are the operational responsibilities the infrastructure team carries that are impacted by Azure App Service PaaS?
* What are the enterprise services the infrastructure/ops team owns that we are relying on (is there an implicit or explicit service/operating level agreement we are correctly/incorrectly engaging)?
* How do we engage infrastructure/ops team if we're asking them to do something new?
* Do we have preferences for future operational support about who is responsible for technical service monitoring and first response for cloud hosted applications?

### Security Related Opportunities
The following topics identify blockers that might inform improved DevOps practices realted to the Security area of responsibility:
* Assessing MS Azure FedRamp docs and understanding which controls the application developer/product team are responsible for (i.e., that we own and MS does not)
* What is the Security MVP that supports new or changed non-production (dev/staging/etc) environments?
* How can a security plan be broken up into small enough chunks to get definable work done inside a series of two week sprints?  Note: "done" means done - no technical debt left to discover at the end?
    - Sketching a boundary diagram
    - Drafting the business needs, owners, data classification, solution description portions of a security plan
    - Drafting NIST 800-53 controls - can we draft these in some sort of sub-grouping (e.g., specific control families) that would let us draft, review and receive preliminary approval of a small subset within each two week sprint?