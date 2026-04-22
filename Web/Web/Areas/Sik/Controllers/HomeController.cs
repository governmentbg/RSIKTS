namespace Web.Areas.Sik.Controllers
{
    using Common.Exceptions.Sik;
    using Common.Extensions;
    using Common.ViewModels.Sik;
    using Common.ViewModels.User;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Identity;
    using Microsoft.AspNetCore.Mvc;
    using Services.Interfaces.Raion;
    using Services.Interfaces.Sik;
    using Services.Interfaces.User;
    using System;
    using System.Linq;

    [Area("Sik")]
    [Authorize(Roles = "Администратор,Оператор,ОИК/РИК")]

    public class HomeController : Controller
    {
        readonly private IRaionServices _raioniServices;
        readonly private ISikServices _sikServices;
        readonly private IUserServices _userServices;
        readonly private UserManager<SSOUserIdentity> _userManager;
        public HomeController(
            ISikServices sikServices
            , UserManager<SSOUserIdentity> userManager
            , IUserServices userServices
            , IRaionServices raionServices)
        {
            _userManager = userManager;
            _sikServices = sikServices;
            _userServices = userServices;
            _raioniServices = raionServices;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Register()
        {
            var sikModel = new SikCompositeViewModel
            {
                AllSiks = _sikServices.GetAllSiks(1,null, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id),
                MaxPages = _sikServices.GetMaxSikPages(null,_userServices.GetUserRegion(_userManager.GetUserId(User)).Id),
                CurrentPage = 1
            };

            return View("Register", sikModel);
        }

        public JsonResult GetSikAdd()
        {
            var administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id; 
            var sikAddModal = _sikServices.GetSikAddModel(administrativenRaion, null);

            var admRaionChlenove = _raioniServices.GetAdministrativenRaionChlenove(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            sikAddModal.MaxBroiChlenove = admRaionChlenove;
            sikAddModal.IzbRajon = _raioniServices.GetIzbRaion(administrativenRaion);

            var addModalAsHtmlString = this.RenderViewAsync("../Home/Add", sikAddModal, true).Result;

            return Json(new { success = false, addModalHTML = addModalAsHtmlString });
        }

        public JsonResult GetSikByPage(SikCompositeViewModel paginationModel)
        { 
            paginationModel.MaxPages = _sikServices.GetMaxSikPages(paginationModel.SikFilter, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            if (paginationModel.MaxPages < paginationModel.CurrentPage)
            {
                paginationModel.CurrentPage = 1;
            }

            paginationModel.AllSiks = _sikServices.GetAllSiks(paginationModel.CurrentPage, paginationModel.SikFilter, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            var SikTableAsHtmlString = this.RenderViewAsync("../PartialViews/SikTablePartial", paginationModel.AllSiks, true).Result;
            var PaginationAsHtmlString = this.RenderViewAsync("../PartialViews/SikPaginationPartial", paginationModel, true).Result;

            return Json(new
            {
                SikTableHTML = SikTableAsHtmlString,
                PaginationHTML = PaginationAsHtmlString,
            });
        }

        public JsonResult DeleteSik(int sikId)
        {
            try
            {
                _sikServices.TryDelete(sikId, _userManager.GetUserId(User));
                return Json(new { success = true });
            }
            catch(DeleteSikException e)
            {
                return Json(new { success = false, errorMessage = e.Message });
            }
        }

        [HttpPost]
        public JsonResult EditSik([FromBody]SikEditViewModel editModel)
        {
            editModel.Sik = editModel.Sik.PadLeft(3, '0');
                
            if (editModel.MaxBroiToaChlenove != 0)
            {
                editModel.MaxBroiChlenove = editModel.MaxBroiToaChlenove;
            }
            else
            {
                var minBroiSik = _raioniServices.GetIzbRaionMinBroiSikByNkod(editModel.IzbRajon);
                var maxBroiSik = _raioniServices.GetIzbRaionMaxBroiSikByNkod(editModel.IzbRajon);

                if (_sikServices.isSikVidCalc(editModel.Vidove) == 1 && 
                   (editModel.MaxBroiChlenove > maxBroiSik || (editModel.MaxBroiChlenove < minBroiSik)))
                {
                    ModelState.AddModelError("MaxBroiChlenove", $"стойността трябва да бъде в диапазона: {minBroiSik} - {maxBroiSik}");
                }
            }
/*
            if (editModel.Vidove == 102)
            {
                int toanumbvoters = editModel.AllToaForPodvijnaSekciq.Where(item => item.Toa.Equals(editModel.TOA)).FirstOrDefault().Izbirateli;
                if (toanumbvoters < 10)
                {
                    ModelState.AddModelError("NUMBVOTERS", $"За основния район избирателите трябва да са повече от 9.");
                }
            }
*/
            var basicAddModel = _sikServices.GetSikAddModel(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id, editModel.Kodnsm);

            if (ModelState.IsValid)
            {
                try
                {
                    _sikServices.TryEditSik(editModel);

                    return Json(new
                    {
                        success = true
                    });
                }
                catch (ArgumentException e)
                {
                    ModelState.AddModelError("Sik", e.Message);

                    editModel.AllAdministrativniRaioni = basicAddModel.AllAdministrativniRaioni.Where(r => r.Value == _userServices.GetUserRegion(_userManager.GetUserId(User)).Id).ToList();
                    editModel.AllKvartali = basicAddModel.AllKvartali;
                    editModel.AllNaseleniMesta = basicAddModel.AllNaseleniMesta;
                    editModel.AllObjini = basicAddModel.AllObjini;
                    editModel.AllOblasti = basicAddModel.AllOblasti;
                    editModel.AllPriznaci = basicAddModel.AllPriznaci;
                    editModel.AllUlici = basicAddModel.AllUlici;
                    editModel.AllVidove = basicAddModel.AllVidove;

                    var editModalAsHtmlStringDuplicateSik = this.RenderViewAsync("../Home/Edit", editModel, true).Result;

                    return Json(new { success = false, editModalHTML = editModalAsHtmlStringDuplicateSik });
                }
            }

            editModel.AllAdministrativniRaioni = basicAddModel.AllAdministrativniRaioni.Where(r => r.Value == _userServices.GetUserRegion(_userManager.GetUserId(User)).Id).ToList();
            editModel.AllKvartali = basicAddModel.AllKvartali;
            editModel.AllNaseleniMesta = basicAddModel.AllNaseleniMesta;
            editModel.AllObjini = basicAddModel.AllObjini;
            editModel.AllOblasti = basicAddModel.AllOblasti;
            editModel.AllPriznaci = basicAddModel.AllPriznaci;
            editModel.AllUlici = basicAddModel.AllUlici;
            editModel.AllVidove = basicAddModel.AllVidove;
            editModel.AllToaForPodvijnaSekciq = basicAddModel.AllToaForPodvijnaSekciq;
            editModel.MaxBroiToaChlenove = _raioniServices.GetAdministrativenRaionChlenove(editModel.TOA);

            var editModalAsHtmlString = this.RenderViewAsync("../Home/Edit", editModel, true).Result;

            return Json(new { success = false, editModalHTML = editModalAsHtmlString });

        }

        public JsonResult GetSikEdit(int sikId)
        {
            var sikEdit = _sikServices.GetSik(sikId);

            sikEdit.AllAdministrativniRaioni = sikEdit
                    .AllAdministrativniRaioni
                    .Where(r => r.Value == sikEdit.TOA)
                    .ToList();

            sikEdit.USER = _userManager.GetUserId(User);

            sikEdit.MaxBroiToaChlenove = _raioniServices.GetAdministrativenRaionChlenove(sikEdit.TOA);

            var editModalAsHtmlString = this.RenderViewAsync("../Home/Edit", sikEdit, true).Result;

            return Json(new
            {
                editModalHTML = editModalAsHtmlString
            });
        }

        [HttpPost]
        public JsonResult AddSik([FromBody]SikAddViewModel addModel)
        {
            if(addModel.Sik != null)
                addModel.Sik = addModel.Sik.PadLeft(3, '0');

            var admRaionChlenove = _raioniServices.GetAdministrativenRaionChlenove(addModel.TOA);

            if (admRaionChlenove != 0)
            {
                addModel.MaxBroiChlenove = admRaionChlenove;
            }
            else
            {
                var minBroiSik = _raioniServices.GetIzbRaionMinBroiSikByNkod(addModel.IzbRajon);
                var maxBroiSik = _raioniServices.GetIzbRaionMaxBroiSikByNkod(addModel.IzbRajon);

                if (_sikServices.isSikVidCalc(addModel.Vidove) == 1 && 
                   (addModel.MaxBroiChlenove > maxBroiSik  || (addModel.MaxBroiChlenove < minBroiSik)))
                {
                    ModelState.AddModelError("MaxBroiChlenove", $"стойността трябва да бъде в диапазона: {minBroiSik} - {maxBroiSik}");
                }
            }
/*
            if (addModel.Vidove == 102)
            {
                int toanumbvoters = addModel.AllToaForPodvijnaSekciq.Where(item => item.Toa.Equals(addModel.TOA)).FirstOrDefault().Izbirateli;
                if (toanumbvoters < 10)
                {
                    ModelState.AddModelError("NUMBVOTERS", $"За основния район избирателите трябва да са повече от 9.");
                }
            }
*/
            addModel.USER = _userManager.GetUserId(User);

            var basicAddModel = _sikServices.GetSikAddModel(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id, addModel.Kodnsm);

            if (ModelState.IsValid)
            {
                try
                {
                    _sikServices.TryAddSik(addModel);
                    var addModalAsEmptyHtmlString = this.RenderViewAsync("../Home/Add", basicAddModel, true).Result;

                    return Json(new
                    {
                        success = true,
                        addModalHTML = addModalAsEmptyHtmlString
                    });
                }
                catch (ArgumentException e)
                {
                    ModelState.AddModelError("Sik", e.Message);

                    addModel.AllAdministrativniRaioni = basicAddModel.AllAdministrativniRaioni.Where(r => r.Value == _userServices.GetUserRegion(_userManager.GetUserId(User)).Id).ToList();
                    addModel.AllKvartali = basicAddModel.AllKvartali;
                    addModel.AllNaseleniMesta = basicAddModel.AllNaseleniMesta;
                    addModel.AllObjini = basicAddModel.AllObjini;
                    addModel.AllOblasti = basicAddModel.AllOblasti;
                    addModel.AllPriznaci = basicAddModel.AllPriznaci;
                    addModel.AllUlici = basicAddModel.AllUlici;
                    addModel.AllVidove = basicAddModel.AllVidove;

                    addModel.AllUlici.FirstOrDefault(u => u.Value == addModel.ULKOD).Selected = true;

                    var addModalAsHtmlStringDuplicateSik = this.RenderViewAsync("../Home/Add", addModel, true).Result;

                    return Json(new { success = false, addModalHTML = addModalAsHtmlStringDuplicateSik });
                }
            }
            
            addModel.AllAdministrativniRaioni = basicAddModel.AllAdministrativniRaioni.Where(r => r.Value == _userServices.GetUserRegion(_userManager.GetUserId(User)).Id).ToList(); 
            addModel.AllKvartali = basicAddModel.AllKvartali;
            addModel.AllNaseleniMesta = basicAddModel.AllNaseleniMesta;
            addModel.AllObjini = basicAddModel.AllObjini;
            addModel.AllOblasti = basicAddModel.AllOblasti;
            addModel.AllPriznaci = basicAddModel.AllPriznaci;
            addModel.AllUlici = basicAddModel.AllUlici;
            addModel.AllVidove = basicAddModel.AllVidove;

            addModel.AllUlici.FirstOrDefault(u => u.Value == addModel.ULKOD).Selected = true;

            var addModalAsHtmlString = this.RenderViewAsync("../Home/Add", addModel, true).Result;

            return Json(new { success = false, addModalHTML = addModalAsHtmlString });      
        }

        public JsonResult GetSiksByAdministrativenRaion(string nkod)
        {
            var sik = _sikServices.GetSiksByAdministrativenRaion(nkod);

            return Json(new { allSiks = sik });
        }
        
    }
}