using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;

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

            string _serverName = "localhost";
            string _dataBaseName = "AKTestDataBase";
            string _userID = "SA";
            string _password = "BaldEagle123";
            string _connectionStringTempalte = "Server=tcp:{0};Initial Catalog={1};Persist Security Info=False;User ID={2};Password={3}";
            string connectionString = String.Format(_connectionStringTempalte, _serverName, _dataBaseName, _userID, _password);
            string qresult = "";
            using (var connection = new SqlConnection(connectionString))
            {
                try
                {
                    var command = new SqlCommand("SELECT * FROM Employees", connection);
                    connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            qresult += $"Employee #{reader[0]}: {reader[1]}, State: {reader[2]}\r\n";
                        }
                    }
                }
                catch (SqlException ex)
                {
                    Console.WriteLine("ERROR: " + ex.Message);
                }
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
