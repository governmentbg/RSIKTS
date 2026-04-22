using System.Linq;
using Common.Static;
using Common.Extensions;
using Common.ViewModels.Obrabotki;
using Common.ViewModels.Spravki;
using Common.ViewModels.User;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Services.Interfaces.Codepositions;
using Services.Interfaces.Izbori;
using Services.Interfaces.Nachislqvaniq;
using Services.Interfaces.Partiq;
using Services.Interfaces.Sik;
using Services.Interfaces.Spravki;
using Services.Interfaces.User;
using Common.Enums.Spravki;
using Common.ViewModels.Lica;
using System;
using Services.Interfaces.Lica;

namespace Web.Areas.Obrabotki.Controllers
{
    [Area("Obrabotki")]
    [Authorize(Roles = "Администратор,Оператор,ОИК/РИК")]

    public class HomeController : Controller
    {
        private readonly ISikServices _sikServices;
        private readonly IUserServices _userServices;
        private readonly INachislqvaniqServices _nachislqvaniqServices;
        private readonly IIzboriServices _izboriServices;
        private readonly ICodePositionServices _codePositionsServices;
        private readonly IPartiqServices _pariqServices;
        private readonly ISpravkiServices _spravkiServices;
        private readonly ILicaServices _licaServices;

        readonly private UserManager<SSOUserIdentity> _userManager;

        public HomeController(
                ISikServices sikServices
                , IUserServices userServices
                , INachislqvaniqServices nachislqvaniqServices
                , IIzboriServices izboriServices
                , UserManager<SSOUserIdentity> userManager
                , ICodePositionServices codePositionsServices
                , IPartiqServices pariqServices
                , ISpravkiServices spravkiServices
                , ILicaServices licaServices)
        {
            _izboriServices = izboriServices;
            _nachislqvaniqServices = nachislqvaniqServices;
            _userManager = userManager;
            _userServices = userServices;
            _sikServices = sikServices;
            _codePositionsServices = codePositionsServices;
            _pariqServices = pariqServices;
            _spravkiServices = spravkiServices;
            _licaServices = licaServices;
        }

        public IActionResult Index()
        {

            var model = new ObrabotkiCompositeModel
            {
                SikFilter = new SikSpravkaFilter(),
                FileForNapViewModel = new ObrabotkiFileForNapViewModel(),
                TurAndSikFilter = new TurWithSikSpravkaFilter()
            };

            model.SikFilter.AllSik = _sikServices.GetSiksByAdministrativenRaion(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id).Select(r => new SelectListItem
            {
                Value = r.Id,
                Text = r.Id + " | " + r.Address
            }).ToList();

            model.TurAndSikFilter.AllSik = model.SikFilter.AllSik;

            int IzborTur = _izboriServices.getIzborCurrentTur();

            if (IzborTur > 1)
            {
                model.TurAndSikFilter.AllTurs.Insert(0, new SelectListItem
                {
                    Text = "Втори",
                    Value = "2",
                    Selected = (IzborTur == 2)
                });

                model.TurAndSikFilter.AllTurs.Insert(1, new SelectListItem
                {
                    Text = "Първи",
                    Value = "1",
                    Selected = (IzborTur == 1)
                });
            }
            else
            {
                model.TurAndSikFilter.AllTurs.Insert(0, new SelectListItem
                {
                    Text = "Първи",
                    Value = "1",
                    Selected = (IzborTur == 1)
                });
            }

            return View("Index", model);
        }

        public IActionResult NachislqvaneOsigurovki()
        {
            var userId = _userManager.GetUserId(User);
            var userRegion = _userServices.GetUserRegion(userId).Id;

            ToggleObrabotkiFlag();

            if (_nachislqvaniqServices.RaionHasNachislqvaniq(userRegion))
            {
                return View();
            }
            else
            {
                return RedirectToAction("Index");
            }
            
        }

        public JsonResult ResolveNewIzborOption(AdminOptionsFilter filter)
        {
            if (ModelState.IsValid)
            {
                switch (filter.Option)
                {
                    case 0:
                        _izboriServices.NewIzborTur(_userManager.GetUserId(User));
                        break;
                    case 1:
                        _izboriServices.StartNewIzbor(_userManager.GetUserId(User), filter);
                        break;
                    case 2:
                        _izboriServices.DeleteDatabase(_userManager.GetUserId(User));
                        break;
                }

                var izboriTipove = _izboriServices.GetTipIzbori().Select(i => new SelectListItem
                {
                    Value = i.Nkod,
                    Text = i.Nime
                }).ToList();

                var model = new AdminOptionsFilter
                {
                    AllTipove = izboriTipove,
                    Naimenovanie = "",
                    Tip = izboriTipove.First().Value
                };

                var emptyFormAsHtmlString = this.RenderViewAsync("../../../Admin/Views/PartialViews/AdminOptionsModal", model, true).Result;

                return Json(new { success = true, formHTML = emptyFormAsHtmlString });
            }
            else
            {

                filter.AllTipove = _izboriServices.GetTipIzbori().Select(i => new SelectListItem
                {
                    Value = i.Nkod,
                    Text = i.Nime
                }).ToList();

                var formAsHtmlString = this.RenderViewAsync("../../../Admin/Views/PartialViews/AdminOptionsModal", filter, true).Result;
                return Json(new { success = false, formHtml = formAsHtmlString });
            }          
        }

        public void ToggleObrabotkiFlag()
        {
            var userId = _userManager.GetUserId(User);
            var userRegion = _userServices.GetUserRegion(userId).Id;

            _nachislqvaniqServices.ToggleObrabotkiFlag(userId, userRegion);
        }


        //v.2
        public IActionResult KorekciiPaymentFilter()
        {
            string administrativen = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            var viewModel = new KorekciiPaymentFilterViewModel()
            {
                AllSekcii = _sikServices.GetSiksByAdministrativenRaion(administrativen).Select(r => new SelectListItem
                {
                    Value = r.Id,
                    Text = r.Id + " | " + r.Address
                }).ToList(),

                AllRoli = _codePositionsServices.GetAllCodePositionsByPkode(4).Select(p => new SelectListItem
                {
                    Value = p.Nkode.ToString(),
                    Text = p.Nime
                }).OrderBy(c => c.Value)
                .ToList(),

                AllDeistviq = _codePositionsServices.GetAllCodePositionsByPkode(3).Select(p => new SelectListItem
                {
                    Value = p.Nkode.ToString(),
                    Text = p.Nime
                }).OrderBy(c => c.Value)
                .ToList(),

                AllPartii = _pariqServices.GetAllParti().Select(p => new SelectListItem
                {
                    Value = p.Id.ToString(),
                    Text = p.Name
                }).ToList(),

                AllResheniq = _spravkiServices.GetAllNomenklatureBasicDetails(NomenklatureIds.Dokumenti, administrativen).Select(p => new SelectListItem
                {
                    Value = p.Code.ToString(),
                    Text = p.Name
                }).ToList(),
            };


            viewModel.AllSekcii.Insert(0, new SelectListItem
            {
                Text = "Няма",
                Value = "",
                Selected = true
            });

            viewModel.AllRoli.Insert(0, new SelectListItem
            {
                Text = "Няма",
                Value = "",
                Selected = true
            });

            viewModel.AllDeistviq.Insert(0, new SelectListItem
            {
                Text = "Няма",
                Value = "",
                Selected = true
            });

            viewModel.AllPartii.Insert(0, new SelectListItem
            {
                Text = "Няма",
                Value = "",
                Selected = true
            });

            viewModel.AllResheniq.Insert(0, new SelectListItem
            {
                Text = "Няма",
                Value = "",
                Selected = true
            });

            return View("KorekciiPaymentFilter", viewModel);
        }
        public JsonResult GetLicaByKorekciiPaymentFilter(KorekciiPaymentFilterViewModel model)
        {
            model.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            var lica = _nachislqvaniqServices.GetLicaByKorekciiPaymentFilter(model, _userManager.GetUserId(User), 1);

            var viewModel = new LicaRegisterComposite
            {
                AllLica = lica,
                MaxPages = (int)Math.Ceiling(Convert.ToDouble(lica.Count) / PaginationInfo.PageSize),
                CurrentPage = 1
            };

             var tablePartial = this.RenderViewAsync("../PartialViews/KorekciiPaymentFilterPartial", viewModel, true).Result;

            return Json(new { success = true, tableHTML = tablePartial });
        }

        public JsonResult GetLicaByPage(LicaRegisterComposite paginationModel)
        {
            paginationModel.MaxPages = _licaServices.GetMaxLicaPages(paginationModel.EgnFilter, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id, paginationModel.Sik);

            if (paginationModel.MaxPages < paginationModel.CurrentPage)
            {
                paginationModel.CurrentPage = 1;
            }

            paginationModel.AllLica = _licaServices.GetLicaByPage(paginationModel.CurrentPage, paginationModel.EgnFilter, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id, paginationModel.Sik);

            var UsersTableAsHtmlString = this.RenderViewAsync("../PartialViews/LicaRegisterTablePartial", paginationModel.AllLica, true).Result;
            var PaginationAsHtmlString = this.RenderViewAsync("../PartialViews/KorekciiPaymentPaginationPartialView", paginationModel, true).Result;

            return Json(new
            {
                UsersTableHTML = UsersTableAsHtmlString,
                PaginationHTML = PaginationAsHtmlString,
            });
        }

        public JsonResult GetPayments4Correction (int pIdLice)
        {
            var viewModel = _nachislqvaniqServices.GetPayments4Correction(pIdLice);

            var compositeViewModel = new PaymentCorrectionCompositeViewModel
            {
                pIdLice = pIdLice,
                PaymentCorrectionList = viewModel,
                TotalSum = viewModel.Sum(p => p.Pari)
            };

            var tablePartial = this.RenderViewAsync("../PartialViews/KorekciiPaymentLiceDetailsPartial", compositeViewModel, true).Result;


            return Json(new { paymentTableHTML = tablePartial  });
        }

        public JsonResult SetPaymentsCorrection(int pIdLice, float pari)
        {
            try
            {
                pari -= (float)_nachislqvaniqServices.GetPayments4Correction(pIdLice).Sum(p => p.Pari);
                _nachislqvaniqServices.SetPaymentsCorrection(pIdLice, _userManager.GetUserId(User), pari);
                return Json(new { success = true });
            }
            catch (Exception)
            {
                return Json(new { success = false });
            }

        }
    }
}