namespace Web.Areas.Raioni.Controllers
{
    using Common.Extensions;
    using Common.ViewModels.Raion;
    using Common.ViewModels.User;
    using Microsoft.AspNetCore.Identity;
    using Microsoft.AspNetCore.Mvc;
    using Services.Interfaces.Raion;
    using Services.Interfaces.Ulici;
    using System.Linq;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Services.Interfaces.User;
    using Microsoft.AspNetCore.Authorization;
    using Services.Interfaces.Izbori;

    [Area("Raioni")]
    [Authorize(Roles = "Администратор,Оператор,ОИК/РИК")]

    public class HomeController : Controller
    {
        readonly private IRaionServices _raioniServices;
        readonly private IUliciServices _uliciServices;
        private readonly IUserServices _userServices;
        readonly private UserManager<SSOUserIdentity> _userManager;

        public HomeController(IRaionServices raionServices, UserManager<SSOUserIdentity> userManager, IUliciServices uliciServices, IUserServices userServices)
        {
            _raioniServices = raionServices;
            _uliciServices = uliciServices;
            _userServices = userServices;
            _userManager = userManager;
        }

        public IActionResult Index()
        {
            var userId = _userManager.GetUserId(User);

            var allRaioni = _raioniServices.GetMainRaioniByUserAndPage(userId, 1, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            var maxPages = _raioniServices.GetMaxRaioniMainPagesByUser(userId, 1, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            return View("Index", new RaioniCompositeViewModel
            {
                CurrentPage = 1,
                AllRaioni = allRaioni,
                MaxPages = maxPages,
                RaionAddModel = _raioniServices.GetRaionAddViewModel(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id)
            });
        }

        public IActionResult RaionEdit()
        {
            var raionEdit = _raioniServices.GetRaionMain(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            return View("Index_v2", raionEdit);
        }

        public JsonResult GetRaioniMainByPageAndUser(RaioniCompositeViewModel paginationModel)
        {
            var userId = _userManager.GetUserId(User);

            paginationModel.MaxPages = _raioniServices.GetMaxRaioniMainPagesByUser(userId, paginationModel.CurrentPage, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            if (paginationModel.MaxPages < paginationModel.CurrentPage)
            {
                paginationModel.CurrentPage = 1;
            }

            paginationModel.AllRaioni = _raioniServices.GetMainRaioniByUserAndPage(userId, paginationModel.CurrentPage, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            var RaioniMainTableAsHtmlString = this.RenderViewAsync("../PartialViews/RaioniMainTablePartial", paginationModel.AllRaioni, true).Result;
            var PaginationAsHtmlString = this.RenderViewAsync("../PartialViews/RaioniMainPaginationPartial", paginationModel, true).Result;

            return Json(new
            {
                RaioniMainTableHTML = RaioniMainTableAsHtmlString,
                PaginationHTML = PaginationAsHtmlString,
            });
        }

        public JsonResult AddRaion(RaionAddViewModel newRaion)
        {

            var newRaionInfo = _raioniServices.GetRaionAddViewModel(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            newRaion.AllAdministrativniRaioni = newRaionInfo.AllAdministrativniRaioni;
            newRaion.AllKvartali = newRaionInfo.AllKvartali;
            newRaion.AllNaseleniMesta = newRaionInfo.AllNaseleniMesta;
            newRaion.AllObjini = newRaionInfo.AllObjini;
            newRaion.AllOblasti = newRaionInfo.AllOblasti;
            newRaion.AllUlici = newRaionInfo.AllUlici;

            if (newRaion.NaselenoMqsto != null)
            {
                newRaion.AllUlici = _uliciServices.GetUliciByNaselenoMqsto(newRaion.NaselenoMqsto).Select(u => new SelectListItem
                {
                    Text = u.Nime,
                    Value = u.Nrec.ToString()
                }).ToList();

                newRaion.AllUlici.Insert(0, new SelectListItem
                {
                    Value = "0",
                    Text = "Няма",
                    Selected = true
                });
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _raioniServices.AddRaionMain(newRaion, _userManager.GetUserId(User));
                    return Json(new { success = true, });
                }
                catch (System.ArgumentException e)
                {
                    ModelState.AddModelError("Bulstat", e.Message);
                    var addModalErrorAsHtmlString = this.RenderViewAsync("../Home/Add", newRaion, true).Result;
                    return Json(new { success = false, addModalHTML = addModalErrorAsHtmlString });
                }

            }

            var addModalAsHtmlString = this.RenderViewAsync("../Home/Add", newRaion, true).Result;
            return Json(new { success = false, addModalHTML = addModalAsHtmlString });           
        }

        public JsonResult GetRaionEdit(int nrec)
        {
            var raionEdit = _raioniServices.GetRaionMain(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            var editModalAsHtmlString = this.RenderViewAsync("../Home/Edit", raionEdit, true).Result;

            return Json(new
            {
                editModalHTML = editModalAsHtmlString
            });
        }

        public JsonResult EditRaion(RaionAddViewModel editRaion)
        {

            var newRaionInfo = _raioniServices.GetRaionAddViewModel(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            editRaion.AllAdministrativniRaioni = newRaionInfo.AllAdministrativniRaioni;
            editRaion.AllKvartali = newRaionInfo.AllKvartali;
            editRaion.AllNaseleniMesta = newRaionInfo.AllNaseleniMesta;
            editRaion.AllObjini = newRaionInfo.AllObjini;
            editRaion.AllOblasti = newRaionInfo.AllOblasti;
            editRaion.AllUlici = newRaionInfo.AllUlici;

            var izbRaionNime = _raioniServices.GetAdministrativenRaionIzbRaionNime(editRaion.Nrec);

            var minBroiSik = _raioniServices.GetIzbRaionMinBroiSikByNime(izbRaionNime);
            var maxBroiSik = _raioniServices.GetIzbRaionMaxBroiSikByNime(izbRaionNime);

            if (editRaion.MaxBroiChlenove > maxBroiSik
                || (editRaion.MaxBroiChlenove < minBroiSik && editRaion.MaxBroiChlenove != 0))
            {
                ModelState.AddModelError("MaxBroiChlenove", $"Грешка! Стойността трябва да бъде в диапазона: {minBroiSik} - {maxBroiSik}” ИЛИ 0!");
            }

            if (editRaion.NaselenoMqsto != null)
            {
                editRaion.AllUlici = _uliciServices.GetUliciByNaselenoMqsto(editRaion.NaselenoMqsto).Select(u => new SelectListItem
                {
                    Text = u.Nime,
                    Value = u.Nrec.ToString()
                }).ToList();
                
                editRaion.AllUlici.Insert(0, new SelectListItem
                {
                    Value = "0",
                    Text = "Няма",
                    Selected = true
                });
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _raioniServices.EditRaionMain(editRaion, _userManager.GetUserId(User));
                    var editModalErrorAsHtmlString = this.RenderViewAsync("../Home/Edit", editRaion, true).Result;
                    return Json(new { success = true, editModalHTML = editModalErrorAsHtmlString });
                }
                catch (System.ArgumentException e)
                {
                    ModelState.AddModelError("Bulstat", e.Message);
                    var editModalErrorAsHtmlString = this.RenderViewAsync("../Home/Edit", editRaion, true).Result;
                    return Json(new { success = false, editModalHTML = editModalErrorAsHtmlString });
                }
            }

            var editModalAsHtmlString = this.RenderViewAsync("../Home/Edit", editRaion, true).Result;
            return Json(new { success = false, editModalHTML = editModalAsHtmlString });
        }

        public JsonResult GetRaionAdd()
        {
            var raionAdd = _raioniServices.GetRaionAddViewModel(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            var addModalAsHtmlString = this.RenderViewAsync("../Home/Add", raionAdd, true).Result;

            return Json(new
            {
                addModalHTML = addModalAsHtmlString
            });
        }

        public JsonResult GetAdmninistrativniRaioniByIzbRaion(string nkod)
        {
            var raioni = _raioniServices.GetAdmninistrativniRaioniByIzbRaion(nkod);

            return Json(new { allRaioni = raioni });
        }

        public void DeleteRaionMain(int raionMainId)
        {
            _raioniServices.DeleteRaionMainById(raionMainId);
        }
    }
}