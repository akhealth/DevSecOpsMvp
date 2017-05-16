# This is a DSC configuration for an IIS WebServer

configuration WebServer {
  Node "localhost"
  {
    File FileDemo {
      Type = 'Directory'
      DestinationPath = 'C:\AKWASHERE'
      Ensure = "Present"
    }
  }
}

# Compile the configuration file to a MOF format
WebServer

# Run the configuration on localhost
Start-DscConfiguration -Path .\WebServer -Wait -Force -Verbose