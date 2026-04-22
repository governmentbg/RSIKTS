using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Common.ViewModels.About;
using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers
{
    public class AboutController : Controller
    {
        public IActionResult Index()
        {
            return View(new AboutViewModel());
        }
    }
}