# This is a DSC configuration for an IIS WebServer

configuration WebServer {
  Node "localhost"
  {
    # This example creates a folder
    File FileDemo {
      Type = 'Directory'
      DestinationPath = 'C:\AKWASHERE'
      Ensure = "Present"
    }

    # Enable IIS web sever
    WindowsFeature InstallWebServer
		{
			Ensure = "Present"
			Name = "Web-Server"
		}
  }
}

# Compile the configuration file to a MOF format
WebServer

# Run the configuration on localhost
Start-DscConfiguration -Path .\WebServer -Wait -Force -Verbose