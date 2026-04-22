namespace Web.Areas.Spravki.Controllers
{
    using Microsoft.AspNetCore.Mvc;
    using Services.Interfaces.Spravki;
    using Common.Enums.Spravki;
    using Common.ViewModels.Spravki;
    using Common.Extensions;
    using System;
    using Common.ViewModels.User;
    using Microsoft.AspNetCore.Identity;
    using Services.Interfaces.Raion;
    using System.Linq;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Services.Interfaces.Sik;
    using Services.Interfaces.Codepositions;
    using Services.Interfaces.Partiq;
    using Novacode;
    using Microsoft.AspNetCore.Hosting;
    using System.IO;
    using Common.ViewModels.Lica;
    using Services.Interfaces.IzbiratelenRaioni;
    using Services.Interfaces.Izbori;
    using Services.Interfaces.User;
    using Microsoft.AspNetCore.Authorization;
    using OfficeOpenXml;
    using System.Text;
    using System.Collections.Generic;

    [Area("Spravki")]
    [Authorize(Roles = "Администратор,Оператор,ОИК/РИК")]

    public class HomeController : Controller
    {
        private readonly ISpravkiServices _spravkiServices;
        private readonly IRaionServices _raioniServices;
        private readonly ISikServices _sikServices;
        private readonly ICodePositionServices _codePositionsServices;
        private readonly IPartiqServices _pariqServices;
        private readonly IHostingEnvironment _hostingEnvironment;
        private readonly IIzbiratelniRaioniServices _izbiratelniRaioniServices;
        private readonly IIzboriServices _izboriServices;
        private readonly IUserServices _userServices;
        private readonly UserManager<SSOUserIdentity> _userManager;

        public HomeController(ISpravkiServices spravkiServices, 
                                IRaionServices raioniServices, 
                                ISikServices sikServices, 
                                ICodePositionServices codePositionsServices, 
                                IPartiqServices pariqServices, 
                                IHostingEnvironment hostingEnvironment,
                                IIzbiratelniRaioniServices izbiratelniRaioniServices,
                                IIzboriServices izboriServices,
                                IUserServices userServices,
                                UserManager<SSOUserIdentity> userManager
                             )
        {
            _userServices = userServices;
            _izboriServices = izboriServices;
            _hostingEnvironment = hostingEnvironment;
            _pariqServices = pariqServices;
            _codePositionsServices = codePositionsServices;
            _userManager = userManager;
            _raioniServices = raioniServices;
            _spravkiServices = spravkiServices;
            _sikServices = sikServices;
            _izbiratelniRaioniServices = izbiratelniRaioniServices;
        }

        public IActionResult StatisticsPublic()
        {
            string administrativen = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            var allStatistics = _spravkiServices.GetAllStatistics(0);

            var viewModel = new SpravkiCompositeViewModel
            {
                typestatistics = 1,

                AllStatistics = allStatistics.ToList(),

                AllAdministrativniRaioni = _raioniServices.GetAllRaioni(null).Select(r => new SelectListItem
                {
                    Value = r.Id,
                    Text = r.Name
                }).ToList(),

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
                }).ToList()

            };

  
            viewModel.SlujebnaSpravka221FiletModel = new SikSpravkaFilter
            {
                AllSik = _sikServices.GetSiksByAdministrativenRaion(administrativen).Select(r => new SelectListItem
                {
                    Value = r.Id,
                    Text = r.Id + " | " + r.Address
                }).ToList(),
            };

            var codes = new List<int>() { 304, 305, 306 };
            viewModel.RziFilter = new SpravkaRziFilter();

            viewModel.RziFilter.AllDeistviq = _codePositionsServices.GetAllCodePositionsByPkode(3)
                        .Where(c => codes.Contains(c.Nkode))
                        .Select(p => new SelectListItem
                        {
                            Value = p.Nkode.ToString(),
                            Text = p.Nime
                        }).OrderBy(c => c.Value)
              .ToList();

            var izbiratelniRaioni = _izbiratelniRaioniServices.GetIzbiratelniRaioni().Select(i => new SelectListItem
            {
                Value = i.Nkod,
                Text = i.Nime
            }).ToList();

            izbiratelniRaioni.Insert(0, new SelectListItem
            {
                Value = "00",
                Text = "Всички"
            });

            viewModel.RziFilter.AllIzbRaioni = izbiratelniRaioni;

            viewModel.IzbRaionFilter = new IzbRaionWithSikFilter
            {
                AllIzbRaioni = izbiratelniRaioni
            };

            viewModel.PartiaFilter = new PartiaFilterViewModel
            {
                AllSili = _pariqServices.GetAllParti().Select(i => new SelectListItem
                {
                    Value = i.Id.ToString(),
                    Text = i.Name
                }).ToList()
            };

            viewModel.RoliFilter = new RoliSpravkaFilter
            {
                AllRoli = _codePositionsServices.GetAllCodePositionsByPkode(4).Select(p => new SelectListItem
                {
                    Value = p.Nkode.ToString(),
                    Text = p.Nime
                }).OrderBy(c => c.Value)
                .ToList()
            };

            viewModel.RoliFilter.AllRoli.Insert(0, new SelectListItem
            {
                Value = "",
                Text = "Всички"
            });

            viewModel.PartiaFilter.AllSili.Insert(0, new SelectListItem
            {
                Value = "",
                Text = "Всички"
            });

         
            viewModel.IzbRaionFilter.AllAdministrativniRaioni = _raioniServices.GetAdmninistrativniRaioniByIzbRaion
                                                                (
                                                                    viewModel.IzbRaionFilter.AllIzbRaioni[0].Value
                                                                )
                                                                .Select(i => new SelectListItem
                                                                {
                                                                    Value = i.Nkod,
                                                                    Text = i.Nime
                                                                }).ToList();

            viewModel.IzbRaionFilter.AllAdministrativniRaioni.Insert(0, new SelectListItem
            {
                Value = "",
                Text = "Всички"
            });

            viewModel.IzbRaionFilter.AllSik = _sikServices.GetSiksByAdministrativenRaion(administrativen).Select(r => new SelectListItem
            {
                Value = r.Id,
                Text = r.Id + " | " + r.Address
            }).ToList();

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

            return View("Statistics", viewModel);
        }

        public IActionResult StatisticsSlujebni()
        {

            string administrativen = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            var allStatistics = _spravkiServices.GetAllStatistics(1);

            var viewModel = new SpravkiCompositeViewModel
            {
                typestatistics = 2,

                AllStatistics = allStatistics.ToList(),

                AllAdministrativniRaioni = _raioniServices.GetAllRaioni(null).Select(r => new SelectListItem
                {
                    Value = r.Id,
                    Text = r.Name
                }).ToList(),

                AllSekcii = _sikServices.GetSiksByAdministrativenRaion(administrativen).Select(r => new SelectListItem
                {
                    Value = r.IdSek.ToString(),
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
                }).ToList()
            };

            viewModel.SlujebnaSpravka221FiletModel = new SikSpravkaFilter
            {
                AllSik = _sikServices.GetSiksByAdministrativenRaion(administrativen).Select(r => new SelectListItem
                {
                    Value = r.IdSek.ToString(),
                    Text = r.Id + " | " + r.Address
                }).ToList()
            };

            var codes = new List<int>() { 304, 305, 306 };
            viewModel.RziFilter = new SpravkaRziFilter();

            viewModel.RziFilter.AllDeistviq = _codePositionsServices.GetAllCodePositionsByPkode(3)
                        .Where(c => codes.Contains(c.Nkode))
                        .Select(p => new SelectListItem
                        {
                            Value = p.Nkode.ToString(),
                            Text = p.Nime
                        }).OrderBy(c => c.Value)
              .ToList();

            var izbiratelniRaioni = _izbiratelniRaioniServices.GetIzbiratelniRaioni().Select(i => new SelectListItem
            {
                Value = i.Nkod,
                Text = i.Nime
            }).ToList();

            izbiratelniRaioni.Insert(0, new SelectListItem
            {
                Value = "00",
                Text = "Всички"
            });

            viewModel.RziFilter.AllIzbRaioni = izbiratelniRaioni;

            viewModel.IzbRaionFilter = new IzbRaionWithSikFilter
            {
                AllIzbRaioni = izbiratelniRaioni
            };

            viewModel.PartiaFilter = new PartiaFilterViewModel
            {
                AllSili = _pariqServices.GetAllParti().Select(i => new SelectListItem
                {
                    Value = i.Id.ToString(),
                    Text = i.Name
                }).ToList()
            };

            viewModel.RoliFilter = new RoliSpravkaFilter
            {
                AllRoli = _codePositionsServices.GetAllCodePositionsByPkode(4).Select(p => new SelectListItem
                {
                    Value = p.Nkode.ToString(),
                    Text = p.Nime
                }).OrderBy(c => c.Value)
                .ToList()
            };

            viewModel.RoliFilter.AllRoli.Insert(0, new SelectListItem
            {
                Value = "",
                Text = "Всички"
            });

            viewModel.PartiaFilter.AllSili.Insert(0, new SelectListItem
            {
                Value = "",
                Text = "Всички"
            });

            viewModel.IzbRaionFilter.AllAdministrativniRaioni = _raioniServices.GetAdmninistrativniRaioniByIzbRaion
                                                                (
                                                                    viewModel.IzbRaionFilter.AllIzbRaioni[0].Value
                                                                )
                                                                .Select(i => new SelectListItem
                                                                {
                                                                    Value = i.Nkod,
                                                                    Text = i.Nime
                                                                }).ToList();

            viewModel.IzbRaionFilter.AllAdministrativniRaioni.Insert(0, new SelectListItem
            {
                Value = "",
                Text = "Всички"
            });      

            viewModel.IzbRaionFilter.AllSik = _sikServices.GetSiksByAdministrativenRaion(administrativen).Select(r => new SelectListItem
            {
                Value = r.IdSek.ToString(),
                Text  = r.Id + " | " + r.Address
            }).ToList();  

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

            return View("Statistics", viewModel);
        }

        public IActionResult NomenklaturesPublic()
        {
            var allNomenklatures = _spravkiServices.GetAllNomenklatures(0);

            return View("Nomenklatures", allNomenklatures);
        }

        public IActionResult NomenklaturesLocal()
        {
            var allNomenklatures = _spravkiServices.GetAllNomenklatures(1);

            return View("NomenklaturesLocal", allNomenklatures);
        }

        public IActionResult NomenklatureDetails(NomenklatureIds nomenklatureId)
        {
            string administrativen = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            var compositeModel = new NomenklatureComposite
            {
                NomenklatureId = nomenklatureId,
                CurrentPage = 1,
                MaxPages = _spravkiServices.GetNomenklatureMaxPages(nomenklatureId, null, administrativen),
            };

            compositeModel.AllNomenklatures = _spravkiServices.GetNomenklatureBasicDetails(nomenklatureId, compositeModel.CurrentPage, compositeModel.NameFilter, administrativen);

            return View("NomenklatureDetails", compositeModel);
        }

        public JsonResult NomenklatureEdit(NomenklatureIds nomenklatureId, string nomenklatureCode, int id)
        {
            var editViewModel = _spravkiServices.GetNomenklatureEdit(nomenklatureId, nomenklatureCode, id);

            var NomenklatureEditAsHtmlString = this.RenderViewAsync("../PartialViews/NomenklatureEditPartial", editViewModel, true).Result;

            return Json(new
            {
                NomenklatureEdiHtml = NomenklatureEditAsHtmlString
            });
        }

        public JsonResult EditNomenklatureBasic(NomenklatureEditFullViewModel model)
        {
            if (ModelState.IsValid)
            {
                _spravkiServices.NomenklatureEdit(model);
                return Json(new { success = true });
            }
            else
            {
                var nomenklatureEditAsHtmlString = this.RenderViewAsync("../PartialViews/NomenklatureEditPartial", model, true).Result;
                return Json(new { success = false, editModalHTML = nomenklatureEditAsHtmlString });
            }
        }

        public JsonResult GetNomenklatureDetails(NomenklatureComposite model)
        {
            string administrativen = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            model.MaxPages = _spravkiServices.GetNomenklatureMaxPages(model.NomenklatureId, model.NameFilter, administrativen);

            if (model.MaxPages < model.CurrentPage)
            {
                model.CurrentPage = 1;
            }

            model.AllNomenklatures = _spravkiServices.GetNomenklatureBasicDetails(model.NomenklatureId, model.CurrentPage, model.NameFilter, administrativen);

            var NomenklatureTableAsHtmlString = this.RenderViewAsync("../PartialViews/NomenklatureDetailsTablePartial", model, true).Result;
            var PaginationAsHtmlString = this.RenderViewAsync("../PartialViews/NomenklatureDetailsPaginationPartial", model, true).Result;

            return Json(new
            {
                NomenklatureTableHTML = NomenklatureTableAsHtmlString,
                PaginationHTML = PaginationAsHtmlString
            });
        }

        public JsonResult GetNomenklatureAdd(NomenklatureIds nomenklatureId)
        {
            var model = _spravkiServices.GetNomenklatureAdd(nomenklatureId);

            var NomenklatureAddAsHtmlString = this.RenderViewAsync("../PartialViews/NomenklatureAddPartial", model, true).Result;

            return Json(new
            {
                NomenklatureAddHtml = NomenklatureAddAsHtmlString
            });
        }
        public JsonResult AddNomenklature(NomenklatureEditFullViewModel model)
        {
            string administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            if (model.Has_Pkode)
            {
                try
                {
                    if (model.Pkode != Int32.Parse(model.Nkod.Substring(0, 1))) {
                        ModelState.AddModelError("Nkod", "Грешен код");
                        var NomenklatureAddAsHtmlStringDuplicate = this.RenderViewAsync("../PartialViews/NomenklatureAddPartial", model, true).Result;
                        return Json(new { success = false, addModalHTML = NomenklatureAddAsHtmlStringDuplicate });
                    }
                }
                catch (FormatException e)
                {
                    ModelState.AddModelError("Nkod", e.Message);
                    var NomenklatureAddAsHtmlStringDuplicate = this.RenderViewAsync("../PartialViews/NomenklatureAddPartial", model, true).Result;
                    return Json(new { success = false, addModalHTML = NomenklatureAddAsHtmlStringDuplicate });
                }
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _spravkiServices.NomenklatureAdd(model, administrativenRaion);
                    return Json(new { success = true });
                }
                catch (ArgumentException e)
                {
                    ModelState.AddModelError("Nkod", e.Message);
                    var NomenklatureAddAsHtmlStringDuplicate = this.RenderViewAsync("../PartialViews/NomenklatureAddPartial", model, true).Result;
                    return Json(new { success = false, addModalHTML = NomenklatureAddAsHtmlStringDuplicate });
                }
            }

            var NomenklatureAddAsHtmlString = this.RenderViewAsync("../PartialViews/NomenklatureAddPartial", model, true).Result;
            return Json(new { success = false, addModalHTML = NomenklatureAddAsHtmlString });
        }

        public void NomenklatureDelete(NomenklatureIds nomenklatureId, string nomenklatureCode, int id)
        {
            _spravkiServices.NomenklatureDelete(nomenklatureId, nomenklatureCode, id);
        }

        public IActionResult LicaStatisticFilter(Statistics statisticId)
        {
            string administrativen = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            var viewModel = new LicaFilterViewModel()
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

                StatisticId = statisticId
            };

/* v.2
            viewModel.AllSekcii.Insert(0, new SelectListItem
            {
                Text = "Няма",
                Value = "",
                Selected = true
            });
*/

            int IzborTur = _izboriServices.getIzborCurrentTur();

            if (IzborTur > 1 ) 
            {
                viewModel.AllTurs.Insert(0, new SelectListItem
                {
                    Text = "Втори",
                    Value = "2",
                    Selected = (IzborTur == 2)
                });

                viewModel.AllTurs.Insert(1, new SelectListItem
                {
                    Text = "Първи",
                    Value = "1",
                    Selected = (IzborTur == 1)
                });
            } else
            {
                viewModel.AllTurs.Insert(0, new SelectListItem
                {
                    Text = "Първи",
                    Value = "1",
                    Selected = (IzborTur == 1)
                });
            }



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

            return View("LicaFilter", viewModel);
        }

        public IActionResult LicaStatisticUpdateFilter(Statistics statisticId)
        {
            string administrativen = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            var viewModel = new LicaFilterViewModel()
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

                StatisticId = statisticId
            };


            int IzborTur = _izboriServices.getIzborCurrentTur();

            if (IzborTur > 1)
            {
                viewModel.AllTurs.Insert(0, new SelectListItem
                {
                    Text = "Втори",
                    Value = "2",
                    Selected = (IzborTur == 2)
                });

                viewModel.AllTurs.Insert(1, new SelectListItem
                {
                    Text = "Първи",
                    Value = "1",
                    Selected = (IzborTur == 1)
                });
            }
            else { 
                viewModel.AllTurs.Insert(0, new SelectListItem
                {
                    Text = "Първи",
                    Value = "1",
                    Selected = (IzborTur == 1)
                });
            }

/*
            viewModel.AllSekcii.Insert(0, new SelectListItem
            {
                Text = "Всички",
                Value = ""
            });
*/

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

            return View("LicaFilterUpdate", viewModel);
        }

        [HttpPost]
        public JsonResult PrintStatistic([FromBody] GenerateReportViewModel model)
        {
            var reportGUID = _spravkiServices.GetStatisticContents(model, _userManager.GetUserId(User));
            return Json(new {success=true, fileGUID = reportGUID });
        }

        public IActionResult GetSpisukNaSekciiteSpravka(IzbRaionWithSikFilter filter)
        {
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                filter.IzbRaionNkod = "00";
                filter.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }
            var data = _spravkiServices.GetSpisukNaSekciiteSpravka(filter, _userManager.GetUserId(User)).ToList();

            if (data.Count == 0)
            {
                data.Insert(0, new SpisukNaSekciiteSpravkaViewModel());
                data.ElementAt(0).NmIzbRajon = _izboriServices.GetIzborDescription();
            }

            data.ForEach(x => x.filter = filter);

            return View("spravka_1_2", data);
        }

        public IActionResult GetSpisukNaSekciiteSpravka2(IzbRaionWithSikFilter filter)
        {
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                filter.IzbRaionNkod = "00";
                filter.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }
            var data = _spravkiServices.GetSpisukNaSekciiteSpravka(filter, _userManager.GetUserId(User)).ToList();
            if (data.Count == 0)
            {
                data.Insert(0, new SpisukNaSekciiteSpravkaViewModel());
                data.ElementAt(0).NmIzbRajon = _izboriServices.GetIzborDescription();
            }

            data.ForEach(x => x.filter = filter);

            return View("spravka_1_2_1", data);
        }

        public IActionResult GetBroiSekciiSpravka(IzbRaionWithSikFilter filter)
        {
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                filter.IzbRaionNkod = "00";
                filter.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var data = _spravkiServices.GetBroiSekciiSpravka(filter, _userManager.GetUserId(User));

            foreach(var dataInstance in data)
            {
                dataInstance.NmIzbor = _izboriServices.GetIzborDescription();
            }
            
            return View("spravka_1_1", data);
        }

        public IActionResult GetZaetiPoziciiSpravka(IzbRaionWithSikFilter filter)
        {
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                filter.IzbRaionNkod = "00";
                filter.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var data = _spravkiServices.GetZaetiPoziciiPublichnaSpravka(filter, _userManager.GetUserId(User));

            foreach (var dataInstance in data)
            {
                dataInstance.NmIzbor = _izboriServices.GetIzborDescription();
            }

            return View("spravka_4_1", data);
        }

        public IActionResult GetZaetiPoziciiObjoSpravka(IzbRaionWithSikFilter filter)
        {
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                filter.IzbRaionNkod = "00";
                filter.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            } else
            {
                filter.AdministrativenRaion = "00";
            }

            var data = _spravkiServices.GetZaetiPoziciiObjoPublichnaSpravka(filter, _userManager.GetUserId(User));

            foreach (var dataInstance in data)
            {
                dataInstance.NmIzbor = _izboriServices.GetIzborDescription();
            }

            return View("spravka_4_1", data);
        }

        public IActionResult GetReshetkaSpravka(PartiaFilterViewModel filter)
        {
            var data = _spravkiServices.GetReshetkaSpravka(filter,_userServices.GetUserRegion(_userManager.GetUserId(User)).Id, _userManager.GetUserId(User));

            foreach (var dataInstance in data)
            {
                dataInstance.NmIzbor = _izboriServices.GetIzborDescription();
            }

            return View("spravka_4_3", data);
        }

        public IActionResult GetZamestvajiSpravka(SikSpravkaFilter filter)
        {
            var data = _spravkiServices.GetZamestvajiSpravka(filter, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id, _userManager.GetUserId(User)).ToList();

            if(data.Count == 0)
            {
                data.Insert(0, new ZamestvajiSpravkaViewModel());
            }

            data.ForEach(x => x.NmIzbor = _izboriServices.GetIzborDescription());
            data.ForEach(x => x.filter = filter);

            return View("spravka_2_3", data);
        }

        public IActionResult GetSustoqnieNaRegistraciiteSpravka(RoliSpravkaFilter filter)
        {
            var data = _spravkiServices.GetSustoqnieNaRegistraciiteSpravka(filter, _userServices.GetUserRegion(_userManager.GetUserId(User)).Id, _userManager.GetUserId(User)).ToList();

            if (data.Count == 0)
            {
                data.Insert(0, new SustoqnieNaRegistraciiteSpravkaViewModel());
            }

            var roli = _codePositionsServices.GetAllCodePositionsByPkode(4).Select(p => new SelectListItem
            {
                Value = p.Nkode.ToString(),
                Text = p.Nime
            }).OrderBy(c => c.Value)
            .ToList();

            var rolq = "Всички";

            if (!string.IsNullOrEmpty(filter.Rolq))
            {
                rolq = roli.FirstOrDefault(r => r.Value == filter.Rolq).Text;
            }

            foreach (var dataInstance in data)
            {
                dataInstance.NmIzbor = _izboriServices.GetIzborDescription();
                dataInstance.Rolq = rolq;
            }

            return View("spravka_9_3", data);
        }

        public FileResult DownloadReportByGuid(Statistics statisticId, string guid)
        {
            var docForDownload = DocX.Load(Path.Combine(_hostingEnvironment.WebRootPath, "templates").ToString() + "/"+ statisticId.EnumDescription() +"_" + guid + ".rtf");

            var docMemoryStream = new MemoryStream();

            docForDownload.SaveAs(docMemoryStream);

            docMemoryStream.Position = 0;

            System.IO.File.Delete(Path.Combine(_hostingEnvironment.WebRootPath, "templates").ToString() + "/"+ statisticId.EnumDescription() + "_" + guid + ".rtf");

            return File(docMemoryStream.GetBuffer()
                , System.Net.Mime.MediaTypeNames.Application.Octet
                , statisticId.EnumDescription()+"_" + DateTime.Now.ToShortDateString() + "_" + DateTime.Now.ToLongTimeString() + ".rtf");
        }

        public IActionResult GetControlSpisukNaSekciiteSpravka(IzbRaionWithSikFilter filter)
        {
            var administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            filter.IzbRaionNkod = "00";
            filter.AdministrativenRaion = administrativenRaion;

            var data = _spravkiServices.GetSpisukNaSekciiteSpravka(filter, _userManager.GetUserId(User));

            return View("spravka_1_3", data);
        }

        public string GenerateSpisukLicaExcelExport(LicaFilterViewModel filter)
        {
            filter.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            var fileName = _spravkiServices.GenerateSpisukLicaExcelExport(filter, _userManager.GetUserId(User));

            return string.Join(",", Encoding.Convert(Encoding.UTF8, Encoding.Unicode, Encoding.Default.GetBytes(fileName)));
        }

        public FileResult DownloadReport(string fileName)
        {
            byte[] stringBytes = Array.ConvertAll(fileName.Split(','), byte.Parse);

            fileName = Encoding.Unicode.GetString(stringBytes);

            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";

            var file = new FileInfo(Path.Combine(sWebRootFolder, fileName));

            ExcelPackage package = new ExcelPackage(file);

            var packageByteArray = package.GetAsByteArray();

            System.IO.File.Delete(Path.Combine(_hostingEnvironment.WebRootPath, "reports").ToString() + "/" + fileName);

            string realfilename = fileName.Substring(0, fileName.IndexOf("("));

            return File(packageByteArray
                , "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                , realfilename + DateTime.Now.ToShortDateString() + "_" + DateTime.Now.ToLongTimeString() + ".xlsx");
        }


        public string GenerateSpisukLicaExcelExport23(SikSpravkaFilter filter)
        {
            var administrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            var userId = _userManager.GetUserId(User);

            var fileName = _spravkiServices.GenerateSpisukLicaExcelExport23(
                                    filter
                                    , administrativenRaion
                                    , userId
                            );

            return string.Join(",", Encoding.Convert(Encoding.UTF8, Encoding.Unicode, Encoding.Default.GetBytes(fileName)));
        }

        //v.2
        public IActionResult StatisticsDocumenti()
        {

            string administrativen = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;

            var allStatistics = _spravkiServices.GetAllStatistics(3);

            var viewModel = new SpravkiCompositeViewModel
            {
                typestatistics = 0,

                AllStatistics = allStatistics.ToList(),

                AllAdministrativniRaioni = _raioniServices.GetAllRaioni(null).Select(r => new SelectListItem
                {
                    Value = r.Id,
                    Text = r.Name
                }).ToList(),

                AllSekcii = _sikServices.GetSiksByAdministrativenRaion(administrativen).Select(r => new SelectListItem
                {
                    Value = r.IdSek.ToString(),
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
                }).ToList()
            };

            viewModel.SlujebnaSpravka221FiletModel = new SikSpravkaFilter
            {
                AllSik = _sikServices.GetSiksByAdministrativenRaion(administrativen).Select(r => new SelectListItem
                {
                    Value = r.IdSek.ToString(),
                    Text = r.Id + " | " + r.Address
                }).ToList()
            };

            var codes = new List<int>() { 304, 305, 306 };
            viewModel.RziFilter = new SpravkaRziFilter();

            viewModel.RziFilter.AllDeistviq = _codePositionsServices.GetAllCodePositionsByPkode(3)
                        .Where(c => codes.Contains(c.Nkode))
                        .Select(p => new SelectListItem
                        {
                            Value = p.Nkode.ToString(),
                            Text = p.Nime
                        }).OrderBy(c => c.Value)
              .ToList();

            var izbiratelniRaioni = _izbiratelniRaioniServices.GetIzbiratelniRaioni().Select(i => new SelectListItem
            {
                Value = i.Nkod,
                Text = i.Nime
            }).ToList();

            izbiratelniRaioni.Insert(0, new SelectListItem
            {
                Value = "00",
                Text = "Всички"
            });

            viewModel.RziFilter.AllIzbRaioni = izbiratelniRaioni;

            viewModel.IzbRaionFilter = new IzbRaionWithSikFilter
            {
                AllIzbRaioni = izbiratelniRaioni
            };

            viewModel.PartiaFilter = new PartiaFilterViewModel
            {
                AllSili = _pariqServices.GetAllParti().Select(i => new SelectListItem
                {
                    Value = i.Id.ToString(),
                    Text = i.Name
                }).ToList()
            };

            viewModel.RoliFilter = new RoliSpravkaFilter
            {
                AllRoli = _codePositionsServices.GetAllCodePositionsByPkode(4).Select(p => new SelectListItem
                {
                    Value = p.Nkode.ToString(),
                    Text = p.Nime
                }).OrderBy(c => c.Value)
                .ToList()
            };

            viewModel.RoliFilter.AllRoli.Insert(0, new SelectListItem
            {
                Value = "",
                Text = "Всички"
            });

            viewModel.PartiaFilter.AllSili.Insert(0, new SelectListItem
            {
                Value = "",
                Text = "Всички"
            });

         
            viewModel.IzbRaionFilter.AllAdministrativniRaioni = _raioniServices.GetAdmninistrativniRaioniByIzbRaion
                                                                (
                                                                    viewModel.IzbRaionFilter.AllIzbRaioni[0].Value
                                                                )
                                                                .Select(i => new SelectListItem
                                                                {
                                                                    Value = i.Nkod,
                                                                    Text = i.Nime
                                                                }).ToList();

            viewModel.IzbRaionFilter.AllAdministrativniRaioni.Insert(0, new SelectListItem
            {
                Value = "",
                Text = "Всички"
            });

            viewModel.IzbRaionFilter.AllSik = _sikServices.GetSiksByAdministrativenRaion(administrativen).Select(r => new SelectListItem
            {
                Value = r.IdSek.ToString(),
                Text = r.Id + " | " + r.Address
            }).ToList();

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

            return View("Statistics", viewModel);
        }

        
        public IActionResult GetSpisykPodvizjniSekcii(IzbRaionWithSikFilter filter)
        {
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                filter.IzbRaionNkod = "00";
                filter.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var data = _spravkiServices.GetSpisykPodvizjniSekcii(filter, _userManager.GetUserId(User));

            return View("spravka_1_4", data);
        }

        public IActionResult GetSikIstoria(IzbRaionWithSikFilter filter)
        {
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal) {
                filter.IzbRaionNkod = "00";
                filter.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var data = _spravkiServices.GetSikIstoria(filter, _userManager.GetUserId(User));

            return View("spravka_9_2", data);
        }

        public IActionResult GetSpisukSekciiGraniciSpravka(IzbRaionWithSikFilter filter)
        {
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                filter.IzbRaionNkod = "00";
                filter.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var data = _spravkiServices.GetSpisukSekciiGraniciSpravka(filter, _userManager.GetUserId(User));

            return View("spravka_1_5", data);
        }

        public IActionResult GetSpisukSekciiGraniciSpravka2(IzbRaionWithSikFilter filter)
        {
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                filter.IzbRaionNkod = "00";
                filter.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var data = _spravkiServices.GetSpisukSekciiGraniciSpravka(filter, _userManager.GetUserId(User));

            return View("spravka_1_5_2", data);
        }


        public IActionResult GetSpisukRziSpravka (SpravkaRziFilter filter)
        {
            var toa = "00";
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                toa = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var data = _spravkiServices.GetSpisukRziSpravka(filter,toa).ToList();

            if (data.Count == 0)
            {
                data.Insert(0, new LicaForSpravkaRziViewModel());
                data.ElementAt(0).NmIzbRajon = _izboriServices.GetIzborDescription();
            }

            data.ForEach(x => x.filter = filter);
            return View("spravka_1_6", data);
        }

         public string GenerateSpisukRziExport(SpravkaRziFilter filter)
        {
            
            var toa = "00";
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                toa = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var fileName = _spravkiServices.GenerateSpisukRziExport(
                                    filter
                                    ,toa
                            );

            return string.Join(",", Encoding.Convert(Encoding.UTF8, Encoding.Unicode, Encoding.Default.GetBytes(fileName)));
        }

        public IActionResult GetSpisukSekciiLica(IzbRaionWithSikFilter filter)
        {
            var toa = "00";
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                filter.AdministrativenRaion = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var data = _spravkiServices.GetSpisukSekciiLica(filter).ToList();

            if (data.Count == 0)
            {
                data.Insert(0, new SpravkaSekciiLicaViewModel());
                data.ElementAt(0).NmIzbRajon = _izboriServices.GetIzborDescription();
            }

            data.ForEach(x => x.filter = filter);
            return View("spravka_1_7", data);
        }

        public string GenerateSekciiLicaExport(IzbRaionWithSikFilter filter)
        {

            var toa = "00";
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                toa = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var fileName = _spravkiServices.GenerateSekciiLicaExport(filter);

            return string.Join(",", Encoding.Convert(Encoding.UTF8, Encoding.Unicode, Encoding.Default.GetBytes(fileName)));
        }

        public string GenerateSpisykSekcii(IzbRaionWithSikFilter filter)
        {

            var toa = "00";
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                toa = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var fileName = _spravkiServices.GenerateSpisykSekcii(filter, _userManager.GetUserId(User));

            return string.Join(",", Encoding.Convert(Encoding.UTF8, Encoding.Unicode, Encoding.Default.GetBytes(fileName)));
        }

        public string GenerateSpisykSekcii2(IzbRaionWithSikFilter filter)
        {

            var toa = "00";
            var IsUserGlobal = _userServices.GetEditUserById(_userManager.GetUserId(User)).AdministrativenRaion == null ? true : false;

            if (!IsUserGlobal)
            {
                toa = _userServices.GetUserRegion(_userManager.GetUserId(User)).Id;
            }

            var fileName = _spravkiServices.GenerateSpisykSekcii2(filter, _userManager.GetUserId(User));

            return string.Join(",", Encoding.Convert(Encoding.UTF8, Encoding.Unicode, Encoding.Default.GetBytes(fileName)));
        }

    }


}