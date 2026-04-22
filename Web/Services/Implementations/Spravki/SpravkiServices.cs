namespace Services.Implementations.Spravki
{
    using System;
    using System.Collections.Generic;
    using System.Drawing;
    using System.IO;
    using System.Linq;
    using Common.Enums.Spravki;
    using Common.ViewModels.Lica;
    using Common.ViewModels.Spravki;
    using Microsoft.AspNetCore.Hosting;
    using OfficeOpenXml;
    using OfficeOpenXml.Style;
    using Repository.Interfaces.Izbori;
    using Repository.Interfaces.Spravki;
    using Services.Interfaces.Lica;
    using Services.Interfaces.Spravki;

    public class SpravkiServices : ISpravkiServices
    {
        private readonly ISpravkiRepository _spravkiRepository;
        private readonly ILicaServices _licaServices;
        private readonly IHostingEnvironment _hostingEnvironment;
        private readonly IIzboriRepository _izboriRepository;

        public SpravkiServices(ISpravkiRepository spravkiRepository,
                                ILicaServices licaServices,
                                IHostingEnvironment hostingEnvironment,
                                IIzboriRepository izboriRepository
        )
        {
            _hostingEnvironment = hostingEnvironment;
            _licaServices = licaServices;
            _spravkiRepository = spravkiRepository;
            _izboriRepository = izboriRepository;
        }

        public ICollection<NomeklatureViewModel> GetAllNomenklatures(int tip)
        {
            return _spravkiRepository.GetAllNomenklatures(tip).Select(n => new NomeklatureViewModel
            {
                nomenklatureId = n.nomenklatureId,
                Description = n.Description
            }).ToList();
        }

        public ICollection<StatisticViewModel> GetAllStatistics(int tip)
        {
            return _spravkiRepository.GetAllStatistics(tip).Select(s => new StatisticViewModel
            {
                Id = s.Id,
                ShortDesctiption = s.ShortDesctiption,
                LongDescription = s.LongDescription
            }).ToList();
        }

        public ICollection<NomenklaturaBasicViewModel> GetNomenklatureBasicDetails(NomenklatureIds nomenklatureEnum, int page, string nameFilter, string administrativenRaion)
        {
            return _spravkiRepository.GetNomenklatureBasicDetails(nomenklatureEnum, page, nameFilter, administrativenRaion);
        }

        public NomenklatureEditFullViewModel GetNomenklatureEdit(NomenklatureIds nomenklatureEnum, string nomenklatureCode, int id)
        {
            return _spravkiRepository.GetNomenklatureEdit(nomenklatureEnum, nomenklatureCode, id);
        }

        public int GetNomenklatureMaxPages(NomenklatureIds nomenklatureEnum, string nameFilter, string administrativenRaion)
        {
            return _spravkiRepository.GetNumenklatureMaxPages(nomenklatureEnum, nameFilter, administrativenRaion);
        }

        public void NomenklatureEdit(NomenklatureEditFullViewModel editModel)
        {
            _spravkiRepository.NomenklatureEdit(editModel);
        }

        public NomenklatureEditFullViewModel GetNomenklatureAdd(NomenklatureIds nomenklatureId)
        {
            return _spravkiRepository.GetNomenklatureAdd(nomenklatureId);
        }

        public void NomenklatureAdd(NomenklatureEditFullViewModel model, string administrativenRaion)
        {
            _spravkiRepository.NomenklatureAdd(model, administrativenRaion);
        }

        public void NomenklatureDelete(NomenklatureIds nomenklatureEnum, string nomenklatureCode, int id)
        {
            _spravkiRepository.NomenklatureDelete(nomenklatureEnum, nomenklatureCode, id);
        }

        public string GetStatisticContents(GenerateReportViewModel model, string userId)
        {
            switch (model.statisticId)
            {
                case Statistics.MUDO:
                    return _spravkiRepository.GetMudoStatisticContents(model, userId);
                case Statistics.MSBD:
                    return _spravkiRepository.GetMsbdStatisticContents(model, userId);
                case Statistics.MSB:
                    return _spravkiRepository.GetMsbStatisticContents(model, userId);
                case Statistics.MORS:
                    return _spravkiRepository.GetMorsStatisticContents(model, userId);
                default:
                    return "";
            }
        }

        public ICollection<NomenklaturaBasicViewModel> GetAllNomenklatureBasicDetails(NomenklatureIds nomenklature, string administrativenRaion)
        {
            return _spravkiRepository.GetAllNomeklatureBasicDetails(nomenklature, administrativenRaion).Select(n => new NomenklaturaBasicViewModel
            {
                Code = n.Code,
                Name = n.Name
            }).ToList();
        }

        public ICollection<SpisukNaSekciiteSpravkaViewModel> GetSpisukNaSekciiteSpravka(IzbRaionWithSikFilter filter, string userId)
        {
            return _spravkiRepository.GetSpisukNaSekciiteSpravka(filter, userId).Select(s => new SpisukNaSekciiteSpravkaViewModel
            {
                Id = s.Id,
                NmIzbRajon = s.NmIzbRajon,
                NmRajon = s.NmRajon,
                SikNumb = s.SikNumb,
                Address = s.Address,
                Vid = s.Vid,
                Priznak = s.Priznak,
                Control = s.Control,
                status = s.status,
                descript = s.descript
            }).ToList();
        }

        public ICollection<BroiSekciiSpravkaViewModel> GetBroiSekciiSpravka(IzbRaionWithSikFilter filter, string userId)
        {
            return _spravkiRepository.GetBroiSekciiSpravka(filter, userId).Select(s => new BroiSekciiSpravkaViewModel
            {
                NmIzbRajon = s.NmIzbRajon,
                NmRajon = s.NmRajon,
                Total = s.Total,
                Basic = s.Basic,
                Mobail = s.Mobail,
                Official = s.Official,
                Another = s.Another
            }).ToList();
        }

        public ICollection<ZaetiPoziciiSpravkaViewModel> GetZaetiPoziciiPublichnaSpravka(IzbRaionWithSikFilter filter, string userId)
        {
            return _spravkiRepository.GetZaetiPoziciiPublichnaSpravka(filter, userId).Select(s => new ZaetiPoziciiSpravkaViewModel
            {
                Id = s.Id,
                NmIzbRajon = s.NmIzbRajon,
                NmRajon = s.NmRajon,
                WnSila = s.WnSila,
                Col1 = s.Col1,
                Col2 = s.Col2,
                Col3 = s.Col3,
                Col4 = s.Col4,
                Col5 = s.Col5,
                Col6 = s.Col6
            }).ToList();
        }

        public ICollection<ZaetiPoziciiSpravkaViewModel> GetZaetiPoziciiObjoPublichnaSpravka(IzbRaionWithSikFilter filter, string userId)
        {
            return _spravkiRepository.GetZaetiPoziciiObjoPublichnaSpravka(filter, userId).Select(s => new ZaetiPoziciiSpravkaViewModel
            {
                Id = s.Id,
                NmIzbRajon = s.NmIzbRajon,
                NmRajon = s.NmRajon,
                WnSila = s.WnSila,
                Col1 = s.Col1,
                Col2 = s.Col2,
                Col3 = s.Col3,
                Col4 = s.Col4,
                Col5 = s.Col5,
                Col6 = s.Col6
            }).ToList();
        }

        public ICollection<ReshetkaSpravkaViewModel> GetReshetkaSpravka(PartiaFilterViewModel filter, string administrativenRaion, string userId)
        {
            return _spravkiRepository.GetReshetkaSpravka(filter, administrativenRaion, userId).Select(s => new ReshetkaSpravkaViewModel {
                Id = s.Id,
                NmIzbRajon = s.NmIzbRajon,
                NmRajon = s.NmRajon,
                WnSila = s.WnSila,
                SikNumb = s.SikNumb,
                Col1 = s.Col1,
                Col2 = s.Col2,
                Col3 = s.Col3,
                Col4 = s.Col4,
                Col5 = s.Col5
            }).ToList();
        }

        public ICollection<ZamestvajiSpravkaViewModel> GetZamestvajiSpravka(SikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            return _spravkiRepository.GetZamestvajiSpravka(filter, administrativenRaion, userId).Select(s => new ZamestvajiSpravkaViewModel {
                Id = s.Id,
                NmIzbRajon = s.NmIzbRajon,
                NmRajon = s.NmRajon,
                SikFullCode = s.SikFullCode,
                ImeNovo = s.ImeNovo,
                EgnNovo = s.EgnNovo,
                ImeStaro = s.ImeStaro,
                EgnStaro = s.EgnStaro,
                Rolia = s.Rolia,
                Koga = s.Koga,
                Partia = s.Partia,
                Telefon = s.Telefon,
                Deistvie = s.Deistvie
            }).ToList();
        }

        public ICollection<SustoqnieNaRegistraciiteSpravkaViewModel> GetSustoqnieNaRegistraciiteSpravka(RoliSpravkaFilter filter, string administrativenRaion, string userId)
        {
            return _spravkiRepository.GetSustoqnieNaRegistraciiteSpravka(filter, administrativenRaion, userId).ToList().Select(s => new SustoqnieNaRegistraciiteSpravkaViewModel
            {
                Id = s.Id,
                Col1 = s.Col1,
                Col2 = s.Col2,
                Col3 = s.Col3,
                Col4 = s.Col4
            }).ToList();
        }

        public DashboardSpravkaViewModel GetDashboardSpravka(string administrativenRaion, string userId)
        {
            var dashboardDto = _spravkiRepository.GetDashboardSpravka(administrativenRaion, userId);

            return new DashboardSpravkaViewModel
            {
                Razpredeleniq = dashboardDto.Razpredeleniq.Select(s => new RazpredelenieViewModel
                {
                    N1 = s.N1,
                    N2 = s.N2,
                    N3 = s.N3,
                    N4 = s.N4,
                    N5 = s.N5,
                    N6 = s.N6,
                    N7 = s.N7,
                    C1 = s.C1,
                    C2 = s.C2,
                    C3 = s.C3,
                    C4 = s.C4,
                    C5 = s.C5,
                    C6 = s.C6,
                    C7 = s.C7
                }).ToList(),

                SustoqnieNaRegistraciite = dashboardDto.SustoqnieNaRegistraciite.Select(s => new SustoqnieNaRegistraciiteSpravkaViewModel
                {
                    Col1 = s.Col1,
                    Col2 = s.Col2,
                    Col3 = s.Col3,
                    Col4 = s.Col4
                }).ToList()
            };
        }

        public string GenerateSpisukLicaExcelExport(LicaFilterViewModel filter, string userId)
        {
            var lica = _licaServices.GetLicaByFilter(filter, userId, 0).ToList();

            String izbori = _izboriRepository.GetIzborDescriptionWithoutTur();

            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";
            var guidString = Guid.NewGuid();
            var sFileName = @"Списък_Лица_(" + guidString + ").xlsx";

            var file = new FileInfo(Path.Combine(sWebRootFolder, sFileName));

            using (ExcelPackage package = new ExcelPackage(file))
            {
                // add a new worksheet to the empty workbook
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Списък Лица");

                worksheet.Cells[1, 1, 1, 9].Merge = true;
                worksheet.Cells[1, 1, 1, 9].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[1, 1].Value = "Списък Лица";

                worksheet.Cells[2, 1, 2, 9].Merge = true;
                worksheet.Cells[2, 1, 2, 9].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[2, 1].Value = izbori.Trim();

                //First add the headers
                worksheet.Cells[3, 1].Value = "Тур";
                worksheet.Cells[3, 2].Value = "ЕГН";
                worksheet.Cells[3, 3].Value = "Имена";
                worksheet.Cells[3, 4].Value = "СИК";
                worksheet.Cells[3, 5].Value = "Длъжност";
                worksheet.Cells[3, 6].Value = "Партия";
                worksheet.Cells[3, 7].Value = "Телефон";
                worksheet.Cells[3, 8].Value = "Дейност";
                worksheet.Cells[3, 9].Value = "Решение";

                //Add values
                for (var i = 0; i < lica.Count; i++)
                {
                    var colOffset = i + 4;

                    worksheet.Cells["A" + colOffset].Value = lica[i].Tur;
                    worksheet.Cells["B" + colOffset].Value = lica[i].EGN;
                    worksheet.Cells["C" + colOffset].Value = lica[i].Names;
                    worksheet.Cells["D" + colOffset].Value = lica[i].Sik;
                    worksheet.Cells["E" + colOffset].Value = lica[i].Dlujnost;
                    worksheet.Cells["F" + colOffset].Value = lica[i].Partia;
                    worksheet.Cells["G" + colOffset].Value = lica[i].Telefon;
                    worksheet.Cells["H" + colOffset].Value = lica[i].Deistvie;
                    worksheet.Cells["I" + colOffset].Value = lica[i].Reshenie;
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

        public string GenerateSpisukLicaExcelExport23(SikSpravkaFilter filter, string administrativenRaion, string userId)
        {

            String izbori = _izboriRepository.GetIzborDescription();

            var lica = _spravkiRepository.GetZamestvajiSpravka(
                        filter
                        , administrativenRaion
                        , userId)
                .ToList();

            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";
            var guidString = Guid.NewGuid();
            var sFileName = @"Замествания_(" + guidString + ").xlsx";
            var file = new FileInfo(Path.Combine(sWebRootFolder, sFileName));

            using (ExcelPackage package = new ExcelPackage(file))
            {
                // add a new worksheet to the empty workbook
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Замествания");

                worksheet.Cells["A1:B1"].Merge = true;
                worksheet.Cells["A2:B2"].Merge = true;
                worksheet.Cells["A3:B3"].Merge = true;
                worksheet.Cells["A4:B4"].Merge = true;
                worksheet.Cells["A5:B5"].Merge = true;
                worksheet.Cells["A6:B6"].Merge = true;
                worksheet.Cells["A7:B7"].Merge = true;
                worksheet.Cells["A8:B8"].Merge = true;

                worksheet.Cells[10, 1, 10, 8].Merge = true;
                worksheet.Cells[10, 1, 10, 8].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[10, 1, 10, 8].Style.Font.Bold = true;
                worksheet.Cells[10, 1, 10, 8].Style.Font.Size = 16;

                worksheet.Cells[1, 1].Value = "СТОЛИЧНА";
                worksheet.Cells[2, 1].Value = "Община";
                worksheet.Cells[4, 1].Value = (lica.Count > 0 ? lica[0].NmRajon : "");
                worksheet.Cells[5, 1].Value = "Административен район";
                worksheet.Cells[7, 1].Value = (lica.Count > 0 ? lica[0].NmIzbRajon : "");
                worksheet.Cells[8, 1].Value = "Изборен район";

                worksheet.Cells[10, 1].Value = "ЗАМЕСТВАНИЯ";

                worksheet.Cells[11, 1, 11, 10].Merge = true;
                worksheet.Cells[11, 1, 11, 10].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[11, 1].Value = izbori.Trim();

                //First add the headers
                worksheet.Cells[13, 1].Value = "Секция";
                worksheet.Cells[13, 2].Value = "Длъжност";
                worksheet.Cells[13, 3].Value = "Заместващ";
                worksheet.Cells[13, 4].Value = "ЕГН на заместващ";
                worksheet.Cells[13, 5].Value = "Телефон на заместващ";
                worksheet.Cells[13, 6].Value = "Заместван";
                worksheet.Cells[13, 7].Value = "ЕГН на заместван";
                worksheet.Cells[13, 8].Value = "Политическа сила";
                worksheet.Cells[13, 9].Value = "Дата";

                //Add values
                for (var i = 0; i < lica.Count; i++)
                {
                    var colOffset = i + 14;

                    worksheet.Cells["A" + colOffset].Value = lica[i].SikFullCode;
                    worksheet.Cells["B" + colOffset].Value = lica[i].Rolia;
                    worksheet.Cells["C" + colOffset].Value = lica[i].ImeNovo;
                    worksheet.Cells["D" + colOffset].Value = lica[i].EgnNovo;
                    worksheet.Cells["E" + colOffset].Value = lica[i].Telefon;
                    worksheet.Cells["F" + colOffset].Value = lica[i].ImeStaro;
                    worksheet.Cells["G" + colOffset].Value = lica[i].EgnStaro;
                    worksheet.Cells["H" + colOffset].Value = lica[i].Partia;
                    worksheet.Cells["I" + colOffset].Value = lica[i].Koga;
                }

                var modelRows = lica.Count + 13;
                string modelRange = "A12:I" + modelRows.ToString();
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

        public ICollection<IstoriaSikViewModel> GetSikIstoria(IzbRaionWithSikFilter filter, string user)
        {
            return _spravkiRepository.GetSikIstoria(filter, user);
        }


        public ICollection<SpisykPodvizjniSekciiViewModel> GetSpisykPodvizjniSekcii(IzbRaionWithSikFilter filter, string user)
        {
            return _spravkiRepository.GetSpisykPodvizjniSekcii(filter, user);
        }

        public ICollection<SpisukSekciiGraniciSpravkaViewModel> GetSpisukSekciiGraniciSpravka(IzbRaionWithSikFilter filter, string userId)
        {
            return _spravkiRepository.GetSpisukSekciiGraniciSpravka(filter, userId).Select(s => new SpisukSekciiGraniciSpravkaViewModel
            {
                Id = s.Id,
                NmIzbRajon = s.NmIzbRajon,
                NmRajon = s.NmRajon,
                SikNumb = s.SikNumb,
                Borders = s.Borders,
                NumbVoters = s.NumbVoters
            }).OrderBy(s => s.SikNumb)
              .ToList();
        }

        public ICollection<LicaForSpravkaRziViewModel> GetSpisukRziSpravka(SpravkaRziFilter filter, string userId)
        {
            return _spravkiRepository.GetSpisukRziSpravka(filter, userId).Select(s => new LicaForSpravkaRziViewModel
            {
                NmIzbRajon = s.NmIzbRajon,
                NmRajon = s.NmRajon,
                Egn = s.EGN,
                Imena = s.Ime,
                SikFullCode = s.SikNumb,
                Telephone = s.Telefon,
                Deinost = s.Deinost,
                TOA = s.TOA
            }).OrderBy(s => s.TOA)
              .ToList();
        }

        public string GenerateSpisukRziExport(SpravkaRziFilter filter, string userId)
        {
            var lica = _spravkiRepository.GetSpisukRziSpravka(
                        filter
                        , userId)
                .ToList();

            String izbori = _izboriRepository.GetIzborDescription();

            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";
            var guidString = Guid.NewGuid();
            var sFileName = @"Списък_за_РЗИ_(" + guidString + ").xlsx";
            var file = new FileInfo(Path.Combine(sWebRootFolder, sFileName));

            using (ExcelPackage package = new ExcelPackage(file))
            {
                // add a new worksheet to the empty workbook
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Списък за РЗИ");

                worksheet.Cells[1, 1, 1, 8].Merge = true;
                worksheet.Cells[1, 1, 1, 8].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[1, 1].Value = "Списък за CРЗИ";

                worksheet.Cells[2, 1, 2, 8].Merge = true;
                worksheet.Cells[2, 1, 2, 8].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[2, 1].Value = izbori.Trim();

                //First add the headers
                worksheet.Cells[3, 1].Value = "№";
                worksheet.Cells[3, 2].Value = "ЕГН";
                worksheet.Cells[3, 3].Value = "Име, Презиме, Фамилия";
                worksheet.Cells[3, 4].Value = "Секция";
                worksheet.Cells[3, 5].Value = "Телефон";
                worksheet.Cells[3, 6].Value = "Ваксиниране";

                //Add values
                for (var i = 0; i < lica.Count; i++)
                {
                    var colOffset = i + 4;

                    worksheet.Cells["A" + colOffset].Value = i + 1;
                    worksheet.Cells["B" + colOffset].Value = lica[i].EGN;
                    worksheet.Cells["C" + colOffset].Value = lica[i].Ime;
                    worksheet.Cells["D" + colOffset].Value = lica[i].SikNumb;
                    worksheet.Cells["E" + colOffset].Value = lica[i].Telefon;
                    worksheet.Cells["F" + colOffset].Value = lica[i].Deinost;
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

        public ICollection<SpravkaSekciiLicaViewModel> GetSpisukSekciiLica(IzbRaionWithSikFilter filter)
        {

            return _spravkiRepository.GetSpisukSekciiLica(filter)
                .Select(s => new SpravkaSekciiLicaViewModel
                        {
                            NmIzbRajon = s.NmIzbRajon,
                            NmRajon = s.NmRajon,
                            rowno = s.rowno,
                            Pokazatel = s.Pokazatel,
                            SIK0 = s.SIK0,
                            SIK1 = s.SIK1,
                            PSIK = s.PSIK,
                            Total = s.Total
                        })
                .OrderBy(s => s.rowno)
                .ToList();
        }

        public string GenerateSekciiLicaExport(IzbRaionWithSikFilter filter)
        {
            var lica = _spravkiRepository.GetSpisukSekciiLica(filter).ToList();

            String izbori = _izboriRepository.GetIzborDescription();

            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";
            var guidString = Guid.NewGuid();
            var sFileName = @"Списък_за_брой_секции_и_лица_(" + guidString + ").xlsx";
            var file = new FileInfo(Path.Combine(sWebRootFolder, sFileName));

            using (ExcelPackage package = new ExcelPackage(file))
            {
                // add a new worksheet to the empty workbook
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Списък за РЗИ");

                worksheet.Cells[1, 1, 1, 6].Merge = true;
                worksheet.Cells[1, 1, 1, 6].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[1, 1].Value = "СПРАВКА за брой секции и брой лица по длъжности и дейности";

                worksheet.Cells[2, 1, 2, 6].Merge = true;
                worksheet.Cells[2, 1, 2, 6].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[2, 1].Value = izbori.Trim();

                var colOffset = 4;
                if (lica[0].NmIzbRajon.Length > 0)
                {
                    worksheet.Cells[colOffset, 1, colOffset, 6].Merge = true;
                    worksheet.Cells["A" + colOffset].Value = "Избирателен район: "+lica[0].NmIzbRajon;
                    colOffset++;
                }

                if (lica[0].NmRajon.Length > 0)
                {
                    worksheet.Cells[colOffset, 1, colOffset, 6].Merge = true;
                    worksheet.Cells["A" + colOffset].Value = "Административен район: "+lica[0].NmRajon;
                    colOffset++;
                }

                //First add the headers
                worksheet.Cells["A" + colOffset].Value = "№";
                worksheet.Cells["B" + colOffset].Value = "Показател";
                worksheet.Cells["C" + colOffset].Value = "СИК Основни";
                worksheet.Cells["D" + colOffset].Value = "СИК Служебни";
                worksheet.Cells["E" + colOffset].Value = "ПСИК";
                worksheet.Cells["F" + colOffset].Value = "ОБЩО";
                colOffset++;

                //Add values
                for (var i = 0; i < lica.Count; i++)
                {
                    worksheet.Cells["A" + colOffset].Value = lica[i].rowno.ToString("#.#").Replace(",", ".");
                    worksheet.Cells["B" + colOffset].Value = lica[i].Pokazatel;
                    worksheet.Cells["C" + colOffset].Value = lica[i].SIK0;
                    worksheet.Cells["D" + colOffset].Value = lica[i].SIK1;
                    worksheet.Cells["E" + colOffset].Value = lica[i].PSIK;
                    worksheet.Cells["F" + colOffset].Value = lica[i].Total;
                    colOffset++;
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

        public string GenerateSpisykSekcii(IzbRaionWithSikFilter filter, string userId)
        {
            var lica = _spravkiRepository.GetSpisukNaSekciiteSpravka(
                        filter
                        , userId)
                .ToList();

            String izbori = _izboriRepository.GetIzborDescription();

            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";
            var guidString = Guid.NewGuid();
            var sFileName = @"Списък_на_секциите_(" + guidString + ").xlsx";
            var file = new FileInfo(Path.Combine(sWebRootFolder, sFileName));

            using (ExcelPackage package = new ExcelPackage(file))
            {
                // add a new worksheet to the empty workbook
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Списък за РЗИ");

                worksheet.Cells[1, 1, 1, 4].Merge = true;
                worksheet.Cells[1, 1, 1, 4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[1, 1].Value = "Списък на адресите на избирателните секции";

                worksheet.Cells[2, 1, 2, 4].Merge = true;
                worksheet.Cells[2, 1, 2, 4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[2, 1].Value = izbori.Trim();

                var groups = lica.GroupBy(u => u.NmIzbRajon).ToList();

                var colOffset = 4;

                //Add values
                foreach (var group in groups)
                {
                    worksheet.Cells["A" + colOffset].Value = group.Key;
                    colOffset++;

                    var toagrp = group.GroupBy(s => s.NmRajon).ToList();

                    worksheet.Cells["A" + colOffset].Value = "";
                    colOffset++;

                    foreach (var toa in toagrp)
                    {
                        worksheet.Cells["A" + colOffset].Value = toa.Key;
                        colOffset++;

                        //First add the headers
                        worksheet.Cells["A" + colOffset].Value = "Секция";
                        worksheet.Cells["B" + colOffset].Value = "Адрес";
                        worksheet.Cells["C" + colOffset].Value = "Вид";
                        worksheet.Cells["D" + colOffset].Value = "Признак";
                        colOffset++;

                        foreach (var t in toa)
                        {
                            worksheet.Cells["A" + colOffset].Value = t.SikNumb;
                            worksheet.Cells["B" + colOffset].Value = t.Address + " " + t.descript;
                            worksheet.Cells["C" + colOffset].Value = t.Vid;
                            worksheet.Cells["D" + colOffset].Value = t.Priznak;
                            colOffset++;
                        }
                    }
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

        public string GenerateSpisykSekcii2(IzbRaionWithSikFilter filter, string userId)
        {
            var lica = _spravkiRepository.GetSpisukNaSekciiteSpravka(
                        filter
                        , userId)
                .ToList();

            String izbori = _izboriRepository.GetIzborDescription();

            var sWebRootFolder = _hostingEnvironment.WebRootPath + "/reports/";
            var guidString = Guid.NewGuid();
            var sFileName = @"Списък_на_секциите_2_(" + guidString + ").xlsx";
            var file = new FileInfo(Path.Combine(sWebRootFolder, sFileName));

            using (ExcelPackage package = new ExcelPackage(file))
            {
                // add a new worksheet to the empty workbook
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Списък за РЗИ");

                worksheet.Cells[1, 1, 1, 2].Merge = true;
                worksheet.Cells[1, 1, 1, 2].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[1, 1].Value = "Списък на адресите на избирателните секции";

                worksheet.Cells[2, 1, 2, 2].Merge = true;
                worksheet.Cells[2, 1, 2, 2].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[2, 1].Value = izbori.Trim();

                var groups = lica.GroupBy(u => u.NmIzbRajon).ToList();

                var colOffset = 4;

                //Add values
                foreach (var group in groups)
                {
                    worksheet.Cells["A" + colOffset].Value = group.Key;
                    colOffset++;

                    var toagrp = group.GroupBy(s => s.NmRajon).ToList();

                    worksheet.Cells["A" + colOffset].Value = "";
                    colOffset++;

                    foreach (var toa in toagrp)
                    {
                        worksheet.Cells["A" + colOffset].Value = "";
                        colOffset++;

                        worksheet.Cells["A" + colOffset].Value = toa.Key;
                        colOffset++;

                        //First add the headers
                        worksheet.Cells["A" + colOffset].Value = "Секция";
                        worksheet.Cells["B" + colOffset].Value = "Адрес";
                        colOffset++;

                        foreach (var t in toa)
                        {
                            worksheet.Cells["A" + colOffset].Value = t.SikNumb;
                            worksheet.Cells["B" + colOffset].Value = t.Address+" "+t.descript;
                            colOffset++;
                        }
                    }
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


    }
}
