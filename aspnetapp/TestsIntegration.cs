using aspnetapp.Controllers;
using aspnetapp;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Xunit;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.TestHost;
using System.IO;

// This is an example of Unit and Integration tests using the xUnit framework

namespace AspNetAppTests.Controllers.Integration
{

    public class HomeControllerIntegration
    {
        private readonly TestServer _server;
        private readonly HttpClient _client;
        public HomeControllerIntegration()
        {
        // Arrange

        _server = new TestServer(new WebHostBuilder().UseStartup<Startup>().UseContentRoot(Directory.GetCurrentDirectory()));
        _client = _server.CreateClient();
        }

        [Fact]
        public async Task TestRenderedIndex()
        {
            // Act
            var response = await _client.GetAsync("/");
            response.EnsureSuccessStatusCode();
            var responseString = await response.Content.ReadAsStringAsync();

           // Assert
           Assert.Equal("Hello World!",
            responseString);
           }


    }
}
