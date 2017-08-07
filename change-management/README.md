# Change Management

Here, change management refers to the process by which code is changed and deployed. The code in question could be a web application like [our demo asp.net app](../aspnetapp), [scripts run during build processes](../opensource/push-to-github.ps1), [infrastructure code](../terraform/aspnetapp.tf), etc.

Change management process starts with new work and ends with deployment.

## Screencast

Please see [change-management-screencast.mp4](./change-management-screencast.mp4) for a video overview of our change management process including

- VSTS project management
- Git repositories, branches
- Automated tests
- Pull requests and peer review
- Continuous Integration and Continuous Delivery
- Deployment to Azure AppService PaaS

## Ordered List

Following is an ordered list that covers change management in a similar way to the screencast.

1. To start new work visit VSTS find a story in your current sprint and mark it "in progress".
2. Use git locally to cut a new feature branch from `staging`.
3. Code your changes.
4. Run automated test suite locally and ensure it is successful.
5. Push your feature branch to VSTS.
6. Create a Pull Request in VSTS from your feature branch into `staging`.
7. Ensure that the Continuous Integration build associated with the PR is successful.
8. Communicate with others about your changes, receive feedback in the PR.
9. Receive approval and satisfy any other merge gates on the PR.
10. Someone, usually not you, merges the changes into `staging` thereby closing the PR.
11. Ensure the new CI build on `staging` is successful.
12. Observe Continuous Delivery and deployment of changes to the staging environment. 