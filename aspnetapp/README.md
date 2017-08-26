# Demo ASP.Net Core app

This app was generated with the `dotnet` CLI, and then modified to prove out a couple different Cloud -> On-Prem data connections.

## Running the app

This app requires a couple different `ENV` variables.

### Locally
```
cp .env.bash.example .env.bash  #and customize the file. 
source .env.bash
dotnet run
```

### Azure AppService PaaS

In the Azure web UI navigate to your App service PaaS, then click "Application Settings" -> "App Settings".
These variables are `ENV` variables for the running app.


## Local setup

Running postgres locally on OSX
```
brew install postgres
createdb 18FDatabase
createuser localuser -P
psql 18FDatabase
CREATE TABLE people (id SERIAL, name varchar, enabled boolean);
GRANT ALL PRIVILEGES ON DATABASE "18FDatabase" TO localuser;
GRANT ALL ON ALL TABLES IN SCHEMA public TO localuser;
<Ctrl-Z>
psql -U localuser 18FDatabase
\d people
INSERT INTO people (name, enabled) VALUES('clint',true),('simon',true),('mark',true);
select * from people;
```