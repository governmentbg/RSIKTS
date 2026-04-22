namespace Web.Areas.Lica.Controllers
{
    using Common.Extensions;
    using Common.ViewModels.Lica;
    using Common.ViewModels.User;
    using Microsoft.AspNetCore.Identity;
    using Microsoft.AspNetCore.Mvc;
    using Services.Interfaces.Lica;
    using Services.Interfaces.Partiq;
    using Services.Interfaces.User;
    using System.Linq;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using System;
    using System.Text;
    using Common.ViewModels.Obrabotki;
    using Common.Exceptions.Lica;
    using Services.Interfaces.Sik;
    using Common.Static;
    using Common.Enums.Spravki;
    using Common.ViewModels.Spravki;
    using Services.Interfaces.Izbori;
    using Microsoft.AspNetCore.Authorization;
    using System.Globalization;
    using System.Threading;
    using Microsoft.EntityFrameworkCore.Metadata.Internal;
    using System.Threading.Tasks;

    [Area("Lica")]
    [Authorize(Roles = "Администратор,Оператор,ОИК/РИК")]

    public class HomeController : Controller
    {
        private readonly ILicaServices _licaServices;
        private readonly IUserServices _userServices;
        private readonly IPartiqServices _partiqServices;
        private readonly ISikServices _sikServices;
        private readonly IIzboriServices _izboriServices;
        readonly private UserManager<SSOUserIdentity> _userManager;

        public HomeController(ILicaServices licaServices, 
                                UserManager<SSOUserIdentity> userManager, 
                                IUserServices userServices, 
                                IPartiqServices partiqServices,
                                ISikServices sikServices,
                                IIzboriServices izboriServices
                            )
        {
            _izboriServices = izboriServices;
            _sikServices = sikServices;
            _licaServices = licaServices;
            _userManager = userManager;
            _userServices = userServices;
            _partiqServices = partiqServices;
        }

        public IActionResult Index()
        {
            return View("Index");
        }

        public IActionResult Register()
        {
            var allLica = _licaServices.GetLicaByPage(1, null, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id, 0);
            var maxPages = _licaServices.GetMaxLicaPages(null, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id, 0);

            return View("Register", new LicaRegisterComposite
            {
                CurrentPage = 1,
                AllLica = allLica,
                MaxPages = maxPages
            });
        }

        public IActionResult RegisterBySik(int sik)
        {
            var allLica = _licaServices.GetLicaByPage(1, null, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id, sik);
            var maxPages = _licaServices.GetMaxLicaPages(null, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id, sik);

            return View("Register", new LicaRegisterComposite
            {
                CurrentPage = 1,
                AllLica = allLica,
                MaxPages = maxPages,
                Sik = sik
            });
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
            var PaginationAsHtmlString = this.RenderViewAsync("../PartialViews/LicaRegisterPaginationPartial", paginationModel, true).Result;

            return Json(new
            {
                UsersTableHTML = UsersTableAsHtmlString,
                PaginationHTML = PaginationAsHtmlString,
            });
        }

        public JsonResult GetLicaAdd(int sik)
        {
            var addViewModel = _licaServices.GetLicaAddViewModel(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id, sik);

            if(sik > 0)
            {
                addViewModel.FromSelectedSik = true;
            }

            addViewModel.USER = _userManager.GetUserId(User);

            var LicaAddAsHtmlString = this.RenderViewAsync("../Home/Add", addViewModel, true).Result;

            return Json(new
            {
                addModalHTML = LicaAddAsHtmlString
            });
        }

        public JsonResult GetLiceEdit(int id, int sik)
        {
            var liceEditModel = _licaServices.GetLicaById(id, _userManager.GetUserId(User));

            if(sik > 0)
            {
                liceEditModel.FromSelectedSik = true;
            }

            liceEditModel.isSikActive = _licaServices.CheckSikType(liceEditModel.IdSik);
            liceEditModel.USER = _userManager.GetUserId(User);

            var LicaEditAsHtmlString = this.RenderViewAsync("../Home/Edit", liceEditModel, true).Result;

            return Json(new
            {
                editModalHTML = LicaEditAsHtmlString
            });
        }

        public async Task<JsonResult> EditLica(LicaEditViewModel editModel)
        {
            var sikId = 0;

            if (editModel.FromSelectedSik)
            {
                sikId = Convert.ToInt32(editModel.IdSik);
            }

            var basicEditModel = _licaServices.GetLicaAddViewModel(editModel.Raion, sikId);

            editModel.AllAdministrativniRaioni = basicEditModel.AllAdministrativniRaioni;
            editModel.AllDeinosti = basicEditModel.AllDeinosti;
            editModel.AllKvartali = basicEditModel.AllKvartali;
            editModel.AllNacionalnosti = basicEditModel.AllNacionalnosti;
            editModel.AllNaseleniMesta = basicEditModel.AllNaseleniMesta;
            editModel.AllObjini = basicEditModel.AllObjini;
            editModel.AllOblasti = basicEditModel.AllOblasti;
            editModel.AllObrazovaniq = basicEditModel.AllObrazovaniq;
            editModel.AllPoliticheskiSili = basicEditModel.AllPoliticheskiSili;
            editModel.AllRoli = basicEditModel.AllRoli;
            editModel.AllRuNaMvr = basicEditModel.AllRoli;
            editModel.AllSik = basicEditModel.AllSik;
            editModel.AllSpecialnosti = basicEditModel.AllSpecialnosti;
            editModel.AllUlici = basicEditModel.AllUlici;
            editModel.AllResheniq = basicEditModel.AllResheniq;
            editModel.AllLica = basicEditModel.AllLica;

          
            if (editModel.JeZamestva > 0 && editModel.IdLiceZamestvan > 0)
            {
                editModel.Rolq = _licaServices.GetZamestvanRolia(editModel.IdLiceZamestvan
                                                                  , _userServices.GetUserRegion(_userManager.GetUserId(User)).Id);
            } else if (editModel.JeZamestva > 0 && editModel.IdLiceZamestvan2 > 0)
            {
                editModel.Rolq = _licaServices.GetZamestvanRolia(editModel.IdLiceZamestvan2
                                                                  , _userServices.GetUserRegion(_userManager.GetUserId(User)).Id);
            }
            ModelState.Clear();
            TryValidateModel(editModel);

            if (ModelState.IsValid)
            {
                try
                {
                    int idlice = await _licaServices.TryEditLicaAsync(editModel);

                    if (idlice > 0)
                    {
                        var editModalAsEmptyHtmlString = this.RenderViewAsync("../Home/Edit", editModel, true).Result;
                        return Json(new { success = true, editModalHTML = editModalAsEmptyHtmlString });
                    } else
                    {
                        editModel.ImpMessage = "Дублирано ЕГН!!! Съществува лице с това ЕГН в друга секция.";

                        var editModalAsHtmlStringDuplicateEgn = this.RenderViewAsync("../Home/Edit", editModel, true).Result;

                        return Json(new { success = false, editModalHTML = editModalAsHtmlStringDuplicateEgn });
                    }
                }
                catch(ArgumentException e)
                {
                    ModelState.AddModelError("Egn", e.Message);

                    var editModalAsHtmlStringDuplicateEgn = this.RenderViewAsync("../Home/Edit", editModel, true).Result;

                    return Json(new { success = false, editModalHTML = editModalAsHtmlStringDuplicateEgn });
                }
                catch (ImportLiceException im)
                {
                    editModel.ImpMessage = im.Message;

                    var editModalAsHtmlStringDuplicateEgn = this.RenderViewAsync("../Home/Edit", editModel, true).Result;

                    return Json(new { success = false, editModalHTML = editModalAsHtmlStringDuplicateEgn });
                }
            }

            editModel.isSikActive = _licaServices.CheckSikType(editModel.IdSik);

            if (editModel.IdSik != 0)
            {
                var sikCode = _sikServices.GetSik(editModel.IdSik).Sik;
                editModel.AllLica = _licaServices.GetLicaBySikToaAndSila(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id
                                                                        , sikCode
                                                                        ,editModel.PoliticheskaSila)
                                                 .Select(d => new SelectListItem
                                                 {
                                                     Value = d.Id.ToString(),
                                                     Text = d.Imena
                                                 })
                                                 .ToList();

                editModel.AllLica.Insert(0, new SelectListItem
                {
                    Value = "0",
                    Text = "Няма"
                });

                editModel.AllLicaFromPartia = _licaServices.GetLicaByToaAndSila(editModel.Raion
                                                                                , editModel.PoliticheskaSila
                                                                                , _userServices.GetUserRegion(_userManager.GetUserId(User)).Id)
                                                                .Select(p => new SelectListItem
                                                                {
                                                                    Value = p.Id.ToString(),
                                                                    Text = p.Imena+" ("+p.Sekciq+")"
                                                                })
                                                                .OrderBy(s => s.Text)
                                                                .ToList();

                editModel.AllLicaFromPartia.Insert(0, new SelectListItem
                {
                    Value = "0",
                    Text = "Няма",
                });

            }


            var editModalAsHtmlString = this.RenderViewAsync("../Home/Edit", editModel, true).Result;

            return Json(new { success = false, editModalHTML = editModalAsHtmlString });
        }

        public async Task<JsonResult> AddLica(LicaAddViewModel addModel)
        {
            var sikId = 0;

            if (addModel.FromSelectedSik)
            {
                sikId = Convert.ToInt32(addModel.IdSik);
            }

            var basicAddModel = _licaServices.GetLicaAddViewModel(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id, sikId);

            addModel.AllAdministrativniRaioni = basicAddModel.AllAdministrativniRaioni;
            addModel.AllDeinosti = basicAddModel.AllDeinosti;
            addModel.AllKvartali = basicAddModel.AllKvartali;
            addModel.AllNacionalnosti = basicAddModel.AllNacionalnosti;
            addModel.AllNaseleniMesta = basicAddModel.AllNaseleniMesta;
            addModel.AllObjini = basicAddModel.AllObjini;
            addModel.AllOblasti = basicAddModel.AllOblasti;
            addModel.AllObrazovaniq = basicAddModel.AllObrazovaniq;
            addModel.AllPoliticheskiSili = basicAddModel.AllPoliticheskiSili;
            addModel.AllRoli = basicAddModel.AllRoli;
            addModel.AllRuNaMvr = basicAddModel.AllRoli;
            addModel.AllSik = basicAddModel.AllSik;
            addModel.AllSpecialnosti = basicAddModel.AllSpecialnosti;
            addModel.AllUlici = basicAddModel.AllUlici;
            addModel.AllResheniq = basicAddModel.AllResheniq;
            addModel.AllLica = basicAddModel.AllLica;
            
            if(Convert.ToInt32(addModel.JeZamestva) > 0 && addModel.IdLiceZamestvan > 0)
            {
                addModel.Rolq = _licaServices.GetZamestvanRolia(addModel.IdLiceZamestvan
                                                                ,_userServices.GetUserRegion(_userManager.GetUserId(User)).Id);
            }
            ModelState.Clear();
            TryValidateModel(addModel);

            if (ModelState.IsValid)
            {
                try
                {
                    int idlice = await _licaServices.TryAddLicaAsync(addModel, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id);
                    if (idlice > 0) { 
                        var addModalAsEmptyHtmlString = this.RenderViewAsync("../Home/Add", addModel, true).Result;
                        return Json(new { success = true, addModalHTML = addModalAsEmptyHtmlString });
                    } else
                    {
                        addModel.ImpMessage = "Дублирано ЕГН!!! Съществува лице с това ЕГН в друга секция.";

                        var editModalAsHtmlStringDuplicateEgn = this.RenderViewAsync("../Home/Edit", addModel, true).Result;

                        return Json(new { success = false, editModalHTML = editModalAsHtmlStringDuplicateEgn });
                    }

                }
                catch (ArgumentException e)
                {
                    ModelState.AddModelError("Egn", e.Message);

                    var addModalAsHtmlStringDuplicateEgn = this.RenderViewAsync("../Home/Add", addModel, true).Result;

                    return Json(new { success = false, addModalHTML = addModalAsHtmlStringDuplicateEgn });
                }
                catch(ImportLiceException im)
                {
                    addModel.ImpMessage = im.Message;

                    var addModalAsHtmlStringDuplicateEgn = this.RenderViewAsync("../Home/Add", addModel, true).Result;

                    return Json(new { success = false, addModalHTML = addModalAsHtmlStringDuplicateEgn });
                }
            }

            if (addModel.IdSik != 0)
            {
                var sikCode = _sikServices.GetSik(addModel.IdSik).Sik;
                addModel.AllLica = _licaServices.GetLicaBySikToaAndSila(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id
                                                                        , sikCode
                                                                        , addModel.PoliticheskaSila)
                                                .Select(d => new SelectListItem
                                                {
                                                    Value = d.Id.ToString(),
                                                    Text = d.Imena
                                                })
                                                .ToList();

                addModel.AllLica.Insert(0, new SelectListItem
                {
                    Value = "0",
                    Text = "Няма"
                });
            }

            var addModalAsHtmlString = this.RenderViewAsync("../Home/Add", addModel, true).Result;

            return Json(new { success = false, addModalHTML = addModalAsHtmlString });
        }

        public IActionResult ImportLica()
        {

            var model = new LicaImportCompositeViewModel
            {
                AllPoliticheskiSili = _partiqServices.GetAllParti().Select(p => new SelectListItem
                {
                    Value = p.Id.ToString(),
                    Text = p.Name
                }).ToList()
            };

            model.AllPoliticheskiSili.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });

            return View("Import", model);
        }

        public JsonResult DeleteLice(int liceId)
        {
            var rezult =  _licaServices.DeleteLice(liceId
                                                    , _userManager.GetUserId(User)
                                                    , _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion);
            return Json(new { success = true, rezult = rezult});
        }

        [HttpPost]
        public async Task<JsonResult> ParseLica([FromBody] LicaImportCompositeViewModel compositeLicaImport)
        {
            foreach(var lice in compositeLicaImport.allLica)
            {
                lice.User = _userManager.GetUserId(User);
                lice.Toa = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
                lice.Sila = compositeLicaImport.PoliticheskaSila;
            }

            var impMessage = await _licaServices.ImportLicaAsync(compositeLicaImport.allLica
                                                    , _userServices.GetUserRegion(_userManager.GetUserId(User)).Id
                                                    , compositeLicaImport.file);

            return Json(new { success = true, ImpMessage = impMessage.ImportMessage, impMessage.HasWrongRecords });
        }

        public JsonResult GetLicaFromIzobryCount()
        {
            return Json(new { count = _licaServices.GetLicaFromIzobryCount(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id) });
        }

        public JsonResult NachislqvaneForLicaByIndex(int liceIndex)
        {
            _licaServices.NachislqvaneForLiceByIndex(_userManager.GetUserId(User) ,_userServices.GetUserRegion(_userManager.GetUserId(User)).Id, liceIndex);

            return Json(new { success = true });
        }

        public FileResult GetFileForNap(ObrabotkiFileForNapViewModel model)
        {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            Encoding utf8 = Encoding.UTF8;
            Encoding win1251 = Encoding.GetEncoding("windows-1251");

            var fileForNapText = _licaServices.GetFileForNap(model.NapFileOption, 
                                                            _userManager.GetUserId(User), 
                                                            _userServices.GetUserRegion(_userManager.GetUserId(User)).Id,
                                                            model.SelectedTurs);
            Byte[] utf8bytes = utf8.GetBytes(fileForNapText);
            Byte[] win1252Bytes = Encoding.Convert(utf8, win1251, utf8bytes);
            
            string finalString = win1251.GetString(win1252Bytes);

            Response.ContentType = "text/plain;charset=windows-1251";

            return File(win1252Bytes, "text/plain;", "EMPL2021.txt");
        }

        public FileResult GetFileForInvalidImport()
        { 
            var fileByteArray = _licaServices.GetFileForInvalidImport(_userManager.GetUserId(User));
            return File(fileByteArray, System.Net.Mime.MediaTypeNames.Application.Octet, "Грешни_Лица_" + DateTime.Now.ToShortDateString() + "_" + DateTime.Now.ToLongTimeString() + ".xlsx");
        }

        public IActionResult Deinosti()
        {
            var deinostiViewModel = _licaServices.GetLicaDeinostiViewModel(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id, "000");

            return View(deinostiViewModel);
        }

        public IActionResult Resheniq()
        {
            var resheniqViewModel = _licaServices.GetLicaResheniqViewModel(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id, "000");

            return View(resheniqViewModel);
        }

        public JsonResult GetDeinostiTablePartial(string sikId, int deinost, string resheniq)
        {
            var lica = _licaServices.GetLicaBySikAndToa(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id, sikId).ToList();

            var model = new LicaMassUpdateComposite
            {
                AllLica = lica,
                SelectedDeinostiMassUpdateValue = deinost,
                SelectedResheniqMassUpdateValue = resheniq
            };

            var tablePartial = this.RenderViewAsync("../PartialViews/LicaDeinostiTablePartial", model, true).Result;

            if (resheniq != null)
            {
                tablePartial = this.RenderViewAsync("../PartialViews/LicaResheniaTablePartial", model, true).Result;
            }

            return Json(new { tableHTML = tablePartial });
        }

        [HttpPost]
        public JsonResult MassUpdateLicaDeinost([FromBody] LicaMassUpdateDeinostiModel model)
        {
            if (model != null)
            {
                _licaServices.MassUpdateLicaDeinost(model, _userManager.GetUserId(User));

                return Json(new { success = true });
            }

            return Json(new { success = false });
        }

        [HttpPost]
        public JsonResult MassUpdateLicaResheniq ([FromBody] LicaMassUpdateResheniqModel model)
        {
            _licaServices.MassUpdateLicaReshenie(model, _userManager.GetUserId(User));

            return Json(new { success = true });
        }

        public JsonResult GetLicaBySik(int sikId)
        {
            var sik = _sikServices.GetSik(sikId);
            var lica = _licaServices.GetLicaBySikAndToa(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id, sik.Sik);

            return Json(new { licaArray = lica });
        }

        public JsonResult GetLicaBySikAndSila(int sikId, int silaId, int liceId)
        {
            var sik = _sikServices.GetSik(sikId);
            var lica = _licaServices.GetLicaBySikToaAndSila(_userServices.GetUserRegion(_userManager.GetUserId(User)).Id, sik.Sik, silaId).Where(l => l.Id != liceId).ToList();

            return Json(new { licaArray = lica });
        }

        public JsonResult GetLiceRolq(int liceId)
        {
           int rolia = _licaServices.GetZamestvanRolia(liceId, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id);

            return Json(new { rolqVal = rolia});
        }

        public JsonResult GetWrongImportLicaForUser()
        {
            var lica = _licaServices.GetWrongImportLicaForUser(_userManager.GetUserId(User));

            return Json(new { licaArray = lica});
        }

        public JsonResult GetLicaByFilter(LicaFilterViewModel model)
        {
            model.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            var lica = _licaServices.GetLicaByFilter(model, _userManager.GetUserId(User),1);

            var viewModel = new LicaRegisterComposite
            {
                AllLica = lica,
                MaxPages = (int)Math.Ceiling(Convert.ToDouble(lica.Count) / PaginationInfo.PageSize),
                CurrentPage = 1
            };

            var tablePartial = this.RenderViewAsync("../PartialViews/LicaFilterPartial", viewModel, true).Result;

            return Json(new { success = true, tableHTML = tablePartial});
        }

        public JsonResult GetLicaByFilterForEdit(LicaFilterViewModel model)
        {
            model.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            var lica = _licaServices.GetLicaByFilter(model, _userManager.GetUserId(User),0);

            var viewModel = new LicaRegisterComposite
            {
                AllLica = lica,
                MaxPages = (int)Math.Ceiling(Convert.ToDouble(lica.Count) / PaginationInfo.PageSize),
                CurrentPage = 1
            };

            var tablePartial = this.RenderViewAsync("../PartialViews/LicaRegisterTableOnlyEditPartial", lica, true).Result;

            return Json(new { success = true, tableHTML = tablePartial });
        }

        public IActionResult PublichnaSpravka211(IzbRaionWithSikFilter filter)
        {
            var userId = _userManager.GetUserId(User);

            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                filter.IzbRaionNkod = "00";
                filter.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var lica = _licaServices.GetLicaForPublichnaSpravka211(filter, userId).ToList();

            if (lica.Count == 0)
            {
                lica.Insert(0, new LicaForSpravka211ViewModel
                {
                    ImeNaIzborite = _izboriServices.GetIzborDescription()
                });
            }
            else
            {
                lica.ElementAt(0).ImeNaIzborite = _izboriServices.GetIzborDescription();
            }

            return View("spravka_2_1_1", lica);
        }

        public IActionResult SlujebnaSpravka211(SikSpravkaFilter filter)
        {
            var administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            var userId = _userManager.GetUserId(User);

            var lica = _licaServices.GetLicaForSlujebnaSpravka211(filter
                        , administrativenRaion
                        , userId)
                .ToList();

            if(lica.Count == 0)
            {
                lica.Insert(0, new LicaForSpravka211ViewModel
                {
                    ImeNaIzborite = _izboriServices.GetIzborDescription()
                });
            }
            else
            {
                lica.ElementAt(0).ImeNaIzborite = _izboriServices.GetIzborDescription();
            }

            lica.ForEach(x => x.filter = filter);
            return View("spravka_2_1_2", lica);
        }

        public IActionResult VedomostSpravka(TurWithSikSpravkaFilter filter)
        {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("bg-BG");

            var administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            var userId = _userManager.GetUserId(User);

            var lica = _licaServices.GetLicaForVedomostSpravka(filter, administrativenRaion, userId).ToList();

            if (lica.Count == 0)
            {

                lica.Insert(0, new LicaForVedomostSpravkaViewModel
                {
                    IzbName  = _izboriServices.GetIzborDescriptionWithoutTur(),
                    IzbrDate = (filter.SelectedTurs == 2? 
                                    _izboriServices.GetIzborEndDate().ToShortDateString():
                                    _izboriServices.GetIzborDate().ToShortDateString()),
                    IzbrTur  = "Тур " + filter.SelectedTurs
            });
            }
            else
            {
                var firstLice = lica.ElementAt(0);

                firstLice.IzbName = _izboriServices.GetIzborDescriptionWithoutTur();
                firstLice.IzbrDate = (filter.SelectedTurs == 2 ?
                                _izboriServices.GetIzborEndDate().ToShortDateString() :
                                _izboriServices.GetIzborDate().ToShortDateString());
                firstLice.IzbrTur = "Тур " + filter.SelectedTurs;

            }

            lica.ForEach(x => x.filter = filter);
            return View("spravka_3_1", lica);
        }

        public IActionResult Spravka32(TurWithSikSpravkaFilter filter)
        {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("bg-BG");

            var lica = _licaServices.GetLicaForSpravka32(filter
                                                        , _userServices.GetUserRegion(_userManager.GetUserId(User)).Id
                                                        , _userManager.GetUserId(User));

            if (lica.Count == 0)
            {

                lica.Add(new LicaForSpravka32ViewModel
                {
                    IzbName = _izboriServices.GetIzborDescriptionWithoutTur(),
                    IzbDate1 = _izboriServices.GetTurBeginDate(filter.SelectedTurs),
                    IzbDate2 = _izboriServices.GetTurEndDate(filter.SelectedTurs),
                    IzbTur = "Тур " + filter.SelectedTurs
                });
            } else { 
                var firstLica = lica.ElementAt(0);

                firstLica.IzbName = _izboriServices.GetIzborDescriptionWithoutTur();
                firstLica.IzbDate1 = _izboriServices.GetTurBeginDate(filter.SelectedTurs);
                firstLica.IzbDate2 = _izboriServices.GetTurEndDate(filter.SelectedTurs);
                firstLica.IzbTur = "Тур " + filter.SelectedTurs;
            }

            return View("spravka_3_2", lica);
        }

        public IActionResult GetSystav4Sekcia(IzbRaionWithSikFilter filter)
        {
            var administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            var userId = _userManager.GetUserId(User);

            var lica = _licaServices.GetLicaForSlujebnaSpravka211(filter, administrativenRaion, userId).ToList();

            if (lica.Count == 0)
            {
                lica.Insert(0, new LicaForSpravka211ViewModel
                {
                    ImeNaIzborite = _izboriServices.GetIzborDescription()
                });
            }
            else
            {
                lica.ElementAt(0).ImeNaIzborite = _izboriServices.GetIzborDescription();
            }

            return View("spravka_1_4", lica);
        }

        public string GenerateSpisukLicaExcelExport212(SikSpravkaFilter filter)
        {
            var administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            var userId = _userManager.GetUserId(User);

            var fileName = _licaServices.GenerateSpisukLicaExcelExport212(
                                    filter
                                    , administrativenRaion
                                    , userId
                            );

            return string.Join(",", Encoding.Convert(Encoding.UTF8, Encoding.Unicode, Encoding.Default.GetBytes(fileName)));
        }


        public IActionResult GetSystavRezervi(SikSpravkaFilter filter)
        {
            var administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            var userId = _userManager.GetUserId(User);

            var lica = _licaServices.GetSystavRezervi(filter, administrativenRaion, userId).ToList();

            if (lica.Count == 0)
            {
                lica.Insert(0, new LicaForSpravka212ViewModel
                {
                    NmRajon = _userServices.GetUserRegion(_userManager.GetUserId(User)).Name,
                });
            }
            lica.ForEach(x => x.filter = filter);

            return View("spravka_2_1_3", lica);
        }

        public string GenerateSpisukLicaExcelExport213(SikSpravkaFilter filter)
        {
            var administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            var userId = _userManager.GetUserId(User);

            var fileName = _licaServices.GenerateSpisukLicaExcelExport213(
                                    filter
                                    , administrativenRaion
                                    , userId
                            );

            return string.Join(",", Encoding.Convert(Encoding.UTF8, Encoding.Unicode, Encoding.Default.GetBytes(fileName)));
        }

        public string GenerateSpisukLicaExcelExport311(TurWithSikSpravkaFilter filter)
        {
            var administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            var userId = _userManager.GetUserId(User);

            var lica = _licaServices.GetLicaForVedomostSpravka(filter, administrativenRaion, userId).ToList();

            var fileName = _licaServices.GenerateSpisukLicaExcelExport311(
                                    filter
                                    , administrativenRaion
                                    , userId
                            );

            return string.Join(",", Encoding.Convert(Encoding.UTF8, Encoding.Unicode, Encoding.Default.GetBytes(fileName)));
        }

        public string GenerateSpisukLicaExcelExport312(TurWithSikSpravkaFilter filter)
        {
            var administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            var userId = _userManager.GetUserId(User);

            var lica = _licaServices.GetLicaForVedomostSpravka(filter, administrativenRaion, userId).ToList();

            var fileName = _licaServices.GenerateSpisukLicaExcelExport312(
                                    filter
                                    , administrativenRaion
                                    , userId
                            );

            return string.Join(",", Encoding.Convert(Encoding.UTF8, Encoding.Unicode, Encoding.Default.GetBytes(fileName)));
        }



        public string GenerateSpravkaExcelExport32(TurWithSikSpravkaFilter filter)
        {
            var administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            var userId = _userManager.GetUserId(User);

            var fileName = _licaServices.GenerateSpravkaExcelExport32(
                                    filter
                                    , administrativenRaion
                                    , userId
                            );

            return string.Join(",", Encoding.Convert(Encoding.UTF8, Encoding.Unicode, Encoding.Default.GetBytes(fileName)));
        }

        public JsonResult GetLicaByToaAndSila(string toa, int silaId, int liceId)
        {
            var lica = _licaServices.GetLicaByToaAndSila( toa, silaId, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id)
                                    .Where(l => l.Id != liceId)
                                    .ToList();

            return Json(new { licaArray = lica });
        }

        public JsonResult CheckGraoNumber(string graonumber, int vidgrao)
        {
            bool isvalid = _licaServices.CheckGraoNumber(graonumber, vidgrao);

            return Json(new { isValid = isvalid });
        }

    }
}