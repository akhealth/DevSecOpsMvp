using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using System.Diagnostics;

namespace aspnetapp.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View("Index");
        }

        public IActionResult About()
        {
            // Local/Docker (SQL Server Auth)
            // string _serverName = "localhost";
            // string _dataBaseName = "AKTestDataBase";
            // string _userID = "SA";
            // string _password = "BaldEagle123";

            // Remote/Hybrid (SQL Server Auth)
            string _serverName = "vagrant-win10"; // aka `hostname`
            string _dataBaseName = "AKTestDataBase";
            string _userID = "hybuser";
            string _password = "hybpass";


            string _connectionStringTempalte = "Server={0},1433;Database={1};User ID={2};Password={3}";
            string connectionString = String.Format(_connectionStringTempalte, _serverName, _dataBaseName, _userID, _password);
            string qresult = "";

            Console.WriteLine("CONNECTION: " + connectionString);
            Trace.TraceError("CONNECTION: " + connectionString);
            using (var connection = new SqlConnection(connectionString))
            {
                //try
                //{
                    var command = new SqlCommand("SELECT * FROM Employees", connection);
                    connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            qresult += $"Employee #{reader[0]}: {reader[1]}, State: {reader[2]}\r\n";
                        }
                    }
                // }
                // catch (SqlException ex)
                // {
                //     Trace.TraceError("ERROR: " + ex.Message);
                //     Console.WriteLine("ERROR: " + ex.Message);
                // }
            }
            
            ViewData["Message"] = qresult; 
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
