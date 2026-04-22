namespace Web.Areas.Parameters.Controllers
{
    using Common.Extensions;
    using Common.ViewModels.Parameters;
    using Common.ViewModels.User;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Identity;
    using Microsoft.AspNetCore.Mvc;
    using Services.Interfaces.Izbori;
    using Services.Interfaces.Parameters;
    using Services.Interfaces.Sik;
    using Services.Interfaces.User;
    using System;

    [Area("Parameters")]
    [Authorize(Roles = "Администратор,Оператор,ОИК/РИК")]

    public class HomeController : Controller
    {
        private readonly IParametersServices _parametersServices;
        private readonly IIzboriServices _izboriServices;
        private readonly ISikServices _sikServices;
        private readonly IUserServices _userServices;
        private readonly UserManager<SSOUserIdentity> _userManager;

        public HomeController(IParametersServices parametersServices, IIzboriServices izboriServices, ISikServices sikServices, IUserServices userServices, UserManager<SSOUserIdentity> userManager)
        {
            _userServices = userServices;
            _userManager = userManager;
            _sikServices = sikServices;
            _izboriServices = izboriServices;
            _parametersServices = parametersServices;
        }

        public IActionResult CommonIndex()
        {
            string administrativen = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            var izbRajonParameters = _parametersServices.GetIzbRajonParameters(_izboriServices.GetIzborAlias());

            return View("CommonIndex", izbRajonParameters);
        }

        public IActionResult Index()
        {
            var allParameters = _parametersServices.GetAllParametersByIzbor(_izboriServices.GetIzborAlias());

            return View("Index", allParameters);
        }

        public JsonResult GetParameterEdit(string kod)
        {
            var parameter = _parametersServices.GetParameterByKod(kod);

            try
            {
                DateTime d = DateTime.ParseExact(parameter.Znachenie, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                parameter.Znachenie = d.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
            }
            catch (Exception e) { }

            var editModalHtmlAsString = this.RenderViewAsync("../PartialViews/ParameterEditPartial", parameter, true).Result;

            return Json(new
            {
                editModalHTML = editModalHtmlAsString
            });
        }

        public JsonResult EditParameter(ParametersViewModel parameter)
        {
            if (ModelState.IsValid)
            {
                if (parameter.Kod == "52" || parameter.Kod == "53" || parameter.Kod == "54" || parameter.Kod == "55")
                {
                    try
                    {
                        DateTime d = DateTime.ParseExact(parameter.Znachenie, "yyyy-MM-dd",System.Globalization.CultureInfo.InvariantCulture);
                        parameter.Znachenie =  d.ToString("dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                    }
                    catch (Exception e) { }
                }

                _parametersServices.EditParameter(parameter);
                return Json(new { success = true });
            }

            var editModalHtmlAsString = this.RenderViewAsync("../PartialViews/ParameterEditPartial", parameter, true).Result;

            return Json(new
            {
                success = false,
                editModalHTML = editModalHtmlAsString
            });
        }

        
        public JsonResult GetIzbRajonParameterEdit(string kod)
        {
            var parameter = _parametersServices.GetIzbRajonParametersByKod(kod);

            var editModalHtmlAsString = this.RenderViewAsync("../PartialViews/IzbRajonParameterEdit", parameter, true).Result;

            return Json(new
            {
                editModalHTML = editModalHtmlAsString
            });
        }


        public JsonResult EditIzbRajonParameter(IzbRajonParamViewModel parameter)
        {
            if (ModelState.IsValid)
            {
                _parametersServices.EditIzbRajonParameter(parameter);
                return Json(new { success = true });
            }

            var editModalHtmlAsString = this.RenderViewAsync("../PartialViews/IzbRajonParameterEdit", parameter, true).Result;

            return Json(new
            {
                success = false,
                editModalHTML = editModalHtmlAsString
            });
        }

        //v.2
        public IActionResult NomenIndex()
        {
            var nomevlatures = _parametersServices.GetNomenclatures();
            return View("NomenIndex", nomevlatures);
        }

        public JsonResult GetNomenlatureEdit(int Id)
        {
            var parameter = _parametersServices.GetNomenclatureByKod(Id);

            var editModalHtmlAsString = this.RenderViewAsync("../PartialViews/NomenclatureEditPartial", parameter, true).Result;

            return Json(new
            {
                editModalHTML = editModalHtmlAsString
            });
        }


        public JsonResult EditNomenclature(NomenclaturesViewModel parameter)
        {
            if (ModelState.IsValid)
            {
                _parametersServices.EditNomenclature(parameter);
                return Json(new { success = true });
            }

            var editModalHtmlAsString = this.RenderViewAsync("../PartialViews/NomenclatureEditPartial", parameter, true).Result;

            return Json(new
            {
                success = false,
                editModalHTML = editModalHtmlAsString
            });
        }

        public IActionResult IzbDateIndex()
        {
            var IzbDateViewModel = _parametersServices.GetNTopMain();

            return View("IzbDateIndex", IzbDateViewModel);
        }

        public IActionResult EditNTopMain(IzbDateViewModel parameter)
        {
            if (ModelState.IsValid)
            {
                _parametersServices.EditNTopMain(parameter);
            }

            return Redirect("/Admin/Home/IndexAdditionalSets");
        }
    }
}