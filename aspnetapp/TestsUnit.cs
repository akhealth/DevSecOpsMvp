using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.AspNetCore.Mvc;
using aspnetapp.Controllers;
using System;
using System.Diagnostics;

namespace AspNetAppTests.Controllers.Unit
{

    [TestClass]
    public class HomeControllerUnit
    {

        [TestMethod]
        public void TestIndexView()
        {
            var controller = new HomeController();

            // ViewResult: https://msdn.microsoft.com/en-us/library/system.web.mvc.viewresult%28v=vs.118%29.aspx?f=255&MSPPError=-2147217396
            var result = controller.Index() as ViewResult;

            Assert.AreEqual("Index", result.ViewName);

            // Simple debugging statements *only show up when tests fail*
            // Console.WriteLine(result.ViewData["WelcomeMessage"]);

           StringAssert.Contains(result.ViewData["WelcomeMessage"].ToString(), "DevSecOps MVP");
        }

        [TestMethod]
        public void TestContactView()
        {
            var controller = new HomeController();
            var result = controller.Contact() as ViewResult;

            Assert.AreEqual("Contact", result.ViewName);
        }

        [TestMethod]
        public void TestErrorView()
        {
            var controller = new HomeController();
            var result = controller.Error() as ViewResult;

            Assert.AreEqual("Error", result.ViewName);
        }
    }
}
