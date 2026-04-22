using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers
{
    public class HelpController : Controller
    {
        private readonly IHostingEnvironment _hostingEnvironment; 

        public HelpController (IHostingEnvironment prmIHosting)
        {
            _hostingEnvironment = prmIHosting;
        }

       public IActionResult Index()
        {
            return View();
        }


        public FileResult DownloadHelpFile()
        {
            string filename = Path.Combine(_hostingEnvironment.WebRootPath, "help").ToString() + "/" + "User_Manual_Izbori.doc";
            byte[] bytearray = System.IO.File.ReadAllBytes(filename);

            return File(bytearray
                        , System.Net.Mime.MediaTypeNames.Application.Octet
                        , "User_Manual_Izbori.doc");
        }

    }
}