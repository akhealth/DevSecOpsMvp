# Tests

We run automated tests as a step in our CI build pipeline.
Developers will also run these tests locally.


## Run Tests
The Dotnet CLI provides `dotnet test`:

```
cd aspnetapp
dotnet restore
dotnet test
```

This will run all tests associated with the project

## Test frameworks
There are a couple test frameworks available for dotnet.  I'm not passing judgement about which framework is better -- they will support different needs, developers will have preferences. So, we include two examples here.

### MSTest
We demo **Unit** tests with MSTest
This is the built-in framework and seems to work well for unit tests.
See `aspnetapp/TestsUnit.cs` for details about unit tests in MSTest.


### xUnit
We demo **Integration** tests with xUnit.
TODO: Integration test doesn't work yet, some info: https://docs.microsoft.com/en-us/aspnet/core/testing/integration-testing

[xUnit](https://xunit.github.io/) might be the most popular option. It seems more possible here to run integration tests.
See `aspnetapp/TestsIntegration.cs` for details about integration tests in xUnit.
