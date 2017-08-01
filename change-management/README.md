# Change Management

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
5. Push your feature branch to VSTS, triggering Continuous Integration.
6. Ensure that the new CI build is successful.
7. Create a Pull Request in VSTS from your feature branch into `staging`.
8. Communicate with others about your changes, receive feedback in the PR.
9. Receive approval and satisfy any other merge gates on the PR.
10. Merge the changes into `staging` thereby closing the PR.
11. Ensure the new CI build on `staging` is successful.
12. Observe Continuous Delivery and deployment of changes to the staging environment. 