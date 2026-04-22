using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Common.Extensions;
using Common.ViewModels.Kvoti;
using Common.ViewModels.User;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Services.Interfaces.Kvoti;
using Services.Interfaces.User;

namespace Web.Areas.Kvoti.Controllers
{
    [Area("Kvoti")]
    [Authorize(Roles = "Администратор,Оператор,ОИК/РИК")]

    public class HomeController : Controller
    {
        private readonly IKvotiServices _kvotiServices;
        private readonly IUserServices _userServices;
        private readonly UserManager<SSOUserIdentity> _userManger;

        public HomeController(IKvotiServices kvotiServices, IUserServices userServices, UserManager<SSOUserIdentity> userManager)
        {
            _userServices = userServices;
            _userManger = userManager;
            _kvotiServices = kvotiServices;
        }

        public IActionResult Index()
        {
            var allKvoti = _kvotiServices.AllKvoti(_userServices.GetUserRegion(_userManger.GetUserId(User)).Id);

            return View(allKvoti);
        }

        public JsonResult GetKvotiTable()
        {
            var allKvoti = _kvotiServices.AllKvoti(_userServices.GetUserRegion(_userManger.GetUserId(User)).Id);

            var kvotiTableHtmlAsString = this.RenderViewAsync("../PartialViews/KvotiTablePartialView", allKvoti, true).Result;

            return Json(new { kvotiTableHTML = kvotiTableHtmlAsString });
        }

        public IActionResult Kvoti()
        {
            return View("Kvoti");
        }

        public JsonResult GetKvotiEdit(string silaId)
        {

            var kvota = _kvotiServices.GetKvotaById(silaId, _userServices.GetUserRegion(_userManger.GetUserId(User)).Id);

            var editModalHtmlAsString = this.RenderViewAsync("../PartialViews/KvotiEditPartialView", kvota, true).Result;

            return Json(new
            {
                editModalHTML = editModalHtmlAsString
            });
        }

        public JsonResult EditKvota(KvotiEditViewModel kvota)
        {
            if (ModelState.IsValid)
            {
                _kvotiServices.EditKvota(kvota, _userServices.GetUserRegion(_userManger.GetUserId(User)).Id, _userManger.GetUserId(User));
                return Json(new { success = true });
            }

            var editModalHtmlAsString = this.RenderViewAsync("../PartialViews/KvotiEditPartialView", kvota, true).Result;

            return Json(new
            {
                success = false,
                editModalHTML = editModalHtmlAsString
            });
        }

        public IActionResult Reshetka()
        {
            var maxMembers = GetMaxNumber4Sik(_userServices.GetUserRegion(_userManger.GetUserId(User)).Id);
            var reshetkaInfo = _kvotiServices.GetReshetkaInfo(_userServices.GetUserRegion(_userManger.GetUserId(User)).Id);

            return View("Reshetka", new ReshetkaCompositeViewModel {
                SikMaxMembers = maxMembers,
                ReshetkaData = reshetkaInfo
            });
        }

        public JsonResult GetReshetkaTable()
        {
            var maxMembers = GetMaxNumber4Sik(_userServices.GetUserRegion(_userManger.GetUserId(User)).Id);
            var reshetkaInfo = _kvotiServices.GetReshetkaInfo(_userServices.GetUserRegion(_userManger.GetUserId(User)).Id);

            var reshetkaComposite = new ReshetkaCompositeViewModel
            {
                SikMaxMembers = maxMembers,
                ReshetkaData = reshetkaInfo
            };

            var reshetkaTableHtmlAsString = this.RenderViewAsync("../PartialViews/ReshetkaTablePartialView", reshetkaComposite, true).Result;

            return Json(new
            {
                reshetkaTableHTML = reshetkaTableHtmlAsString
            });
        }

        public JsonResult GeReshetkaEdit(int sikId)
        {
            ViewBag.maxmembers = GetMaxNumber4Sik(_userServices.GetUserRegion(_userManger.GetUserId(User)).Id);

            var kvota = _kvotiServices.GetReshetkaEditById(sikId);
            var editModalHtmlAsString = this.RenderViewAsync("../PartialViews/ReshetkaEditPartialView", kvota, true).Result;

            return Json(new
            {
                editModalHTML = editModalHtmlAsString
            });
        }

        public JsonResult EditReshetka(ReshetkaEditViewModel model)
        {
            _kvotiServices.EditReshetka(model, _userServices.GetUserRegion(_userManger.GetUserId(User)).Id, _userManger.GetUserId(User));

            return Json(new { success = true });
        }

        public JsonResult GetReshetkaDetails(int sikId)
        {
            var reshetkaDetails = _kvotiServices.GetReshetkaDetails(sikId);

            var reshetkaDetailsHtml = this.RenderViewAsync("../PartialViews/ReshetkaDetailsPartialView", reshetkaDetails, true).Result;

            return Json(new { reshetkaDetailsHTML = reshetkaDetailsHtml });
        }

        public JsonResult GetReshetkaSum()
        {
            var administrativenRaion = _userServices.GetUserRegion(_userManger.GetUserId(User)).Id;

            var reshetkaSum = _kvotiServices.GetReshetkaSum(administrativenRaion);

            var reshetkaSumHtml = this.RenderViewAsync("../PartialViews/ReshetkaSumPartialView", reshetkaSum, true).Result;

            return Json(new { reshetkaSumHTML = reshetkaSumHtml });
        }

        public int GetMaxNumber4Sik(string prmRegion)
        {
            return _kvotiServices.GetMaxNumber4Sik(prmRegion);
        }
    }
}