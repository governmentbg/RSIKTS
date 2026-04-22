namespace Web.Areas.Ulici.Controllers
{
    using System.Linq;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Services.Interfaces.Ulici;

    [Area("Ulici")]
    [Authorize(Roles = "Администратор,Оператор,ОИК/РИК")]

    public class HomeController : Controller
    {
        readonly private IUliciServices _uliciServices;

        public HomeController(IUliciServices uliciServices)
        {
            _uliciServices = uliciServices;
        }

        public JsonResult GetUliciByNaselenoMqsto(string naselenoMqstoId)
        {
            var ulici = _uliciServices.GetUliciByNaselenoMqsto(naselenoMqstoId).Select(p => new SelectListItem
            {
                Value = p.Nrec.ToString(),
                Text = p.Nime
            }).ToList();

            ulici.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });

            return Json(new
            {
                Ulici = ulici
            });
        }
    }
}