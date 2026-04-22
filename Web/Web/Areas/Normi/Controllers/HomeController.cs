namespace Web.Areas.Normi.Controllers
{
    using Common.Extensions;
    using Common.ViewModels.List;
    using Common.ViewModels.User;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Identity;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Services.Interfaces.List;
    using Services.Interfaces.User;
    using System;
    using System.Collections.Generic;
    using System.Linq;

    [Area("Normi")]
    [Authorize(Roles = "Администратор,Оператор,ОИК/РИК")]

    public class HomeController : Controller
    {
        private readonly IListServices _listServices;
        private readonly UserManager<SSOUserIdentity> _userManager;
        private readonly IUserServices _userServices;

        public HomeController(IListServices listServices, IUserServices userServices, UserManager<SSOUserIdentity> userManager)
        {
            _userManager = userManager;
            _userServices = userServices;
            _listServices = listServices;
        }

        public IActionResult Priznaci()
        {
            ViewBag.Message = "Настройки плащане по признак на секция";
            var priznaci = _listServices.GetCodePositionsAndPriznaci(1);

            return View("NormaBasic", new NormaBasicComposite
            {
                Data = priznaci.ToList(),
                NormaName = "Priznaci"
            });
        }

        public IActionResult Operacii()
        {
            ViewBag.Message = "Настройки плащане по дейност ";
            var operacii = _listServices.GetCodePositionsAndOperacii(1);

            return View("NormaBasic", new NormaBasicComposite {
                Data = operacii.ToList(),
                NormaName = "Operacii"
            });
        }

        public IActionResult Roli(int vidId)
        {
            var roli = _listServices.GetCodePositionsAndRoliBySilaAndTur(vidId, 1);

            var sekcii = _listServices.GetCodePositions(1).Select(c => new SelectListItem
            {
                Value = c.Nkode.ToString(),
                Text = c.Nime
            });

            return View("NormaRoli", new NormiRoliComposite {
                Roli = roli,
                VidSekcii = sekcii
            });
        }

        public JsonResult GetNormaEdit(int normaId, int tur)
        {
            var norma = _listServices.GetCodePositionWithMoneyByIdAndTur(normaId, tur);
            norma.User = _userServices.GetEditUserById(_userManager.GetUserId(User)).Id;
            norma.Tur = tur;

            var editModalAsHtmlString = this.RenderViewAsync("../PartialViews/NormiEditPartialView", norma, true).Result;

            return Json(new {editModalHTML = editModalAsHtmlString });
        }

        public JsonResult GetNormaTable(string vid, int tur)
        {
            List<CodePositionsWithMoneyViewModel> data;

            if (vid == "Priznaci")
            {
                data = _listServices.GetCodePositionsAndPriznaci(tur).ToList();
            }
            else
            {
                data = _listServices.GetCodePositionsAndOperacii(tur).ToList();
            }

            var tableAsHtmlString = this.RenderViewAsync("../PartialViews/NormiTablePartialView", data, true).Result;

            return Json(new { tableHTML = tableAsHtmlString });
        }

        public JsonResult GetRoliTable(int vidId, int tur)
        {
            var roli = _listServices.GetCodePositionsAndRoliBySilaAndTur(vidId, tur);

            var tableAsHtmlString = this.RenderViewAsync("../PartialViews/NormiTablePartialView"
                                        , roli.Select(r => new CodePositionsWithMoneyViewModel {
                                                        Id = r.Id,
                                                        Nkode = r.Nkode,
                                                        Nime = r.Nime,
                                                        Money = r.Money,
                                                        Pkode = r.Pkode,
                                                        Koga = r.Koga,
                                                        User = r.User,
                                                        Status = r.Status
                                                    }).ToList(), true).Result;

            return Json(new { tableHTML = tableAsHtmlString });
        }

        public JsonResult GetNormaRoliEdit(int normaId, int vidId, int tur)
        {
            var norma = _listServices.GetNormaRoliWithMoneyByIdSilaAndTur(normaId, vidId, tur);
            norma.User = _userServices.GetEditUserById(_userManager.GetUserId(User)).Id;

            var editModalAsHtmlString = this.RenderViewAsync("../PartialViews/NormiRoliEditPartialView", norma, true).Result;

            return Json(new { editModalHTML = editModalAsHtmlString });
        }

        public JsonResult EditNormaRoli(NormiRoliWithMoneyViewModel editModel)
        {
            editModel.Koga = DateTime.Now;
            
            if (ModelState.IsValid)
            {
                _listServices.TryEditNormaRoli(editModel);
                return Json(new { success = true });
            }

            var editModalAHtmlString = this.RenderViewAsync("../PartialViews/NormiRoliEditPartialView", editModel, true).Result;
            return Json(new { success = false, editModalHTML = editModalAHtmlString });
        }

        public JsonResult EditNorma(CodePositionsWithMoneyViewModel editModel)
        {
            editModel.Koga = DateTime.Now;

            if (ModelState.IsValid)
            {
                _listServices.TryEditNorma(editModel);
                return Json(new { success = true});
            }

            var editModalAHtmlString = this.RenderViewAsync("../PartialViews/NormiEditPartialView", editModel, true).Result;
            return Json(new { success = false, editModalHTML = editModalAHtmlString });
        }


    }
}