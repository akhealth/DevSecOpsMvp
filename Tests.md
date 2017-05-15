# Tests

The "Console Runner", `VSTest.Console.exe`, is the latest MS provided test runner.

The Dotnet CLI provides `dotnet test`.  Wonder if this is == to the .exe above?

Good walkthrough? https://docs.microsoft.com/en-us/aspnet/mvc/overview/older-versions-1/unit-testing/creating-unit-tests-for-asp-net-mvc-applications-cs


## Incorporate with other docs after rebase:

### Development
Run aspnetapp tests

```
cd aspnetapp
dotnet restore
dotnet test
```

see `aspnetapp/Tests.cs` for details about tests
