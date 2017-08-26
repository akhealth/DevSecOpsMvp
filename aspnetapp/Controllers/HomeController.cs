using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Xml.Linq;
using Npgsql;
using System.Net;
using System.IO;


namespace aspnetapp.Controllers
{
  public class HomeController : Controller
  {
    public IActionResult Index()
    {
      ViewData["WelcomeMessage"] = "Thanks for visiting the DevSecOps MVP demo website!";
      return View("Index");
    }

    public IActionResult About()
    {
      //------------------------------------------------------------------------------------------
      //SQL Server proof
      string connectionString = String.Format(
          "Server={0},1433;Database={1};User ID={2};Password={3}",
          Environment.GetEnvironmentVariable("SqlServerName"),
          Environment.GetEnvironmentVariable("SqlDataBaseName"),
          Environment.GetEnvironmentVariable("SqlUserID"),
          Environment.GetEnvironmentVariable("SqlPassword"));
      string SQLresult = "";

      //Console.WriteLine("CONNECTION: " + connectionString);
      //Trace.TraceError("CONNECTION: " + connectionString);
      try
      {
        using (var connection = new SqlConnection(connectionString))
        {
          var command = new SqlCommand($"SELECT * FROM {Environment.GetEnvironmentVariable("SqlTableName")}", connection);
          connection.Open();
          using (var reader = command.ExecuteReader())
          {
            while (reader.Read())
              SQLresult += $"ID #{reader[0]}: {reader[1]}, {reader[2]}\r\n";
          }
        }
      }
      catch
      {
        SQLresult = $"Problems connecting to: {connectionString}";
      }


      //------------------------------------------------------------------------------------------
      // SOAP/XML endpoint proof
      string SOAPresult = "";
      var targetUri = new Uri("https://esbtest.dhss.alaska.gov/MCIPersonService/PersonService.svc?singleWsdl");

      try
      {
        var request = System.Net.HttpWebRequest.Create(targetUri);
        var stream = request.GetResponseAsync().Result.GetResponseStream();
        var sreader = new StreamReader(stream);

        SOAPresult = sreader.ReadToEnd();
      }
      catch
      {
        SOAPresult = $"Problems connecting to: {targetUri}";
      }

      //------------------------------------------------------------------------------------------
      // Postgres server proof
      // http://www.npgsql.org/efcore/index.html#using-an-existing-database-database-first

      string PGresult = "";
      string PGconnectionString = Environment.GetEnvironmentVariable("PgConnectionString");

      try
      {
        NpgsqlConnection conn = new NpgsqlConnection(PGconnectionString);
        conn.Open();
        NpgsqlCommand cmd = new NpgsqlCommand($"select * from {Environment.GetEnvironmentVariable("PgTable")} limit 100", conn);

        // Execute a query
        NpgsqlDataReader dr = cmd.ExecuteReader();

        // Read all rows and output the first column in each row 
        while (dr.Read())
          PGresult += $"{dr[0]}: {dr[1]}, {dr[2]}\r\n";

        // Close connection
        conn.Close();
      }
      catch
      {
        PGresult = $"Problems connecting to: {PGconnectionString}";
      }

      // Set up view
      ViewData["SQL"] = SQLresult;
      ViewData["SOAP"] = SOAPresult;
      ViewData["PG"] = PGresult;

      return View("About");
    }

    public IActionResult Contact()
    {
      ViewData["Message"] = "Your contact page.";

      return View("Contact");
    }

    public IActionResult Error()
    {
      return View("Error");
    }
  }
}
