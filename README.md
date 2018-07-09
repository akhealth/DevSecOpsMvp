# DevSecOps MVP

**This repository contains some early experiments with DevOps tools and practices used by the AK DHSS. Current tools, standards and practices are now maintained in a private VSTS Git repo and is shared with vendors engaged on projects. `This repo is no longer actively maintained`.**

This repository represents our work in DevSecOps practices and tools, Continous Integration and Delivery for the [Alaska DHSS modernization project](https://github.com/18F/acq-alaska-dhss-modernization).
We performed a breadth-first survey of these things. Most topics exist as folders here and contain `README.md`s and various flavors of scripts.

This project aims to transform the way Alaska approaches implementation and support activities for its mission critical technology products.  We plan to do this by taking deeper ownership of the product definition and the foundational processes and tools used in exchange for steeply reduced financial and functional risks of traditional, monolithic approaches.  The foundation of this will be a State managed DevSecOps pipeline.

**First, please read [`DevSecOps.md`](DevSecOps.md). It's our idea of what DevSecOps means and why we think it's good.**

## Development
[`Development.md`](./Development.md) has info about development environments like Windows-local and Docker.
[`Tests.md`](./Tests.md) has info about running included unit and integration tests.

## Infrastructure
[`Azure.md`](./Azure.md) has info about managing Azure, including user access.

[`Infrastructure.md`](./Infrastructure.md) has info about about automated infrastructure in Azure using things like
- Powershell
- ARM templates
- `az` CLI
- [Terraform](https://terraform.io)

The `/appservice` folder contains code and docs for the Azure App Service, i.e. the Azure PaaS.

The `/sqlserver` folder contains code and docs for MS SQL Server.

The `/hybrid-connection` folder contains docs for the Hybrid Connection

## Example App
See [https://github.com/AlaskaDHSS/ProtoWebApi](https://github.com/AlaskaDHSS/ProtoWebApi) for our prototype  

## CI, CD
See `/vsts` folder for documentation around the VSTS Build and Release pipelines.
See `/deploy` folder for docs around deploying to the Azure AppService.
