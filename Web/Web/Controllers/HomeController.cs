namespace Web.Controllers
{
    using System.Collections.Generic;
    using System.Diagnostics;
    using Microsoft.AspNetCore.Mvc;
    using Web.Models;
    using Microsoft.AspNetCore.Identity;
    using Common.ViewModels.User;
    using Services.Interfaces.User;
    using Common.ViewModels.Raion;
    using Microsoft.AspNetCore.Authorization;
    using Services.Interfaces.Izbori;
    using Common.ViewModels.Izbori;
    using Services.Interfaces.Raion;
    using Services.Interfaces.Spravki;

    [Authorize(Roles = "Администратор,Оператор,ОИК/РИК")]
    public class HomeController : Controller
    {
        private readonly IUserServices _userServices;
        private readonly IIzboriServices _izborServices;
        private readonly IRaionServices _raioniServices;
        private readonly ISpravkiServices _spravkiServices;
        private readonly UserManager<SSOUserIdentity> _userManager;

        public HomeController(IUserServices userServices
            , IIzboriServices izboriServices
            , UserManager<SSOUserIdentity> userManager
            , IRaionServices raioniServices
            , ISpravkiServices spravkiServices
        )
        {
            _spravkiServices = spravkiServices;
            _izborServices = izboriServices;
            _userServices = userServices;
            _userManager = userManager;
            _raioniServices = raioniServices;
        }

        public IActionResult Index()
        {
            if(User.Identity.IsAuthenticated == true)
            {
                var userRegions = _userServices.GetUserWithRegions(_userManager.GetUserId(User));

                return View(new IzboriCompositeViewModel
                {
                    DashboardSpravka = _spravkiServices.GetDashboardSpravka(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id,_userManager.GetUserId(User)),
                    UserRegions = userRegions.allRaioni,
                    AllRegions = _raioniServices.GetAllRaioni(null),
                    IzborAlias = _izborServices.GetIzborDescription(),
                    IzborTur = _izborServices.getIzborTur(),
                    IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false
                });
            }

            return View(new IzboriCompositeViewModel
            {
                DashboardSpravka = _spravkiServices.GetDashboardSpravka(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id, _userManager.GetUserId(User)),
                UserRegions = new List<RaionViewModel>(),
                IzborAlias = _izborServices.GetIzborDescription(),
                IzborTur = _izborServices.getIzborTur(),
                IsUserGlobal = true
            });
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public JsonResult UpdateUserAdministrativenRaion(string administrativenRaion)
        {
            _userServices.UpdateUserAdministrativenRaion(_userManager.GetUserId(User), administrativenRaion);
            return Json(new { success = true });
        }
    }
}
