
namespace Services.Implementations.Lica
{
    using System.Collections.Generic;
    using System.Linq;
    using Common.ViewModels.Lica;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Repository.Interfaces.Codepositions;
    using Repository.Interfaces.Kvartali;
    using Repository.Interfaces.Lica;
    using Repository.Interfaces.Nacionalnosti;
    using Repository.Interfaces.NaseleniMesta;
    using Repository.Interfaces.Objini;
    using Repository.Interfaces.Oblasti;
    using Repository.Interfaces.Obrazovaniq;
    using Repository.Interfaces.Partiq;
    using Repository.Interfaces.Raion;
    using Repository.Interfaces.RaionniUpravleniq;
    using Repository.Interfaces.Sik;
    using Repository.Interfaces.Specialnosti;
    using Repository.Interfaces.Spravki;
    using Repository.Interfaces.Ulici;
    using Services.Interfaces.Lica;
    using Common.Enums.Spravki;
    using System;
    using Common.ViewModels.Spravki;
    using OfficeOpenXml;
    using System.IO;
    using System.Drawing;
    using Microsoft.AspNetCore.Hosting;
    using OfficeOpenXml.Style;
    using Services.Interfaces.User;
    using Common.ViewModels.User;
    using Microsoft.AspNetCore.Identity;
    using Repository.Interfaces.Izbori;
    using System.Globalization;
    using System.Threading;
    using System.Threading.Tasks;

    public class LicaServices : ILicaServices
    {
        private readonly ILicaRepository _licaRepository;
        private readonly IRaionRepository _raionRepository;
        private readonly IUliciRepository _uliciRepository;
        private readonly IKvartaliRepository _kvartaliRepository;
        private readonly IOblastiRepository _oblastiRepository;
        private readonly IObjiniRepository _objiniRepository;
        private readonly INaseleniMestaRepository _naseleniMestaRepository;
        private readonly ICodePositionsRepository _codePositionsRepository;
        private readonly ISpecialnostiRepository _specialnostiRepository;
        private readonly IObrazovaniqRepository _obrazovaniqRepository;
        private readonly IPartiqRepository _partiiRepository;
        private readonly INacionalnostiRepository _nacionalstiRepository;
        private readonly IRaionniUpravleniqRepository _raionniUpravleniqRepository;
        private readonly ISikRepository _sikRepository;
        private readonly ISpravkiRepository _spravkiRepository;
        private readonly IIzboriRepository _izboriRepository;

        private readonly IHostingEnvironment _hostingEnvironment;

        public LicaServices(ILicaRepository licaRepository,
            IRaionRepository raionRepository,
            IUliciRepository uliciRepository,
            IKvartaliRepository kvartaliRepository,
            IOblastiRepository oblastiRepository,
            IObjiniRepository objiniRepository,
            INaseleniMestaRepository naseleniMestaRepository,
            ICodePositionsRepository codePositionsRepository,
            ISpecialnostiRepository specialnostiRepository,
            IObrazovaniqRepository obrazovaniqRepository,
            IPartiqRepository partiiRepository,
            INacionalnostiRepository nacionalnostiRepository,
            IRaionniUpravleniqRepository raionniUpravleniqRepository,
            ISikRepository sikRepository,
            ISpravkiRepository spravkiRepository,
            IHostingEnvironment hostingEnvironment,
            IIzboriRepository izboriRepository
             )
        {
            _hostingEnvironment = hostingEnvironment;

            _sikRepository = sikRepository;
            _raionniUpravleniqRepository = raionniUpravleniqRepository;
            _nacionalstiRepository = nacionalnostiRepository;
            _partiiRepository = partiiRepository;
            _obrazovaniqRepository = obrazovaniqRepository;
            _specialnostiRepository = specialnostiRepository;
            _licaRepository = licaRepository;
            _raionRepository = raionRepository;
            _uliciRepository = uliciRepository;
            _objiniRepository = objiniRepository;
            _oblastiRepository = oblastiRepository;
            _kvartaliRepository = kvartaliRepository;
            _naseleniMestaRepository = naseleniMestaRepository;
            _codePositionsRepository = codePositionsRepository;
            _spravkiRepository = spravkiRepository;
            _izboriRepository = izboriRepository;
        }

        public LicaAddViewModel GetLicaAddViewModel(string administrativenRaion, int sik)
        {
            var licaAddModel = new LicaAddViewModel
            {
                AllResheniq = _spravkiRepository.GetAllNomeklatureBasicDetails(NomenklatureIds.Dokumenti, administrativenRaion).Select(d => new SelectListItem
                {
                    Value = d.Code,
                    Text = d.Name
                }).ToList(),

                AllDeinosti = _codePositionsRepository.GetAllCodePositionsByPkode(3).Select(p => new SelectListItem
                {
                    Value = p.Nkode.ToString(),
                    Text = p.Nime
                }).OrderBy(c=>c.Value)
                .ToList(),

                AllRoli = _codePositionsRepository.GetAllCodePositionsByPkode(4).Select(p => new SelectListItem
                {
                    Value = p.Nkode.ToString(),
                    Text = p.Nime
                }).OrderBy(c => c.Value)
                .ToList(),

                AllSpecialnosti = _specialnostiRepository.GetAllSpecialnosti().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),

                AllObrazovaniq = _obrazovaniqRepository.GetAllObrazovaniq().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),

                AllPoliticheskiSili = _partiiRepository.GetAllParti().Select(p => new SelectListItem
                {
                    Value = p.Id.ToString(),
                    Text = p.Name
                }).ToList(),

                AllNacionalnosti = _nacionalstiRepository.GetAllNactionalnosti().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),

                AllRuNaMvr = _raionniUpravleniqRepository.GetAllRaionniUpravleniq().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),

                AllSik = _sikRepository.GetAllSiksIncludingDefault(administrativenRaion)
                    .Select(p => new SelectListItem
                    {
                        Value = p.IdSek.ToString(),
                        Text = p.Id + " | " + p.Address
                    })
                    .ToList(),

                AllObjini = _objiniRepository.GetAllObjini().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),

                AllOblasti = _oblastiRepository.GetAllOblasti().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),

                AllNaseleniMesta = _naseleniMestaRepository.GetAllNaseleniMesta().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),

                AllAdministrativniRaioni = _raionRepository.GetAllRaioni(administrativenRaion).Select(p => new SelectListItem
                {
                    Value = p.Id,
                    Text = p.Name
                }).ToList(),

                AllKvartali = _kvartaliRepository.GetAllKvartali().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),

                AllLica = new List<SelectListItem>()

            };

            //if(sik > 0)
            //{
            //    licaAddModel.AllSik = licaAddModel.AllSik.Where(s => s.Value == sik.ToString()).ToList();
            //    licaAddModel.IdSik = Convert.ToInt32(licaAddModel.AllSik[0].Value);
            //}
            //else
            //{
            licaAddModel.AllSik.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });
            //}

            licaAddModel.AllLica.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });

            licaAddModel.AllPoliticheskiSili.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });


            licaAddModel.AllRoli.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });

            licaAddModel.AllResheniq.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });

            licaAddModel.AllUlici = _uliciRepository.GetUliciByNaselenoMqsto(licaAddModel.AllNaseleniMesta.ElementAt(0).Value).Select(p => new SelectListItem
            {
                Value = p.Nrec.ToString(),
                Text = p.Nime
            }).ToList();


            return licaAddModel;
        }

        public LicaEditViewModel GetLicaById(int id, string userId)
        {
            var liceEditModal = _licaRepository.GetLicaById(id);

            liceEditModal.AllResheniq = _spravkiRepository.GetAllNomeklatureBasicDetails(NomenklatureIds.Dokumenti, liceEditModal.Raion).Select(d => new SelectListItem
            {
                Value = d.Code,
                Text = d.Name
            }).ToList();

            liceEditModal.AllDeinosti = _codePositionsRepository.GetAllCodePositionsByPkode(3).Select(p => new SelectListItem
            {
                Value = p.Nkode.ToString(),
                Text = p.Nime
            }).OrderBy(c => c.Value)
            .ToList();

            liceEditModal.AllRoli = _codePositionsRepository.GetAllCodePositionsByPkode(4).Select(p => new SelectListItem
            {
                Value = p.Nkode.ToString(),
                Text = p.Nime
            }).OrderBy(c => c.Value)
            .ToList();

            liceEditModal.AllSpecialnosti = _specialnostiRepository.GetAllSpecialnosti().Select(p => new SelectListItem
            {
                Value = p.Nkod,
                Text = p.Nime
            }).ToList();

            liceEditModal.AllObrazovaniq = _obrazovaniqRepository.GetAllObrazovaniq().Select(p => new SelectListItem
            {
                Value = p.Nkod,
                Text = p.Nime
            }).ToList();

            liceEditModal.AllPoliticheskiSili = _partiiRepository.GetAllParti().Select(p => new SelectListItem
            {
                Value = p.Id.ToString(),
                Text = p.Name
            }).ToList();

            liceEditModal.AllNacionalnosti = _nacionalstiRepository.GetAllNactionalnosti().Select(p => new SelectListItem
            {
                Value = p.Nkod,
                Text = p.Nime
            }).ToList();

            liceEditModal.AllRuNaMvr = _raionniUpravleniqRepository.GetAllRaionniUpravleniq().Select(p => new SelectListItem
            {
                Value = p.Nkod,
                Text = p.Nime
            }).ToList();

            liceEditModal.AllSik = _sikRepository.GetAllSiksIncludingDefault(liceEditModal.Raion)
                .Select(p => new SelectListItem
                        {
                            Value = p.IdSek.ToString(),
                            Text = p.Id + " | " + p.Address
                        })
                .ToList();

            liceEditModal.AllObjini = _objiniRepository.GetAllObjini().Select(p => new SelectListItem
            {
                Value = p.Nkod,
                Text = p.Nime
            }).ToList();

            liceEditModal.AllOblasti = _oblastiRepository.GetAllOblasti().Select(p => new SelectListItem
            {
                Value = p.Nkod,
                Text = p.Nime
            }).ToList();

            liceEditModal.AllNaseleniMesta = _naseleniMestaRepository.GetAllNaseleniMesta().Select(p => new SelectListItem
            {
                Value = p.Nkod,
                Text = p.Nime
            }).ToList();

            liceEditModal.AllAdministrativniRaioni = _raionRepository.GetAllRaioni(liceEditModal.Raion).Select(p => new SelectListItem
            {
                Value = p.Id,
                Text = p.Name
            }).ToList();

            liceEditModal.AllKvartali = _kvartaliRepository.GetAllKvartali().Select(p => new SelectListItem
            {
                Value = p.Nkod,
                Text = p.Nime
            }).ToList();

            liceEditModal.AllUlici = _uliciRepository.GetUliciByNaselenoMqsto(liceEditModal.AllNaseleniMesta.ElementAt(0).Value).Select(p => new SelectListItem
            {
                Value = p.Nrec.ToString(),
                Text = p.Nime
            }).ToList();

            liceEditModal.AllLica = _licaRepository.GetLicaBySikToaAndSila(liceEditModal.Raion
                                                                         , _sikRepository.GetSik(liceEditModal.IdSik).Sik
                                                                         , liceEditModal.PoliticheskaSila)
                                                   .Select(p => new SelectListItem
                                                        {
                                                            Value = p.Id.ToString(),
                                                            Text = p.Imena
                                                        })
                                                   .Where(l => l.Value != liceEditModal.Id.ToString())
                                                   .ToList();

            liceEditModal.AllLicaFromPartia = _licaRepository.GetLicaByToaAndSila(liceEditModal.Raion
                                                                         , liceEditModal.PoliticheskaSila
                                                                         , userId)
                                                   .Select(p => new SelectListItem
                                                   {
                                                       Value = p.Id.ToString(),
                                                       Text = p.Imena+" ("+p.Sekciq.Trim()+")"
                                                   })
                                                   .OrderBy(s=> s.Text)
                                                   .ToList();

            liceEditModal.AllLicaFromPartia.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
            });

            liceEditModal.AllLica.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
            });

            liceEditModal.AllPoliticheskiSili.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма"
            });

            liceEditModal.AllRoli.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма"
            });

            liceEditModal.AllResheniq.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма"
            });

            return liceEditModal;
        }

        public ICollection<LiceGridViewModel> GetLicaByPage(int page, string egn, string administrativenRaion, int sik)
        {
            return _licaRepository.GetLicaByPage(page, egn, administrativenRaion, sik).Select(l => new LiceGridViewModel
            {
                Id = l.Id,
                EGN = l.EGN,
                Names = l.Names,
                Partia = l.Partia,
                Dlujnost = l.Dlujnost,
                Sik = l.Sik
            }).ToList();
        }

        public int GetMaxLicaPages(string egn, string administirativenRaion, int sik)
        {
            return _licaRepository.GetMaxLicaPages(egn, administirativenRaion, sik);
        }

        public async Task<int> TryAddLicaAsync(LicaAddViewModel addModel, string administirativenRaion)
        {
            return await _licaRepository.TryAddLicaAsync(addModel, administirativenRaion);
        }

        public async Task<int> TryEditLicaAsync(LicaEditViewModel editModel)
        {
            return await _licaRepository.TryEditLicaAsync(editModel);
        }

        public async Task<ImportResultLicaViewModel> ImportLicaAsync(List<LicaImportViewModel> allLica, string administirativenRaion, string excelFile)
        {
            var result = await _licaRepository.ImportLicaAsync(allLica, administirativenRaion, excelFile);

            return new ImportResultLicaViewModel
            {
                ImportMessage = result.ImportMessage,
                HasWrongRecords = result.HasWrongRecords
            };
        }

        public int DeleteLice(int liceId, string user, string toa)
        {
            return _licaRepository.DeleteLice(liceId, user, toa);
        }

        public int GetLicaFromIzobryCount(string administrativenRaion)
        {
            return _licaRepository.GetLicaFromIzobryCount(administrativenRaion);
        }

        public void NachislqvaneForLiceByIndex(string userId, string administrativenRajon, int liceIndex)
        {
            _licaRepository.NachislqvaneForLiceByIndex(userId, administrativenRajon, liceIndex);
        }

        public string GetFileForNap(int napFileOptionm, string userId, string administrativenRajon, int izborTur)
        {
            return _licaRepository.GetFileForNap(napFileOptionm, userId, administrativenRajon, izborTur);
        }

        public LicaDeinostiComposite GetLicaDeinostiViewModel(string administrativenRaion, string sikId)
        {
            var lica = _licaRepository.GetLicaBySik(administrativenRaion, sikId).Select(l => new LicaMassUpdateViewModel
            {
                Id = l.Id,
                Dlujnost = l.Dlujnost,
                Sekciq = l.Sekciq,
                Imena = l.Imena,
                PoliticheskaSila = l.PoliticheskaSila,
                Deinosti = l.Deinosti
            }).ToList();

            var allDeinosti = _codePositionsRepository.GetAllCodePositionsByPkode(3).Select(p => new SelectListItem
            {
                Value = p.Nkode.ToString(),
                Text = p.Nime
            }).OrderBy(c => c.Value)
            .ToList();

            /*
                        allDeinosti.Insert(0,new SelectListItem
                        {
                            Value = "0",
                            Text = "Изчистване на дейности"
                        });
            */
            var x = new LicaDeinostiComposite
            {
                TableModel = new LicaMassUpdateComposite
                {
                    AllLica = lica,
                    SelectedDeinostiMassUpdateValue = 0
                },
                AllDeinosti = allDeinosti,
                AllSik = _sikRepository.GetSiksByAdministrativenRaion(administrativenRaion).Select(p => new SelectListItem
                {
                    Value = p.Id,
                    Text = p.Id + " | " + p.Address
                })
                .OrderBy(z => z.Value)
                .ToList(),
            };

            return x;
        }

        public LicaResheniqComposite GetLicaResheniqViewModel(string administrativenRaion, string sikId)
        {
            var lica = _licaRepository.GetLicaBySik(administrativenRaion, sikId).Select(l => new LicaMassUpdateViewModel
            {
                Id = l.Id,
                Dlujnost = l.Dlujnost,
                Sekciq = l.Sekciq,
                Imena = l.Imena,
                PoliticheskaSila = l.PoliticheskaSila,
                Reshenie = l.Reshenie
            }).ToList();

            var allResheniq = _spravkiRepository.GetAllNomeklatureBasicDetails(NomenklatureIds.Dokumenti, administrativenRaion).Select(d => new SelectListItem
            {
                Value = d.Code,
                Text = d.Name
            }).ToList();

            allResheniq.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Изчистване на решения"
            });

            return new LicaResheniqComposite
            {
                TableModel = new LicaMassUpdateComposite
                {
                    AllLica = lica,
                    SelectedResheniqMassUpdateValue = "0"
                },
                AllResheniq = allResheniq,
                AllSik = _sikRepository.GetSiksByAdministrativenRaion(administrativenRaion).Select(p => new SelectListItem
                {
                    Value = p.Id,
                    Text = p.Id + " | " + p.Address
                })
                .OrderBy(x=>x.Value)
                .ToList(),
            };
        }

        public ICollection<LicaMassUpdateViewModel> GetLicaBySikAndToa(string administrativenRaion, string sikId)
        {
            return _licaRepository.GetLicaBySik(administrativenRaion, sikId).Select(l => new LicaMassUpdateViewModel
            {
                Id = l.Id,
                Dlujnost = l.Dlujnost,
                Sekciq = l.Sekciq,
                Imena = l.Imena,
                PoliticheskaSila = l.PoliticheskaSila,
                Deinosti = l.Deinosti,
                Reshenie = l.Reshenie
            }).ToList();
        }

        public void MassUpdateLicaDeinost(LicaMassUpdateDeinostiModel model, string userId)
        {
            _licaRepository.MassUpdateLicaDeinost(model, userId);
        }

        public void MassUpdateLicaReshenie(LicaMassUpdateResheniqModel model, string userId)
        {
            _licaRepository.MassUpdateLicaReshenie(model, userId);
        }

        public List<LicaForImportGridViewModel> GetWrongImportLicaForUser(string userId)
        {
            return _licaRepository.GetWrongImportLicaForUser(userId).Select(l => new LicaForImportGridViewModel
            {
                Egn = l.Egn,
                Ime1 = l.Ime1,
                Ime2 = l.Ime2,
                Ime3 = l.Ime3,
                Obrazovanie = l.Obrazovanie,
                SikNomer = l.SikNomer,
                Dlujnost = l.Dlujnost,
                Specialnost = l.Specialnost,
                Telephone = l.Telephone,
                Opisanie = l.Opisanie,
                status = l.Status
            }).ToList();
        }

        public ICollection<LiceGridViewModel> GetLicaByFilter(LicaFilterViewModel model, string userId, int tip)
        {
            return _licaRepository.GetLicaByFilter(model, userId, tip).Select(l => new LiceGridViewModel
            {
                Id = l.Id,
                EGN = l.EGN,
                Names = l.Names,
                Partia = l.Partia,
                Dlujnost = l.Dlujnost,
                Sik = l.Sik,
                Deistvie = l.Deistvie,
                Reshenie = l.Reshenie,
                Telefon = l.Telefon,
                Tur = l.Tur
            }).ToList();
        }

        public ICollection<LicaForSpravka211ViewModel> GetLicaForSlujebnaSpravka211(SikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            return _licaRepository.GetLicaForSlujebnaSpravka211(filter, administrativenRaion, userId).Select(l => new LicaForSpravka211ViewModel
            {
                NmRajon = l.NmRajon,
                NmIzbRajon = l.NmIzbRajon,
                SikFullCode = l.SikFullCode,
                Rolia = l.Rolia,
                Imena = l.Imena,
                Egn = l.Egn,
                Sila = l.Sila,
                Telephone = l.Telephone,
                Reshenie = l.Reshenie,
                Obrazovanie = l.Obrazovanie,
                Specialnost = l.Specialnost,
                SikAddress = l.SikAddress,
                descript = l.descript
            }).ToList();
        }

        public ICollection<LicaForVedomostSpravkaViewModel> GetLicaForVedomostSpravka(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            return _licaRepository.GetLicaForVedomostSpravka(filter, administrativenRaion, userId).Select(l => new LicaForVedomostSpravkaViewModel
            {
                Number = l.Number,
                SikCode = l.SikCode,
                Imena = l.Imena,
                Suma = l.Suma,
                Rolia = l.Rolia,
                NmIzbRajon = l.NmIzbRajon,
                NmRajon = l.NmRajon,
                EGN = l.Egn,
                SikFullCode = l.SikFullCode
            }).ToList();
        }

        public ICollection<LicaForSpravka32ViewModel> GetLicaForSpravka32(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            return _licaRepository.GetLicaForSpravka32(filter, administrativenRaion, userId).Select(l => new LicaForSpravka32ViewModel
            {
                Orders = l.Orders,
                BirthYear= l.BirthYear,
                T = l.T,
                IzbName = l.IzbName,
                IzbTur = l.IzbTur,
                IzbDate1 = l.IzbDate1,
                IzbDate2 = l.IzbDate2,
                NmIzbRajon = l.NmIzbRajon,
                NmRajon = l.NmRajon,
                Col1 = l.Col1,
                Col2 = l.Col2,
                Col3 = l.Col3,
                Col4 = l.Col4,
                Col5 = l.Col5,
                Col6 = l.Col6,
                S01 = l.S01,
                S02 = l.S02,
                S03 = l.S03,
                S04 = l.S04,
                S05 = l.S05,
                S06 = l.S06,
                S07 = l.S07,
                S08 = l.S08,
                S09 = l.S09,
                S10 = l.S10,
                S = l.S,
                filter = l.filter
            }).ToList(); 
        }

        public ICollection<LicaForSpravka211ViewModel> GetLicaForPublichnaSpravka211(IzbRaionWithSikFilter filter, string userId)
        {
            return _licaRepository.GetLicaForPublichnaSpravka211(filter, userId).Select(l => new LicaForSpravka211ViewModel
            {
                NmRajon = l.NmRajon,
                NmIzbRajon = l.NmIzbRajon,
                SikFullCode = l.SikFullCode,
                Rolia = l.Rolia,
                Imena = l.Imena,
                Egn = l.Egn,
                Sila = l.Sila,
                Telephone = l.Telephone,
                Reshenie = l.Reshenie,
                Obrazovanie = l.Obrazovanie,
                Specialnost = l.Specialnost
            }).ToList();
        }

        public byte[] GetFileForInvalidImport(string userId)
        {

            String izbori = _izboriRepository.GetIzborDescription();

            var lica = _licaRepository.GetWrongImportLicaForUser(userId).Select(l => new LicaForImportGridViewModel
            {
                Egn = l.Egn,
                Ime1 = l.Ime1,
                Ime2 = l.Ime2,
                Ime3 = l.Ime3,
                Obrazovanie = l.Obrazovanie,
                SikNomer = l.SikNomer,
                Dlujnost = l.Dlujnost,
                Specialnost = l.Specialnost,
                Telephone = l.Telephone,
                Opisanie = l.Opisanie,
                status = l.Status
            }).ToList();


            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";
            var guidString = Guid.NewGuid();
            var sFileName = @"Списък_Некоректни_Лица_(" + guidString + ").xlsx";

            var file = new FileInfo(Path.Combine(sWebRootFolder, sFileName));

            using (ExcelPackage package = new ExcelPackage(file))
            {
                // add a new worksheet to the empty workbook
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Списък Лица");

                worksheet.Cells[1, 1, 1, 11].Merge = true;
                worksheet.Cells[1, 1, 1, 11].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[1, 1].Value = "Списък Лица";

                worksheet.Cells[2, 1, 2, 11].Merge = true;
                worksheet.Cells[2, 1, 2, 11].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[2, 1].Value = izbori.Trim();

                //First add the headers
                worksheet.Cells[3, 1].Value = "ЕГН";
                worksheet.Cells[3, 2].Value = "Име";
                worksheet.Cells[3, 3].Value = "Презиме";
                worksheet.Cells[3, 4].Value = "Фамилия";
                worksheet.Cells[3, 5].Value = "№ на СИК";
                worksheet.Cells[3, 6].Value = "Длъжност";
                worksheet.Cells[3, 7].Value = "Образование";
                worksheet.Cells[3, 8].Value = "Специалност";
                worksheet.Cells[3, 9].Value = "Телефон";
                worksheet.Cells[3, 10].Value = "Описание";
                worksheet.Cells[3, 11].Value = "Вид";


                //Add values
                for (var i = 0; i < lica.Count; i++)
                {
                    var colOffset = i + 4;

                    worksheet.Cells["A" + colOffset].Value = lica[i].Egn;
                    worksheet.Cells["B" + colOffset].Value = lica[i].Ime1;
                    worksheet.Cells["C" + colOffset].Value = lica[i].Ime2;
                    worksheet.Cells["D" + colOffset].Value = lica[i].Ime3;
                    worksheet.Cells["E" + colOffset].Value = lica[i].SikNomer;
                    worksheet.Cells["F" + colOffset].Value = lica[i].Dlujnost;
                    worksheet.Cells["G" + colOffset].Value = lica[i].Obrazovanie;
                    worksheet.Cells["H" + colOffset].Value = lica[i].Specialnost;
                    worksheet.Cells["I" + colOffset].Value = lica[i].Telephone;
                    worksheet.Cells["J" + colOffset].Value = lica[i].Opisanie;

                    if (lica[i].status == 2)
                    {
                        worksheet.Cells["K" + colOffset].Value = "Невалиден";
                    }
                    else
                    {
                        worksheet.Cells["K" + colOffset].Value = "Отхвърлен";
                    }
                }

                using (var range = worksheet.Cells[worksheet.Dimension.Address])  //Address "A1:A5"
                {
                    range.Style.Font.Color.SetColor(Color.Black);
                }

                worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                return package.GetAsByteArray();
            }
        }

        public string GenerateSpisukLicaExcelExport212(SikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            var lica = _licaRepository.GetLicaForSlujebnaSpravka211(
                        filter
                        , administrativenRaion
                        , userId)
                .ToList();

            String izbori = _izboriRepository.GetIzborDescription();

            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";
            var guidString = Guid.NewGuid();
            var sFileName = @"Регистър_Лица_(" + guidString + ").xlsx";
            var file = new FileInfo(Path.Combine(sWebRootFolder, sFileName));

            using (ExcelPackage package = new ExcelPackage(file))
            {
                // add a new worksheet to the empty workbook
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Регистър Лица");

                worksheet.Cells[1, 1, 1, 8].Merge = true;
                worksheet.Cells[1, 1, 1, 8].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[1, 1].Value = "Регистър Лица";

                worksheet.Cells[2, 1, 2, 8].Merge = true;
                worksheet.Cells[2, 1, 2, 8].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[2, 1].Value = izbori.Trim();

                //First add the headers
                worksheet.Cells[3, 1].Value = "№";
                worksheet.Cells[3, 2].Value = "Секция";
                worksheet.Cells[3, 3].Value = "Длъжност в СИК";
                worksheet.Cells[3, 4].Value = "Име, Презиме, Фамилия";
                worksheet.Cells[3, 5].Value = "ЕГН";
                worksheet.Cells[3, 6].Value = "Образование";
                worksheet.Cells[3, 7].Value = "Политическа сила";
                worksheet.Cells[3, 8].Value = "Телефон";

                //Add values
                for (var i = 0; i < lica.Count; i++)
                {
                    var colOffset = i + 4;

                    worksheet.Cells["A" + colOffset].Value = i + 1;
                    worksheet.Cells["B" + colOffset].Value = lica[i].SikFullCode;
                    worksheet.Cells["C" + colOffset].Value = lica[i].Rolia;
                    worksheet.Cells["D" + colOffset].Value = lica[i].Imena;
                    worksheet.Cells["E" + colOffset].Value = lica[i].Egn;
                    worksheet.Cells["F" + colOffset].Value = lica[i].Obrazovanie;
                    worksheet.Cells["G" + colOffset].Value = lica[i].Sila;
                    worksheet.Cells["H" + colOffset].Value = lica[i].Telephone;
                }

                using (var range = worksheet.Cells[worksheet.Dimension.Address])  //Address "A1:A5"
                {
                    range.Style.Font.Color.SetColor(Color.Black);
                }

                worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                package.Save(); //Save the workbook.
            }

            return sFileName;
        }

        public ICollection<LicaMassUpdateViewModel> GetLicaBySikToaAndSila(string toa, string sik, int silaId)
        {
            return _licaRepository.GetLicaBySikToaAndSila(toa, sik, silaId).Select(l => new LicaMassUpdateViewModel
            {
                Id = l.Id,
                Dlujnost = l.Dlujnost,
                Sekciq = l.Sekciq,
                Imena = l.Imena,
                PoliticheskaSila = l.PoliticheskaSila,
                Deinosti = l.Deinosti,
                Reshenie = l.Reshenie
            }).ToList();
        }

        public ICollection<LicaForSpravka212ViewModel> GetSystavRezervi(SikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            return _licaRepository.GetSystavRezervi(filter, administrativenRaion, userId).Select(l => new LicaForSpravka212ViewModel
            {
                NmRajon = l.NmRajon,
                SikFullCode = l.SikFullCode,
                Rolia = l.Rolia,
                Imena = l.Imena,
                Egn = l.Egn,
                Sila = l.Sila,
                Telephone = l.Telephone
            }).ToList();
        }

        public string GenerateSpisukLicaExcelExport213(SikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            var lica = _licaRepository.GetSystavRezervi(
                        filter
                        , administrativenRaion
                        , userId)
                .ToList();

            String izbori = _izboriRepository.GetIzborDescription();

            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";
            var guidString = Guid.NewGuid();
            var sFileName = @"Списък_резерви_(" + guidString + ").xlsx";
            var file = new FileInfo(Path.Combine(sWebRootFolder, sFileName));

            using (ExcelPackage package = new ExcelPackage(file))
            {
                // add a new worksheet to the empty workbook
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Списък резерви");

                worksheet.Cells[1, 1, 1, 7].Merge = true;
                worksheet.Cells[1, 1, 1, 7].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[1, 1].Value = "Списък резерви";

                worksheet.Cells[2, 1, 2, 7].Merge = true;
                worksheet.Cells[2, 1, 2, 7].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[2, 1].Value = izbori.Trim();

                //First add the headers
                worksheet.Cells[3, 1].Value = "№";
                worksheet.Cells[3, 2].Value = "Секция";
                worksheet.Cells[3, 3].Value = "ЕГН";
                worksheet.Cells[3, 4].Value = "Име, Презиме, Фамилия";
                worksheet.Cells[3, 5].Value = "Длъжност в СИК";
                worksheet.Cells[3, 6].Value = "Политическа сила";
                worksheet.Cells[3, 7].Value = "Телефон";

                //Add values
                for (var i = 0; i < lica.Count; i++)
                {
                    var colOffset = i + 4;

                    worksheet.Cells["A" + colOffset].Value = i + 1;
                    worksheet.Cells["B" + colOffset].Value = lica[i].SikFullCode;
                    worksheet.Cells["C" + colOffset].Value = lica[i].Egn;
                    worksheet.Cells["D" + colOffset].Value = lica[i].Imena;
                    worksheet.Cells["E" + colOffset].Value = lica[i].Rolia;
                    worksheet.Cells["F" + colOffset].Value = lica[i].Sila;
                    worksheet.Cells["G" + colOffset].Value = lica[i].Telephone;
                }

                using (var range = worksheet.Cells[worksheet.Dimension.Address])  //Address "A1:A5"
                {
                    range.Style.Font.Color.SetColor(Color.Black);
                }

                worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                package.Save(); //Save the workbook.
            }

            return sFileName;
        }


        public string GenerateSpisukLicaExcelExport311(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("bg-BG");

            String izbori = _izboriRepository.GetIzborDescriptionWithoutTur();
            String izboridate = _izboriRepository.GetIzborDate().ToShortDateString();
            if (filter.SelectedTurs == 2)
                izboridate = _izboriRepository.GetIzborEndDate().ToShortDateString();

            String izbrTur = "Тур " + filter.SelectedTurs;

            var lica = _licaRepository.GetLicaForVedomostSpravka(
                        filter
                        , administrativenRaion
                        , userId)
                .OrderBy(s=>s.Imena)
                .ToList();


            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";
            var guidString = Guid.NewGuid();
            var sFileName = @"Ведомост_за_банка_(" + guidString + ").xlsx";
            var file = new FileInfo(Path.Combine(sWebRootFolder, sFileName));

            using (ExcelPackage package = new ExcelPackage(file))
            {
                // add a new worksheet to the empty workbook
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Списък-Ведомост");

                worksheet.Cells["A1:B1"].Merge = true;
                worksheet.Cells["A2:B2"].Merge = true;
                worksheet.Cells["A3:B3"].Merge = true;
                worksheet.Cells["A4:B4"].Merge = true;
                worksheet.Cells["A5:B5"].Merge = true;
                worksheet.Cells["A6:B6"].Merge = true;
                worksheet.Cells["A7:B7"].Merge = true;
                worksheet.Cells["A8:B8"].Merge = true;

                worksheet.Cells[10, 1, 10, 4].Merge = true;
                worksheet.Cells[10, 1, 10, 4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[10, 1, 10, 4].Style.Font.Bold = true;
                worksheet.Cells[10, 1, 10, 4].Style.Font.Size = 16;

                worksheet.Cells[11, 1, 11, 4].Merge = true;
                worksheet.Cells[11, 1, 11, 4].Style.Font.Bold = false;
                worksheet.Cells[11, 1, 11, 4].Style.Font.Size = 11;
                worksheet.Cells[11, 1, 11, 4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                worksheet.Cells[1, 1].Value = "СТОЛИЧНА";
                worksheet.Cells[2, 1].Value = "Община";
                worksheet.Cells[4, 1].Value = lica[0].NmRajon;
                worksheet.Cells[5, 1].Value = "Административен район";
                worksheet.Cells[7, 1].Value = lica[0].NmIzbRajon;
                worksheet.Cells[8, 1].Value = "Изборен район";

                worksheet.Cells[10, 1].Value = "СПИСЪК";
                worksheet.Cells[11, 1].Value = "на членовете на секционни избирателни комисии, участвали в "
                                               + izbori.Trim() + ", " + izbrTur + " на " + izboridate; ;

                //First add the headers
                worksheet.Cells[13, 1].Value = "№";
                worksheet.Cells[13, 2].Value = "Име, Презиме, Фамилия";
                worksheet.Cells[13, 3].Value = "ЕГН";
                worksheet.Cells[13, 4].Value = "Сума за получаване в евро";
                worksheet.Cells[13, 1, 13, 4].Style.Font.Bold = true;

                decimal suma = 0;

                //Add values
                for (var i = 0; i < lica.Count; i++)
                {
                    var colOffset = i + 14;

                    worksheet.Cells["A" + colOffset].Value = i + 1;
                    worksheet.Cells["B" + colOffset].Value = lica[i].Imena;
                    worksheet.Cells["C" + colOffset].Value = lica[i].Egn;

                    worksheet.Cells["D" + colOffset].Style.Numberformat.Format = "0.00";
                    worksheet.Cells["D" + colOffset].Value = lica[i].Suma;

                    suma += lica[i].Suma;
                }

                worksheet.Cells[lica.Count + 14, 3].Value = "Общо";

                worksheet.Cells[lica.Count + 14, 4].Style.Numberformat.Format = "0.00";
                worksheet.Cells[lica.Count + 14, 4].Value = suma;

                worksheet.Cells[lica.Count + 16, 1].Value = "Кмет на район:";
                worksheet.Cells[lica.Count + 18, 1].Value = "Гл.счетоводител:";

                var modelRows = lica.Count + 14;
                string modelRange = "A13:D" + modelRows.ToString();
                var modelTable = worksheet.Cells[modelRange];

                // Assign borders
                modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                using (var range = worksheet.Cells[worksheet.Dimension.Address])  //Address "A1:A5"
                {
                    range.Style.Font.Color.SetColor(Color.Black);
                }

                worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                package.Save(); //Save the workbook.
            }

            return sFileName;
        }

        public string GenerateSpisukLicaExcelExport312(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("bg-BG");

            String izbori = _izboriRepository.GetIzborDescriptionWithoutTur();

            String izboridate = _izboriRepository.GetIzborDate().ToShortDateString();
            if (filter.SelectedTurs==2)
                izboridate = _izboriRepository.GetIzborEndDate().ToShortDateString();

            String izbrTur = "Тур " + filter.SelectedTurs;


            var lica = _licaRepository.GetLicaForVedomostSpravka(
                        filter
                        , administrativenRaion
                        , userId)
                .ToList();


            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";
            var guidString = Guid.NewGuid();
            var sFileName = @"Ведомост_(" + guidString + ").xlsx";
            var file = new FileInfo(Path.Combine(sWebRootFolder, sFileName));

            using (ExcelPackage package = new ExcelPackage(file))
            {
                // add a new worksheet to the empty workbook
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Списък-Ведомост");

                worksheet.Cells["A1:B1"].Merge = true;
                worksheet.Cells["A2:B2"].Merge = true;
                worksheet.Cells["A3:B3"].Merge = true;
                worksheet.Cells["A4:B4"].Merge = true;
                worksheet.Cells["A5:B5"].Merge = true;
                worksheet.Cells["A6:B6"].Merge = true;
                worksheet.Cells["A7:B7"].Merge = true;
                worksheet.Cells["A8:B8"].Merge = true;

                worksheet.Cells[10, 1, 10, 6].Merge = true;
                worksheet.Cells[10, 1, 10, 6].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[10, 1, 10, 6].Style.Font.Bold = true;
                worksheet.Cells[10, 1, 10, 6].Style.Font.Size = 16;

                worksheet.Cells[11, 1, 11, 6].Merge = true;
                worksheet.Cells[11, 1, 11, 6].Style.Font.Bold = false;
                worksheet.Cells[11, 1, 11, 6].Style.Font.Size = 11;
                worksheet.Cells[11, 1, 11, 6].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                worksheet.Cells[1, 1].Value = "СТОЛИЧНА";
                worksheet.Cells[2, 1].Value = "Община";
                worksheet.Cells[4, 1].Value = lica[0].NmRajon;
                worksheet.Cells[5, 1].Value = "Административен район";
                worksheet.Cells[7, 1].Value = lica[0].NmIzbRajon;
                worksheet.Cells[8, 1].Value = "Изборен район";

                worksheet.Cells[10, 1].Value = "СПИСЪК-ВЕДОМОСТ";
                worksheet.Cells[11, 1].Value = "на членовете на секционни избирателни комисии, участвали в " 
                                               + izbori.Trim() + ", "+ izbrTur+" на " + izboridate; ;
                
                //First add the headers
                worksheet.Cells[13, 1].Value = "№";
                worksheet.Cells[13, 2].Value = "СИК";
                worksheet.Cells[13, 3].Value = "Дейност";
                worksheet.Cells[13, 4].Value = "Име, Презиме, Фамилия";
                worksheet.Cells[13, 5].Value = "ЕГН";
                worksheet.Cells[13, 6].Value = "Сума за получаване в евро";
                worksheet.Cells[13, 1, 13, 6].Style.Font.Bold = true;

                decimal suma = 0;

                //Add values
                for (var i = 0; i < lica.Count; i++)
                {
                    var colOffset = i + 14;

                    worksheet.Cells["A" + colOffset].Value = i + 1;
                    worksheet.Cells["B" + colOffset].Value = lica[i].SikFullCode;
                    worksheet.Cells["C" + colOffset].Value = lica[i].Rolia;
                    worksheet.Cells["D" + colOffset].Value = lica[i].Imena;
                    worksheet.Cells["E" + colOffset].Value = lica[i].Egn;

                    worksheet.Cells["F" + colOffset].Style.Numberformat.Format = "0.00";
                    worksheet.Cells["F" + colOffset].Value = lica[i].Suma;

                    suma += lica[i].Suma;
                }

                worksheet.Cells[lica.Count + 14, 5].Value = "Общо";
                worksheet.Cells[lica.Count + 14, 6].Style.Numberformat.Format = "0.00";
                worksheet.Cells[lica.Count + 14, 6].Value = suma;

                worksheet.Cells[lica.Count + 16, 1].Value = "Кмет на район:";
                worksheet.Cells[lica.Count + 18, 1].Value = "Гл.счетоводител:";

                var modelRows = lica.Count + 14;
                string modelRange = "A13:F" + modelRows.ToString();
                var modelTable = worksheet.Cells[modelRange];

                // Assign borders
                modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                using (var range = worksheet.Cells[worksheet.Dimension.Address])  //Address "A1:A5"
                {
                    range.Style.Font.Color.SetColor(Color.Black);
                }

                worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                package.Save(); //Save the workbook.
            }

            return sFileName;
        }

        public int GetZamestvanRolia (int id, string administrativenRaion) {
            return _licaRepository.GetZamestvanRolia(id, administrativenRaion);
        }


        public string GenerateSpravkaExcelExport32(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("bg-BG");

            String izbori = _izboriRepository.GetIzborDescriptionWithoutTur();

            String IzbDate1 = _izboriRepository.GetTurBeginDate(filter.SelectedTurs);
            String IzbDate2 = _izboriRepository.GetTurEndDate(filter.SelectedTurs);
            String izbrTur = "Тур " + filter.SelectedTurs;


            var lica = _licaRepository.GetLicaForSpravka32(
                        filter
                        , administrativenRaion
                        , userId)
                .ToList();


            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";
            var guidString = Guid.NewGuid();
            var sFileName = @"Рекапитулация_(" + guidString + ").xlsx";
            var file = new FileInfo(Path.Combine(sWebRootFolder, sFileName));

            using (ExcelPackage package = new ExcelPackage(file))
            {
                // add a new worksheet to the empty workbook
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Рекапитулация");

                int clncnt = 7;

                if (!String.IsNullOrEmpty(lica[0].S01))
                {
                    clncnt++;
                }
                if (!String.IsNullOrEmpty(lica[0].S02))
                {
                    clncnt++;
                }
                if (!String.IsNullOrEmpty(lica[0].S03))
                {
                    clncnt++;
                }
                if (!String.IsNullOrEmpty(lica[0].S04))
                {
                    clncnt++;
                }
                if (!String.IsNullOrEmpty(lica[0].S05))
                {
                    clncnt++;
                }
                if (!String.IsNullOrEmpty(lica[0].S06))
                {
                    clncnt++;
                }
                if (!String.IsNullOrEmpty(lica[0].S07))
                {
                    clncnt++;
                }
                if (!String.IsNullOrEmpty(lica[0].S08))
                {
                    clncnt++;
                }
                if (!String.IsNullOrEmpty(lica[0].S09))
                {
                    clncnt++;
                }
                if (!String.IsNullOrEmpty(lica[0].S10))
                {
                    clncnt++;
                }

                worksheet.Cells["A1:C1"].Merge = true;
                worksheet.Cells["A2:C2"].Merge = true;
                worksheet.Cells["A3:C3"].Merge = true;
                worksheet.Cells["A4:C4"].Merge = true;
                worksheet.Cells["A5:C5"].Merge = true;
                worksheet.Cells["A6:C6"].Merge = true;
                worksheet.Cells["A7:C7"].Merge = true;
                worksheet.Cells["A8:C8"].Merge = true;

                worksheet.Cells[10, 1, 10, clncnt].Merge = true;
                worksheet.Cells[10, 1, 10, clncnt].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[10, 1, 10, clncnt].Style.Font.Bold = true;
                worksheet.Cells[10, 1, 10, clncnt].Style.Font.Size = 16;

                worksheet.Cells[11, 1, 11, clncnt].Merge = true;
                worksheet.Cells[11, 1, 11, clncnt].Style.Font.Bold = false;
                worksheet.Cells[11, 1, 11, clncnt].Style.Font.Size = 11;
                worksheet.Cells[11, 1, 11, clncnt].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                worksheet.Cells[12, 1, 12, clncnt].Merge = true;
                worksheet.Cells[12, 1, 12, clncnt].Style.Font.Bold = false;
                worksheet.Cells[12, 1, 12, clncnt].Style.Font.Size = 11;
                worksheet.Cells[12, 1, 12, clncnt].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;


                worksheet.Cells[1, 1].Value = "СТОЛИЧНА";
                worksheet.Cells[2, 1].Value = "Община";
                worksheet.Cells[4, 1].Value = lica[0].NmRajon;
                worksheet.Cells[5, 1].Value = "Административен район";
                worksheet.Cells[7, 1].Value = lica[0].NmIzbRajon;
                worksheet.Cells[8, 1].Value = "Изборен район";

                worksheet.Cells[10, 1].Value = "ФИНАНСОВА РЕКАПИТУЛАЦИЯ";
                worksheet.Cells[11, 1].Value = "за периода от " + IzbDate1 + "-" + IzbDate2;
                worksheet.Cells[12, 1].Value = izbori.Trim() + ", " + izbrTur;

                //First add the headers
                worksheet.Cells[14, 1].Value = lica[0].Col1;
                worksheet.Cells[14, 2].Value = lica[0].Col2;
                worksheet.Cells[14, 3].Value = lica[0].Col3;
                worksheet.Cells[14, 4].Value = lica[0].Col4;
                worksheet.Cells[14, 5].Value = lica[0].Col5;
                worksheet.Cells[14, 6].Value = lica[0].Col6;

                clncnt = 6;

                if(!String.IsNullOrEmpty(lica[0].S01))
                {
                    clncnt++;
                    worksheet.Cells[14, clncnt].Value = lica[0].S01;
                }
                if(!String.IsNullOrEmpty(lica[0].S02))
                {
                    clncnt++;
                    worksheet.Cells[14, clncnt].Value = lica[0].S02;
                }
                if(!String.IsNullOrEmpty(lica[0].S03)) 
                {
                    clncnt++;
                    worksheet.Cells[14, clncnt].Value = lica[0].S03;
                }
                if(!String.IsNullOrEmpty(lica[0].S04))
                {
                    clncnt++;
                    worksheet.Cells[14, clncnt].Value = lica[0].S04;
                }
                if(!String.IsNullOrEmpty(lica[0].S05))
                {
                    clncnt++;
                    worksheet.Cells[14, clncnt].Value = lica[0].S05;
                }
                if(!String.IsNullOrEmpty(lica[0].S06))
                {
                    clncnt++;
                    worksheet.Cells[14, clncnt].Value = lica[0].S06;
                }
                if(!String.IsNullOrEmpty(lica[0].S07))
                {
                    clncnt++;
                    worksheet.Cells[14, clncnt].Value = lica[0].S07;
                }
                if(!String.IsNullOrEmpty(lica[0].S08))
                {
                    clncnt++;
                    worksheet.Cells[14, clncnt].Value = lica[0].S08;
                }
                if(!String.IsNullOrEmpty(lica[0].S09))
                {
                    clncnt++;
                    worksheet.Cells[14, clncnt].Value = lica[0].S09;
                }
                if(!String.IsNullOrEmpty(lica[0].S10))
                {
                    clncnt++;
                    worksheet.Cells[14, clncnt].Value = lica[0].S10;
                }
                clncnt++;
                worksheet.Cells[14, clncnt].Value = lica[0].S;
                worksheet.Cells[14, 1, 14, clncnt].Style.Font.Bold = true;


                //Add values
                for (var i = 1; i < lica.Count; i++)
                {
                    var rowOffset = i + 15;

                    worksheet.Cells[rowOffset, 1].Value = (lica[i].Orders == 2 ? "" : i.ToString());
                    worksheet.Cells[rowOffset, 2].Value = lica[i].Col2;
                    worksheet.Cells[rowOffset, 3].Value = lica[i].Col3;
                    worksheet.Cells[rowOffset, 4].Value = lica[i].Col4;

                    worksheet.Cells[rowOffset, 5].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right ;
                    worksheet.Cells[rowOffset, 5].Style.Numberformat.Format = "0.00";
                    worksheet.Cells[rowOffset, 5].Value = lica[i].Col5;

                    worksheet.Cells[rowOffset, 6].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                    worksheet.Cells[rowOffset, 6].Style.Numberformat.Format = "0.00";
                    worksheet.Cells[rowOffset, 6].Value = lica[i].Col6;

                    int colOffset = 6;

                    if (!String.IsNullOrEmpty(lica[0].S01))
                    {
                        colOffset++;
                        worksheet.Cells[rowOffset, colOffset].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                        worksheet.Cells[rowOffset, colOffset].Style.Numberformat.Format = "0.00";
                        worksheet.Cells[rowOffset, colOffset].Value = lica[i].S01;
                    }
                    if (!String.IsNullOrEmpty(lica[0].S02))
                    {
                        colOffset++;
                        worksheet.Cells[rowOffset, colOffset].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                        worksheet.Cells[rowOffset, colOffset].Style.Numberformat.Format = "0.00";
                        worksheet.Cells[rowOffset, colOffset].Value = lica[i].S02;
                    }
                    if (!String.IsNullOrEmpty(lica[0].S03))
                    {
                        colOffset++;
                        worksheet.Cells[rowOffset, colOffset].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                        worksheet.Cells[rowOffset, colOffset].Style.Numberformat.Format = "0.00";
                        worksheet.Cells[rowOffset, colOffset].Value = lica[i].S03;
                    }
                    if (!String.IsNullOrEmpty(lica[0].S04))
                    {
                        colOffset++;
                        worksheet.Cells[rowOffset, colOffset].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                        worksheet.Cells[rowOffset, colOffset].Style.Numberformat.Format = "0.00";
                        worksheet.Cells[rowOffset, colOffset].Value = lica[i].S04;
                    }
                    if (!String.IsNullOrEmpty(lica[0].S05))
                    {
                        colOffset++;
                        worksheet.Cells[rowOffset, colOffset].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                        worksheet.Cells[rowOffset, colOffset].Style.Numberformat.Format = "0.00";
                        worksheet.Cells[rowOffset, colOffset].Value = lica[i].S05;
                    }
                    if (!String.IsNullOrEmpty(lica[0].S06))
                    {
                        colOffset++;
                        worksheet.Cells[rowOffset, colOffset].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                        worksheet.Cells[rowOffset, colOffset].Style.Numberformat.Format = "0.00";
                        worksheet.Cells[rowOffset, colOffset].Value = lica[i].S06;
                    }
                    if (!String.IsNullOrEmpty(lica[0].S07))
                    {
                        colOffset++;
                        worksheet.Cells[rowOffset, colOffset].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                        worksheet.Cells[rowOffset, colOffset].Style.Numberformat.Format = "0.00";
                        worksheet.Cells[rowOffset, colOffset].Value = lica[i].S07;
                    }
                    if (!String.IsNullOrEmpty(lica[0].S08))
                    {
                        colOffset++;
                        worksheet.Cells[rowOffset, colOffset].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                        worksheet.Cells[rowOffset, colOffset].Style.Numberformat.Format = "0.00";
                        worksheet.Cells[rowOffset, colOffset].Value = lica[i].S08;
                    }
                    if (!String.IsNullOrEmpty(lica[0].S09))
                    {
                        colOffset++;
                        worksheet.Cells[rowOffset, colOffset].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                        worksheet.Cells[rowOffset, colOffset].Style.Numberformat.Format = "0.00";
                        worksheet.Cells[rowOffset, colOffset].Value = lica[i].S09;
                    }
                    if (!String.IsNullOrEmpty(lica[0].S10))
                    {
                        colOffset++;
                        worksheet.Cells[rowOffset, colOffset].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                        worksheet.Cells[rowOffset, colOffset].Style.Numberformat.Format = "0.00";
                        worksheet.Cells[rowOffset, colOffset].Value = lica[i].S10;
                    }
                    colOffset++;
                    worksheet.Cells[rowOffset, colOffset].Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                    worksheet.Cells[rowOffset, colOffset].Style.Numberformat.Format = "0.00";
                    worksheet.Cells[rowOffset, colOffset].Value = lica[i].S;
                }

                worksheet.Cells[lica.Count + 17, 1].Value = "Кмет на район:";
                worksheet.Cells[lica.Count + 19, 1].Value = "Гл.счетоводител:";

                var modelRows = lica.Count + 13;
                char endCol = (char)(65 + (clncnt-1));                          //generirame bukvata na kolonata
                string modelRange = "A14:"+endCol + modelRows.ToString();
                var modelTable = worksheet.Cells[modelRange];

                // Assign borders
                modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                using (var range = worksheet.Cells[worksheet.Dimension.Address]) 
                {
                    range.Style.Font.Color.SetColor(Color.Black);
                }

                worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                package.Save(); //Save the workbook.
            }

            return sFileName;
        }

//v.2
        public bool CheckSikType(int idsik)
        {
            return _sikRepository.CheckSikType(idsik);
        }

        public ICollection<LicaMassUpdateViewModel> GetLicaByToaAndSila(string toa, int silaId, string userId)
        {
            return _licaRepository.GetLicaByToaAndSila(toa, silaId, userId)
                                                   .Select(l => new LicaMassUpdateViewModel
                                                   {
                                                       Id = l.Id,
                                                       Imena = l.Imena,
                                                       PoliticheskaSila = l.PoliticheskaSila,
                                                       Dlujnost = l.Dlujnost,
                                                       Sekciq = l.Sekciq,
                                                       Deinosti = new int[0],
                                                       Reshenie = l.Reshenie
                                                   })
                                               .ToList();
        }

        public bool CheckGraoNumber(string graonumber, int graotype)
        {
            return (_licaRepository.CheckGraoNumber(graonumber, graotype)> -1);
        }

    }
}
