namespace Web.Areas.Registri.Controllers
{
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;

    [Area("Registri")]
    [Authorize(Roles = "Администратор,Оператор,ОИК/РИК")]

    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View("Menu");
        }
    }
}