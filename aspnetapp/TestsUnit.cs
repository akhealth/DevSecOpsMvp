using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.AspNetCore.Mvc;
using aspnetapp.Controllers;
using System;

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

            // Simple debugging
            //Console.WriteLine($"******** {result.ViewName} ********");

            Assert.AreEqual("Index", result.ViewName);
        }

        // Comment out for now, don't need to worry about testing SQL queries yet.
        //[TestMethod]
        // public void TestAboutView()
        // {
        //     var controller = new HomeController();
        //     var result = controller.About() as ViewResult;

        //     Assert.AreEqual("About", result.ViewName);
        // }

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
