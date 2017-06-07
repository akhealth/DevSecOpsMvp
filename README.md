# DevOps MVP

This repository tracks assets of the minimum viable product for a DevOps continuous integration, continuous deployment pipeline for the [Alaska DHSS modernization project](https://github.com/18F/acq-alaska-dhss-modernization).  This project aims to transform the way Alaska approaches implementation and support activities for its mission critical technology products.  We plan to do this by taking deeper ownership of the product definition and the foundational processes and tools used in exchange for steeply reduced financial and functional risks of traditional, monolithic approaches.  The foundation of this will be a State managed DevOps pipeline.

**First, please read [`DevOps.md`](DevOps.md). It's our idea of what DevOps means and why we think it's good.**

## Development
[`Development.md`](./Development.md) has info about development environments like windows local and Docker.
[`Tests.md`](./Tests.md) has info about running included unit and integration tests.

## Infrastructure
[`Azure.md`](./Azure.md) has info about managing Azure.

[`Infrastructure.md`](./Infrastructure.md) has info about about automated infrastructure in Azure using things like
- Powershell
- ARM templates
- `az` CLI
- [Terraform](https://terraform.io)

The `/appservice` folder contains code and docs around the Azure App Service, i.e. the Azure PaaS.

The `/sqlserver` folder contains code and docs for MS SQL Server.

## Example App
See `/aspnetapp` folder for the example app that we build and deploy

## CI, CD
See `/vsts` folder for documentation around the VSTS Build and Release pipelines.
See `/deploy` folder for docs around deploying to the Azure AppService.