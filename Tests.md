# Tests

We run automated tests for a project as a step in our CI build pipeline.
Developers will also run these tests locally.

## Run Tests
The Dotnet CLI provides `dotnet test`:

```
cd aspnetapp
dotnet restore
dotnet test
```

This will run all tests associated with the project

See [our prototype](https://github.com/AlaskaDHSS/ProtoWebApi) for example tests.