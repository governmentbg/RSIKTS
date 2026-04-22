namespace Repository.Implementations.Lica
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Security.Cryptography.X509Certificates;
    using System.ServiceModel;
    using System.Text;
    using System.Threading.Tasks;
    using System.Xml;
    using Common.Enums.Lica;
    using Common.Exceptions.Lica;
    using Common.Static;
    using Common.ViewModels.Lica;
    using Common.ViewModels.Spravki;
    using DataAccess;
    using DTO.Lica;
    using Microsoft.EntityFrameworkCore;
    using Repository.Interfaces.Izbori;
    using Repository.Interfaces.Lica;
    using ServiceReference1;

    public class LicaRepository : ILicaRepository
    {
        private readonly VotingRegisterContext _context;
        private readonly IIzboriRepository _izboriRepository;

        public LicaRepository(VotingRegisterContext context, IIzboriRepository izboriRepository)
        {
            _context = context;
            _izboriRepository = izboriRepository;
        }

        public ICollection<LiceGridDTO> GetLicaByPage(int page, string egn, string administrativenRaion, int sik)
        {
            page -= 1;

            if (egn == null)
            {
                var listLicaWithoutFilter = _context.LicaForGridSet.FromSql("CALL selectLica4Grid(@p0,@p1,@p2,@p3)"
                                                                            , ""
                                                                            , administrativenRaion
                                                                            , CryptoConstants.CryptoKey
                                                                            , sik)
                                                                   .ToList();

                return listLicaWithoutFilter.Select(l => new LiceGridDTO
                {
                    Id = l.Id,
                    EGN = l.Egn,
                    Names = l.Ime,
                    Partia = l.Partia,
                    Dlujnost = l.Dlyzjnost,
                    Sik = l.SIK,
                    Deistvie = l.Deistvie,
                    Reshenie = l.Reshenie,
                    Tur = l.Tur
                })
                .Skip(page * PaginationInfo.PageSize)
                .Take(PaginationInfo.PageSize)
                .ToList();
            }


            var listLicaWithFilter = _context.LicaForGridSet.FromSql("CALL selectLica4Grid(@p0,@p1,@p2,@p3)"
                                                                     , egn
                                                                     , administrativenRaion
                                                                     , CryptoConstants.CryptoKey
                                                                     , sik)
                                                            .ToList();

            return listLicaWithFilter.Select(l => new LiceGridDTO
            {
                Id = l.Id,
                EGN = l.Egn,
                Names = l.Ime,
                Partia = l.Partia,
                Dlujnost = l.Dlyzjnost,
                Sik = l.SIK,
                Deistvie = l.Deistvie,
                Reshenie = l.Reshenie,
                Tur = l.Tur
            })
            .Skip(page * PaginationInfo.PageSize)
            .Take(PaginationInfo.PageSize)
            .ToList();
        }

        public int GetMaxLicaPages(string egn, string administrativenRaion, int sik)
        {
            if (egn == null)
                return (int)Math.Ceiling(Convert.ToDouble(_context.LicaForGridSet.FromSql("CALL selectLica4Grid(@p0,@p1,@p2,@p3)"
                                                                                           , ""
                                                                                           , administrativenRaion
                                                                                           , CryptoConstants.CryptoKey
                                                                                           , sik)
                                                                                  .Count()) / PaginationInfo.PageSize);
            else
                return (int)Math.Ceiling(Convert.ToDouble(_context.LicaForGridSet.FromSql("CALL selectLica4Grid(@p0,@p1,@p2,@p3)"
                                                                                          , egn
                                                                                          , administrativenRaion
                                                                                          , CryptoConstants.CryptoKey
                                                                                          , sik)
                                                                                 .Count()) / PaginationInfo.PageSize);
        }

        public LicaEditViewModel GetLicaById(int id)
        {
            var lice = _context.NLica.FromSql("CALL selectLica(@p0,@p1)", id, CryptoConstants.CryptoKey)
                                    .ToList()
                                    .Select(l => new LicaEditViewModel
                                    {
                                        Id = l.Id,
                                        Egn = l.Egn,
                                        Ime1 = l.Im1,
                                        Ime2 = l.Im2,
                                        Ime3 = l.Im3,
                                        Apartament = l.Ap,
                                        Blok = l.Blok,
                                        Etaj = l.Et,
                                        ImpMessage = l.Impmessage,
                                        Jk = l.JkKv,
                                        NaselenoMqsto = l.Nas,
                                        Nacionalnost = l.Naz,
                                        Nomer = l.Nom,
                                        Oblast = l.Obl,
                                        Obrazovanie = l.Obra,
                                        Objina = l.Obs,
                                        Lk = l.Pas2,
                                        IzdadenaNa = l.Pas3,
                                        RuNaMVR = l.Pas4,
                                        Telephone = l.Tel,
                                        ZipCode = l.Pk,
                                        Raion = l.Raj,
                                        Specialnost = l.Spec,
                                        Ulica = l.Ul,
                                        Vhod = l.Vh,
                                        USER = l.User,
                                        Vid = l.VidId

                                    })
                                        .ToList()
                                        .FirstOrDefault(l => l.Id == id);

            var izbor = _context.NLicaIzbori.ToList()
                                .FirstOrDefault(l => l.IdLice == id &&
                                                     l.IzbAlias == _izboriRepository.GetIzborAlias() &&
                                                     l.Tur == _izboriRepository.GetIzborTUR());

            lice.Reshenie = "";
            lice.DohodaEpoGolqm = false;

            if (izbor != null)
            {
                lice.IdSik = izbor.IdSik ?? 0;
                lice.Reshenie = izbor.Re;
                lice.DohodaEpoGolqm = Convert.ToBoolean(izbor.Hasmaxincome);

                lice.Rolq = izbor.CodeRolia;
                lice.PoliticheskaSila = izbor.IdSila ?? 0;

                if (izbor.Toa == null)
                    lice.Raion = _context.Siks
                                    .Where(l => l.IdSek == izbor.IdSik)
                                    .ToList()
                                    .FirstOrDefault().Toa;
                else
                    lice.Raion = izbor.Toa;

                var deinostiList = _context.NLicaDopylnenie
                                        .Where(d => d.IdLice == izbor.Id)
                                        .Select(d => d.Idcodeposition)
                                        .ToList();
                /*
                                var deinostiList = new List<int>();             

                                foreach (var dopulenie in dopulneniq)
                                {
                                    deinostiList.Add(dopulenie.Idcodeposition);
                                }
                */
                lice.Deinosti = deinostiList.ToArray();
            }

            lice.JeZamestva = 0;
            lice.IdLiceZamestvan = 0;
            lice.IdLiceZamestvan2 = 0;

            return lice;
        }

        public async Task<int> TryEditLicaAsync(LicaEditViewModel editModel)
        {
            int checkGrao = CheckGraoNumber(editModel.Egn, (int)editModel.Vid);
            if (checkGrao == -1)
            {
                throw new ArgumentException("Грешно ЕГН");
            }

            if (checkGrao == 1)
            {
                throw new ArgumentException("Лицето няма навършени 18 години.");
            }

            var checkResult = _context.ImpMessageReturnSet.FromSql("CALL Check4DoublicateEgn(@p0,@p1,@p2,@p3,@p4)"
                                                            , editModel.Egn
                                                            , editModel.Vid
                                                            , editModel.Id
                                                            , editModel.Raion
                                                            , CryptoConstants.CryptoKey)
                                                    .FirstOrDefault();

            if (checkResult.ImpMessage.Length > 0)
            {
                throw new ArgumentException(checkResult.ImpMessage);
            }

            if ((int)editModel.Vid < 2)
            {
                string name = editModel.Ime1.Trim().ToUpper() + (editModel.Ime2 == null ? "" : editModel.Ime2.Trim().ToUpper()) + editModel.Ime3.Trim().ToUpper();
                string result = await checkValidPersonInRegiX(editModel.Egn, name);
                if (result.Length > 0)
                {
                    throw new ArgumentException(result);
                }
            }

            var izborAlias = _izboriRepository.GetIzborAlias();
            var izborTur = _izboriRepository.GetIzborTUR();
            int IdLiceZamestvan = Convert.ToInt32((editModel.JeZamestva == 2 ? editModel.IdLiceZamestvan2 : editModel.IdLiceZamestvan));

            var liceImpStatusCheck = _context.ImpMessageReturnSet.FromSql("CALL checkLica(@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11, @p12)",
                izborAlias,
                editModel.Raion,
                izborTur,
                editModel.Id,
                editModel.Vid,
                editModel.Egn,
                editModel.PoliticheskaSila,
                _context.Siks.FirstOrDefault(s => s.IdSek == editModel.IdSik && s.IzbAlias == izborAlias).Sik,
                editModel.Rolq,
                editModel.Specialnost,
                editModel.Obrazovanie,
                CryptoConstants.CryptoKey,
                editModel.JeZamestva > 0 ? IdLiceZamestvan : 0
                ).ToList().First();

            string impStatus = liceImpStatusCheck.ImpMessage.Substring(0, 2);

            if (!impStatus.Equals("00"))
            {
                throw new ImportLiceException(liceImpStatusCheck.ImpMessage.Substring(3, liceImpStatusCheck.ImpMessage.Length - 3));
            }

            var impStatusInsert = 0;

            var insertedLiceId = _context.IdReturnSet.FromSql("CALL updateLica(@p0,@p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@p9,@p10,@p11,@p12,@p13,@p14,@p15,@p16,@p17,@p18,@p19,@p20,@p21,@p22,@p23,@p24,@p25,@p26,@p27,@p28,@p29, @p30)",
                editModel.Id,
                editModel.Vid,
                editModel.Egn,
                editModel.Ime1,
                editModel.Ime2,
                editModel.Ime3,
                editModel.Obrazovanie,
                editModel.Specialnost,
                editModel.Telephone,
                "f",
                editModel.Lk,
                editModel.IzdadenaNa,
                editModel.RuNaMVR,
                editModel.Nacionalnost,
                editModel.Oblast,
                editModel.Objina,
                editModel.Raion,
                editModel.NaselenoMqsto,
                editModel.Ulica,
                editModel.Nomer,
                editModel.Jk,
                editModel.Blok,
                editModel.Vhod,
                editModel.Etaj,
                editModel.Apartament,
                editModel.ZipCode,
                impStatusInsert,
                liceImpStatusCheck.ImpMessage.Substring(3, liceImpStatusCheck.ImpMessage.Length - 3),
                editModel.USER,
                editModel.Raion,
                CryptoConstants.CryptoKey
            ).ToList()
            .FirstOrDefault().Id;

            if (insertedLiceId > 0)
            {
                var izbor = _context.NLicaIzbori.FirstOrDefault(l => l.IdLice == editModel.Id && l.Tur == _izboriRepository.GetIzborTUR());

                izbor.Hasmaxincome = Convert.ToInt32(editModel.DohodaEpoGolqm);
                izbor.Re = editModel.Reshenie;
                izbor.Koga = DateTime.Now;
                izbor.Toa = editModel.Raion;
                izbor.IdSik = editModel.IdSik;
                izbor.IdSila = editModel.PoliticheskaSila;
                izbor.CodeRolia = (editModel.JeZamestva == 2 ? izbor.CodeRolia : editModel.Rolq);  //zamqnata na rolqta se pravi v procedurata
                izbor.Toa = editModel.Raion;

                _context.RemoveRange(_context.NLicaDopylnenie.Where(l => l.IdLice == izbor.Id));
                _context.SaveChanges();

                if (editModel.Deinosti != null)
                {

                    foreach (var deinost in editModel.Deinosti)
                    {
                        _context.NLicaDopylnenie.Add(new NLicaDopylnenie
                        {
                            IdLice = izbor.Id,
                            VidCodetable = 3,
                            Idcodeposition = deinost,
                            User = editModel.USER,
                            Koga = DateTime.Now
                        });

                        _context.SaveChanges();
                    }
                }

                if (editModel.JeZamestva > 0)
                {
                    var Id = _context.IdReturnSet.FromSql("CALL insertLicaZamestvane(@p0,@p1,@p2,@p3)",
                                                        izbor.Id,
                                                        IdLiceZamestvan,
                                                        editModel.USER,
                                                        editModel.JeZamestva
                    )
                    .ToList();
                }
            }
            return insertedLiceId;
        }

        public async Task<int> TryAddLicaAsync(LicaAddViewModel addModel, string administrativenRaion)
        {
            int checkGrao = CheckGraoNumber(addModel.Egn, (int)addModel.Vid);
            if (checkGrao == -1)
            {
                throw new ArgumentException("Грешно ЕГН");
            }

            if (checkGrao == 1)
            {
                throw new ArgumentException("Лицето няма навършени 18 години.");
            }

            var checkResult = _context.ImpMessageReturnSet.FromSql("CALL Check4DoublicateEgn(@p0,@p1,@p2,@p3,@p4)"
                                                                    , addModel.Egn
                                                                    , addModel.Vid
                                                                    , 0
                                                                    , administrativenRaion
                                                                    , CryptoConstants.CryptoKey)
                                                            .FirstOrDefault();

            if (checkResult.ImpMessage.Length > 0)
            {
                throw new ArgumentException(checkResult.ImpMessage);
            }

            if (addModel.Vid < 2)
            {
                string name = addModel.Ime1.Trim().ToUpper() + (addModel.Ime2 == null ? "" : addModel.Ime2.Trim().ToUpper()) + addModel.Ime3.Trim().ToUpper();
                string result = await checkValidPersonInRegiX(addModel.Egn, name);
                if (result.Length > 0)
                {
                    throw new ArgumentException(result);
                }
            }

            var izborAlias = _izboriRepository.GetIzborAlias();
            var izborTur = _izboriRepository.GetIzborTUR();

            var liceImpStatusCheck = _context.ImpMessageReturnSet.FromSql("CALL checkLica(@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11, @p12)",
                    izborAlias,
                    administrativenRaion,
                    izborTur,
                    0,
                    addModel.Vid,
                    addModel.Egn,
                    addModel.PoliticheskaSila,
                    _context.Siks.FirstOrDefault(s => s.IdSek == addModel.IdSik && s.IzbAlias == izborAlias).Sik,
                    addModel.Rolq,
                    addModel.Specialnost,
                    addModel.Obrazovanie,
                    CryptoConstants.CryptoKey,
                    Convert.ToInt32(addModel.JeZamestva) > 0 ? addModel.IdLiceZamestvan : 0
                ).ToList()
                .First();

            string impStatus = liceImpStatusCheck.ImpMessage.Substring(0, 2);

            if (!impStatus.Equals("00"))
            {
                throw new ImportLiceException(liceImpStatusCheck.ImpMessage.Substring(3, liceImpStatusCheck.ImpMessage.Length - 3));
            }

            var impStatusInsert = 0;

            int insertedLiceId = _context.IdReturnSet.FromSql("CALL insertLica(@p0,@p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@p9,@p10,@p11,@p12,@p13,@p14,@p15,@p16,@p17,@p18,@p19,@p20,@p21,@p22,@p23,@p24,@p25,@p26,@p27,@p28,@p29,@out_value)",
                addModel.Vid,
                addModel.Egn,
                addModel.Ime1,
                addModel.Ime2,
                addModel.Ime3,
                addModel.Obrazovanie,
                addModel.Specialnost,
                addModel.Telephone,
                "f",
                addModel.Lk,
                addModel.IzdadenaNa,
                addModel.RuNaMVR,
                addModel.Nacionalnost,
                addModel.Oblast,
                addModel.Objina,
                addModel.Raion,
                addModel.NaselenoMqsto,
                addModel.Ulica,
                addModel.Nomer,
                addModel.Jk,
                addModel.Blok,
                addModel.Vhod,
                addModel.Etaj,
                addModel.Apartament,
                addModel.ZipCode,
                impStatusInsert,
                liceImpStatusCheck.ImpMessage.Substring(3, liceImpStatusCheck.ImpMessage.Length - 3),
                addModel.USER,
                addModel.Raion,
                CryptoConstants.CryptoKey
            ).ToList()
            .FirstOrDefault().Id;

            if (insertedLiceId > 0)
            {

                var licaIzbori = new NLicaIzbori
                {
                    IdLice = insertedLiceId,
                    IzbAlias = izborAlias,
                    Tur = izborTur,
                    Toa = administrativenRaion,
                    IdSik = addModel.IdSik,
                    IdSila = addModel.PoliticheskaSila,
                    Re = addModel.Reshenie,
                    CodeRolia = addModel.Rolq,
                    User = addModel.USER,
                    Koga = DateTime.Now,
                    Hasmaxincome = Convert.ToInt32(addModel.DohodaEpoGolqm)
                };

                _context.NLicaIzbori.Add(licaIzbori);
                _context.SaveChanges();

                var izbor = _context.NLicaIzbori.FirstOrDefault(l => l.IdLice == insertedLiceId
                                                                    && l.IzbAlias == izborAlias
                                                                    && l.Tur == izborTur);

                if (addModel.Deinosti != null)
                {
                    foreach (var deinost in addModel.Deinosti)
                    {
                        _context.NLicaDopylnenie.Add(new NLicaDopylnenie
                        {
                            IdLice = izbor.Id,
                            VidCodetable = 3,
                            Idcodeposition = deinost,
                            User = addModel.USER,
                            Koga = DateTime.Now
                        });
                        _context.SaveChanges();
                    }
                }


                if (Convert.ToInt32(addModel.JeZamestva) > 0)
                {
                    var Id = _context.IdReturnSet.FromSql("CALL insertLicaZamestvane(@p0,@p1,@p2, @p3)",
                                                        izbor.Id,
                                                        Convert.ToInt32(addModel.IdLiceZamestvan),
                                                        addModel.USER,
                                                        addModel.JeZamestva
                    ).ToList();
                }
            }

            return insertedLiceId;
        }

        public async Task<ImportResultLicaDTO> ImportLicaAsync(List<LicaImportViewModel> allLica, string administirativenRaion, string excelFile)
        {
            var Id = _context.IdReturnSet.FromSql("CALL deleteImportLica(@p0)"
                                                  , allLica[0]?.User)
                                         .ToList();


            foreach (var lice in allLica)
            {
                int status = 0;
                string opisanie = "";

                int checkGrao = CheckGraoNumber(lice.Egn, 1);
                if (checkGrao == -1)
                {
                    opisanie = "Грешно ЕГН";
                    status = 2;
                }

                if (checkGrao == 1)
                {
                    opisanie = "Лицето няма навършени 18 години.";
                    status = 2;
                }

                if (status == 0)
                {
                    string name = lice.Ime1.Trim().ToUpper() + lice.Ime2.Trim().ToUpper() + lice.Ime3.Trim().ToUpper();
                    string result = await checkValidPersonInRegiX(lice.Egn, name);
                    if (result.Length > 0)
                    {
                        opisanie = result;
                        status = 2;
                    }
                }

                _context.NLicaImport.Add(new NLicaImport
                {
                    Id = _context.NLicaImport.Count() == 0 ? 1 : _context.NLicaImport.Last().Id + 1,
                    Egn = lice.Egn.Trim(),
                    Im1 = lice.Ime1.Trim(),
                    Im2 = lice.Ime2.Trim(),
                    Im3 = lice.Ime3.Trim(),
                    Sik = lice.SikNomer.Trim(),
                    Rolja = lice.Dlujnost.Trim(),
                    Obra = lice.Obrazovanie.Trim(),
                    Spec = lice.Specialnost.Trim(),
                    Tel = lice.Telephone.Trim(),
                    Status = status,
                    Opisanie = opisanie,
                    User = lice.User,
                    Pas1 = lice.Pas1

                });

                _context.SaveChanges();
            }

            _context.Database.ExecuteSqlCommand("CALL createLog(@p0, @p1, @p2, @p3, @p4, @p5)"
                                                      , allLica[0]?.User
                                                      , 2
                                                      , "Обработка на Excel файл"
                                                      , excelFile
                                                      , administirativenRaion
                                                      , ""
                                                  );


            var impExcelMsg = _context.ImpExcelMsgReturnSet.FromSql("CALL importLica(@p0,@p1,@p2,@p3,@p4,@p5)"
                                                    , allLica[0]?.User
                                                    , _izboriRepository.GetIzborAlias()
                                                    , _izboriRepository.GetIzborTUR()
                                                    , administirativenRaion
                                                    , allLica[0]?.Sila ?? 0
                                                    , CryptoConstants.CryptoKey)
                                            .ToList().First();

            return new ImportResultLicaDTO
            {
                ImportMessage = impExcelMsg.ImpExcelMessage,
                HasWrongRecords = impExcelMsg.WrongRec > 0
            };
        }

        public int DeleteLice(int liceId, string user, string toa)
        {
            return _context.IdReturnSet.FromSql("CALL deleteLica(@p0,@p1,@p2,@p3)"
                                                , liceId
                                                , user
                                                , toa
                                                , CryptoConstants.CryptoKey)
                                        .ToList()
                                        .First().Id;
        }

        public int GetLicaFromIzobryCount(string administrativenRajon)
        {
            var izborTur = _izboriRepository.GetIzborTUR();

            //v.2
            var lica = (from p in _context.NLicaIzbori
                        join c in _context.Siks
                            on p.IdSik equals c.IdSek
                        join v in _context.SiksVidove
                            on c.IdSek equals v.IdSik
                        join s in _context.NListCodepositions
                            on v.Idcodeposition equals s.Nkode
                        where c.StatusSekcia == 1
                           && c.Toa == administrativenRajon
                           && c.Tur == izborTur
                           && s.Calc == 1
                        select new { p.Id })
                    .ToList();


            return lica.Count();
        }

        public void NachislqvaneForLiceByIndex(string userId, string administrativenRajon, int liceIndex)
        {
            var izborTur = _izboriRepository.GetIzborTUR();

            //v.2 - trqbva da e kato v GetLicaFromIzobryCount
            var lice = (from p in _context.NLicaIzbori
                        join c in _context.Siks
                            on p.IdSik equals c.IdSek
                        join v in _context.SiksVidove
                            on c.IdSek equals v.IdSik
                        join s in _context.NListCodepositions
                            on v.Idcodeposition equals s.Nkode
                        where c.StatusSekcia == 1
                           && c.Toa == administrativenRajon
                           && c.Tur == izborTur
                           && s.Calc == 1
                        select new { p.Id })
                      .ToList()
                      .ElementAt(liceIndex);

            _context.Database.ExecuteSqlCommand("CALL calculateBonuses(@p0, @p1, @p2)"
                                                    , userId
                                                    , lice.Id
                                                    , CryptoConstants.CryptoKey
                                                );
        }

        public string GetFileForNap(int napFileOption, string userId, string administrativenRajon, int izborTur)
        {
            //            var lica = _context.NLicaIzbori.Where(l => _context.Siks.FirstOrDefault(s => s.IdSek == l.IdSik).Toa == administrativenRajon).Where(l => l.IdSik > 0).ToList();

            var lica = (from p in _context.NLicaIzbori
                        join c in _context.Siks
                            on p.IdSik equals c.IdSek
                        join v in _context.SiksVidove
                            on c.IdSek equals v.IdSik
                        join t in _context.NListCodepositions
                            on v.Idcodeposition equals t.Nkode
                        where c.StatusSekcia == 1
                           && c.Toa == administrativenRajon
                           && c.Tur == izborTur
                           && t.Calc == 1
                        select new { p.Id })
                        .ToList();

            var fileForNapText = new StringBuilder();

            foreach (var lice in lica)
            {

                var test = _context.NapFileLine.FromSql("CALL exportBonuses(@p0, @p1, @p2, @p3, @p4)"
                                                        , userId
                                                        , lice.Id
                                                        , napFileOption
                                                        , izborTur
                                                        , CryptoConstants.CryptoKey)
                                                  .FirstOrDefault()
                                                  .Line;
                if (test.Length > 0)
                {
                    fileForNapText.Append(test);
                    fileForNapText.AppendLine();
                }
            }

            _context.Database.ExecuteSqlCommand("CALL createLog(@p0, @p1, @p2, @p3, @p4, @p5)"
                                                    , userId
                                                    , 2
                                                    , "Генериране на файл за НАП"
                                                    , ""
                                                    , administrativenRajon
                                                    , ""
                                                );

            return fileForNapText.ToString();
        }

        public ICollection<LicaDeinostiDTO> GetLicaBySik(string administrativenRaion, string sikId)
        {

            var lica = _context.NLica4Grid.FromSql("CALL selectLica4ReplAction(@p0, @p1, @p2)"
                                                        , administrativenRaion
                                                        , sikId
                                                        , CryptoConstants.CryptoKey)
                                                .ToList();

            var licaDto = new List<LicaDeinostiDTO>();

            foreach (var lice in lica)
            {
                var liceDeinost = new LicaDeinostiDTO
                {
                    Id = lice.Id,
                    Sekciq = lice.Sekciq,
                    Imena = lice.Imena,
                    Dlujnost = lice.Dlujnost,
                    PoliticheskaSila = lice.PoliticheskaSila,
                    Reshenie = lice.Reshenie,
                    IdLiceIzbori = lice.IdLiceIzbori,
                    Deinosti = new int[0]
                };

                try
                {
                    liceDeinost.Deinosti = _context.NLicaDopylnenie.Where(s => s.IdLice == liceDeinost.IdLiceIzbori)?.Select(x => x.Idcodeposition).ToArray();
                }
                catch (Exception)
                {
                    liceDeinost.Deinosti = new int[0];
                }

                licaDto.Add(liceDeinost);
            }

            return licaDto;
        }

        public void MassUpdateLicaDeinost(LicaMassUpdateDeinostiModel model, string userId)
        {
            var allLicaList = model.AllLicaIds.ToList();

            var licaToUpdateList = model.LicaIds.ToList();


            foreach (var liceId in allLicaList)
            {
                int isChecked = (licaToUpdateList.Contains(liceId) ? 1 : 0);
                _context.Database.ExecuteSqlCommand("CALL updateLicaDeinost(@p0, @p1, @p2, @p3, @p4)"
                                                    , liceId
                                                    , model.Deinost
                                                    , isChecked
                                                    , userId
                                                    , CryptoConstants.CryptoKey
                                                    );
            }
        }

        public void MassUpdateLicaReshenie(LicaMassUpdateResheniqModel model, string userId)
        {


            switch (model.Seleciq)
            {
                case SelectionType.Vsichki:
                    var licaIzboryVsichki = _context.NLicaIzbori.Where(i => model.AllLicaIds.Contains(i.IdLice)
                                                                            && i.IzbAlias == _izboriRepository.GetIzborAlias()
                                                                            && i.Tur == _izboriRepository.GetIzborTUR());

                    foreach (var izbor in licaIzboryVsichki)
                    {
                        izbor.Re = model.Reshenie;
                    }

                    break;

                case SelectionType.Markirani:
                    var licaIzboryMarkirani = _context.NLicaIzbori.Where(i => model.LicaIds.Contains(i.IdLice)
                                                                            && i.IzbAlias == _izboriRepository.GetIzborAlias()
                                                                            && i.Tur == _izboriRepository.GetIzborTUR());

                    foreach (var izbor in licaIzboryMarkirani)
                    {
                        izbor.Re = model.Reshenie;
                    }

                    break;

                case SelectionType.NeMarkirani:

                    var notSelectedIds = model.AllLicaIds.Where(l => model.LicaIds.Contains(l) == false).ToList();

                    var licaIzboryNeMarkirani = _context.NLicaIzbori.Where(i => notSelectedIds.Contains(i.IdLice)
                                                                            && i.IzbAlias == _izboriRepository.GetIzborAlias()
                                                                            && i.Tur == _izboriRepository.GetIzborTUR());

                    foreach (var izbor in licaIzboryNeMarkirani)
                    {
                        izbor.Re = model.Reshenie;
                    }

                    break;
            }


            _context.SaveChanges();
        }

        public List<LicaForImportGridDto> GetWrongImportLicaForUser(string userId)
        {
            var lica = _context.LicaForWrongImports.FromSql("CALL selectWrongLica(@p0)", userId).ToList().Select(l => new LicaForImportGridDto
            {
                Egn = l.Egn,
                Ime1 = l.Im1,
                Ime2 = l.Im2,
                Ime3 = l.Im3,
                Obrazovanie = l.Obra,
                SikNomer = l.SIK,
                Dlujnost = l.Rolja,
                Specialnost = l.Spec,
                Telephone = l.Tel,
                Opisanie = l.Opisanie,
                Status = l.Status
            });

            return lica.ToList();
        }

        public ICollection<LiceGridDTO> GetLicaByFilter(LicaFilterViewModel model, string userId, int tip)
        {
            //v.2
            string siks = "";
            if (model.Sekciq != null)
                siks = string.Join(",", model.Sekciq);

            return _context.LicaForGridSet.FromSql("CALL spravka_select_lica(@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11)",
                                                    model.AdministrativenRaion,
                                                    model.Rolq ?? "",
                                                    model.Partiq ?? "",
                                                    model.Reshenie ?? "",
                                                    model.Deistvie ?? "",
                                                    siks,
                                                    //v.2                                                    model.Sekciq,
                                                    model.Egn ?? "",
                                                    userId,
                                                    tip,
                                                    CryptoConstants.CryptoKey,
                                                    model.SelectedTurs,
                                                    model.GlobalSearch
                                                  )
                                        .ToList()
                                        .Select(l => new LiceGridDTO
                                        {
                                            Id = l.Id,
                                            EGN = l.Egn,
                                            Names = l.Ime,
                                            Partia = l.Partia,
                                            Dlujnost = l.Dlyzjnost,
                                            Sik = l.SIK,
                                            Deistvie = l.Deistvie,
                                            Reshenie = l.Reshenie,
                                            Telefon = l.Telefon,
                                            Tur = l.Tur
                                        }
                                               )
                                        .ToList();
        }

        public ICollection<LicaForSpravka211Dto> GetLicaForSlujebnaSpravka211(SikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            string siklists = string.Join(",", filter.SikIds);
            return _context.Spravka211Set.FromSql("CALL spravka_2_1_1(@p0, @p1, @p2, @p3, @p4)",
                                                    "00",
                                                    administrativenRaion,
                                                    siklists,
                                                    userId,
                                                    CryptoConstants.CryptoKey
                                                  ).ToList()
                .Select(l => new LicaForSpravka211Dto
                {
                    NmIzbRajon = l.NmIzbRajon,
                    NmRajon = l.NmRajon,
                    SikFullCode = l.SikFullCode,
                    Rolia = l.Rolia,
                    Imena = l.Ime,
                    Egn = l.Egn,
                    Sila = l.Sila,
                    Telephone = l.Tel,
                    Reshenie = l.Re,
                    Obrazovanie = l.Obra,
                    Specialnost = l.Spec,
                    SikAddress = l.SikAddress,
                    descript = l.descript
                }).ToList();
        }
        public ICollection<LicaForVedomostSpravkaDto> GetLicaForVedomostSpravka(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            return _context.VedomostSpravki.FromSql("CALL spravka_3_1(@p0, @p1, @p2, @p3, @p4)",
                                                    administrativenRaion,
                                                    (filter.SelectedTurs==0?1: filter.SelectedTurs),
                                                    string.Join(",", filter.SikIds),
                                                    userId,
                                                    CryptoConstants.CryptoKey
                                                  ).ToList()
                .Select(l => new LicaForVedomostSpravkaDto
                {
                    Number = l.Num,
                    SikCode = l.SikCode,
                    Rolia = l.Rolia,
                    Imena = l.Ime,
                    Suma = l.Suma,
                    NmIzbRajon = l.NmIzbRajon,
                    NmRajon = l.NmRajon,
                    Egn = l.Egn,
                    SikFullCode = l.SikFullCode
                }).ToList();
        }

        public ICollection<LicaForSpravka32ViewModel> GetLicaForSpravka32(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId)
        {

            var lica = _context.Spravka32Set.FromSql("CALL spravka_3_2(@p0, @p1, @p2, @p3, @p4)",
                                                    administrativenRaion,
                                                    (filter.SelectedTurs == 0 ? 1 : filter.SelectedTurs),
                                                    string.Join(",", filter.SikIds),
                                                    userId,
                                                    CryptoConstants.CryptoKey
                                                  ).ToList();

            return lica.Select(l => new LicaForSpravka32ViewModel
            {
                Orders = l.Orders ?? 0,
                BirthYear = l.BirthYear ?? 0,
                T = l.T,
                NmIzbRajon = l.NmIzbRajon,
                NmRajon = l.NmRajon,
                Col1 = l.Col1?.ToString(),
                Col2 = l.Col2?.ToString(),
                Col3 = l.Col3?.ToString(),
                Col4 = l.Col4?.ToString(),
                Col5 = l.Col5?.ToString(),
                Col6 = l.Col6?.ToString(),
                S = l.S?.ToString(),
                S01 = l.S01?.ToString(),
                S02 = l.S02?.ToString(),
                S03 = l.S03?.ToString(),
                S04 = l.S04?.ToString(),
                S05 = l.S05?.ToString(),
                S06 = l.S06?.ToString(),
                S07 = l.S07?.ToString(),
                S08 = l.S08?.ToString(),
                S09 = l.S09?.ToString(),
                S10 = l.S10?.ToString(),
                filter = filter
            }).ToList();
        }

        public ICollection<LicaForSpravka211Dto> GetLicaForPublichnaSpravka211(IzbRaionWithSikFilter filter, string userId)
        {
            return _context.Spravka211Set.FromSql("CALL spravka_2_1_1(@p0, @p1, @p2, @p3, @p4)",
                                                    filter.IzbRaionNkod,
                                                    filter.AdministrativenRaion,
                                                    string.Join(",", filter.SikIds),
                                                    userId,
                                                    CryptoConstants.CryptoKey
                                                  ).ToList()
                .Select(l => new LicaForSpravka211Dto
                {
                    NmIzbRajon = l.NmIzbRajon,
                    NmRajon = l.NmRajon,
                    SikFullCode = l.SikFullCode,
                    Rolia = l.Rolia,
                    Imena = l.Ime,
                    Egn = l.Egn,
                    Sila = l.Sila,
                    Telephone = l.Tel,
                    Reshenie = l.Re,
                    Obrazovanie = l.Obra,
                    Specialnost = l.Spec
                }).ToList();
        }

        public ICollection<LicaDeinostiDTO> GetLicaBySikToaAndSila(string toa, string sik, int silaId)
        {
            var ids = _context.NLicaIzbori.Where(s => s.IzbAlias == _izboriRepository.GetIzborAlias()
                                                    && s.Tur == _izboriRepository.GetIzborTUR()
                                                    && s.IdSila == silaId
                                                    )
                                          .Select(s => s.IdLice)
                                          .ToList();

            var lica = _context.NLica4Grid.FromSql("CALL selectLica4ReplAction(@p0, @p1, @p2)"
                                                , toa
                                                , sik
                                                , CryptoConstants.CryptoKey)
                                     .Where(l => ids.Contains(l.Id) && l.Sekciq == sik)
                                     .ToList();

            var licaDto = new List<LicaDeinostiDTO>();

            foreach (var lice in lica)
            {
                var liceDeinost = new LicaDeinostiDTO
                {
                    Id = lice.Id,
                    Sekciq = lice.Sekciq,
                    Imena = lice.Imena,
                    Dlujnost = lice.Dlujnost,
                    PoliticheskaSila = lice.PoliticheskaSila,
                    Reshenie = lice.Reshenie,
                    Deinosti = new int[0],
                };
                /* ne znam zashto se pylni tova tuk
                                try
                                {
                                    liceDeinost.Deinosti = _context.NLicaDopylnenie.Where(s => s.IdLice == lice.Id)?.Select(x => x.Idcodeposition).ToArray();
                                }
                                catch (Exception)
                                {
                                    liceDeinost.Deinosti = new int[0];
                                }

                */
                licaDto.Add(liceDeinost);
            }

            return licaDto;
        }

        public ICollection<LicaForSpravka212Dto> GetSystavRezervi(SikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            return _context.Spravka212Set.FromSql("CALL spravka_2_1_2(@p0, @p1, @p2, @p3)",
                                                    administrativenRaion,
                                                    string.Join(",", filter.SikIds),
                                                    userId,
                                                    CryptoConstants.CryptoKey
                                                  ).ToList()
                .Select(l => new LicaForSpravka212Dto
                {
                    NmRajon = l.NmRajon,
                    SikFullCode = l.SikFullCode,
                    Rolia = l.Rolia,
                    Imena = l.Ime,
                    Egn = l.Egn,
                    Sila = l.Sila,
                    Telephone = l.Tel
                }).ToList();
        }

        public int GetZamestvanRolia(int id, string administrativenRaion)
        {
            int rolia = (from p in _context.NLicaIzbori
                         join c in _context.Siks
                         on p.IdSik equals c.IdSek
                         where p.IdLice == id &&
                                p.IzbAlias == _izboriRepository.GetIzborAlias() &&
                                p.Tur == _izboriRepository.GetIzborTUR() &&
                                c.Toa == administrativenRaion
                         select p.CodeRolia).FirstOrDefault();
            return rolia;
        }

        public ICollection<LicaDeinostiDTO> GetLicaByToaAndSila(string toa, int silaId, string userId)
        {
            return _context.LicaForGridSet.FromSql("CALL spravka_select_lica(@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11)",
                                                           toa,
                                                           "",
                                                           silaId,
                                                           "",
                                                           "",
                                                           "",
                                                           "",
                                                           userId,
                                                           1,
                                                           CryptoConstants.CryptoKey,
                                                           0,
                                                           0
                                                         )
                                               .ToList()
                                               .Select(l => new LicaDeinostiDTO
                                               {
                                                   Id = l.Id,
                                                   Imena = l.Ime,
                                                   PoliticheskaSila = l.Partia,
                                                   Dlujnost = l.Dlyzjnost,
                                                   Sekciq = l.SIK,
                                                   Deinosti = new int[0],
                                                   Reshenie = l.Reshenie,
                                                   IdLiceIzbori = 0
                                               })
                                               .ToList();
        }

        public int CheckGraoNumber(string graonumber, int graotype)
        {
            var checkResult = _context.IdReturnSet.FromSql("CALL checkGraoNumber(@p0,@p1)"
                                                    , graonumber
                                                    , graotype)
                                          .FirstOrDefault();

            return checkResult.Id;
        }


        private async Task <string> checkValidPersonInRegiX(string egn, string name)
        {
            // Create the binding (previously from App.config)
            var binding = new BasicHttpBinding
            {
                MaxReceivedMessageSize = 10000000, // Set the message size
                Security = new BasicHttpSecurity
                {
                    Mode = BasicHttpSecurityMode.Transport,
                    Transport = new HttpTransportSecurity
                    {
                        ClientCredentialType = HttpClientCredentialType.Certificate
                    }
                }
            };

            // Set the endpoint address (previously from App.config)
            var endpoint = new EndpointAddress("https://service-regix.egov.bg/RegiXEntryPointV2.svc/basic");

            // Create and return the client
            var client = new RegiXEntryPointV2Client(binding, endpoint);

            // Set client certificate (from App.config)
            client.ClientCredentials.ClientCertificate.SetCertificate(
                StoreLocation.LocalMachine,
                StoreName.My,
                X509FindType.FindByThumbprint,
                "ec912002fbf7267c53357b29c2139efefa29401c"
            );


            RequestWrapper requestWrapper = new RequestWrapper();
            ServiceRequestData request = new ServiceRequestData();

            request.Operation = "TechnoLogica.RegiX.GraoNBDAdapter.APIService.INBDAPI.ValidPersonSearch";

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(@"<ValidPersonRequest
                            xmlns:xsd=""http://www.w3.org/2001/XMLSchema""
                            xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""
                            xmlns=""http://egov.bg/RegiX/GRAO/NBD/ValidPersonRequest"">
                            <EGN>"+egn+"</EGN>" +
                          "</ValidPersonRequest>");

            request.Argument = doc.DocumentElement;
            request.CallContext = new CallContext();
            request.CallContext.LawReason = "Чл. 89, ал. 1; чл. 91, ал. 4, т. 1; чл. 91, ал. 8, т. 1 от Изборния кодекс";
            request.ReturnAccessMatrix = false;
            request.SignResult = true;

            requestWrapper.ServiceRequestData = request;
            var response = await client.ExecuteAsync(requestWrapper);

            if (!response.ServiceResultData.HasError)
            {
                XmlElement result = response.ServiceResultData.Data.Response.Any;
                XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
                nsmgr.AddNamespace("ns", "http://egov.bg/RegiX/GRAO/NBD/ValidPersonResponse");

                try
                {
                    string firstName = result.SelectSingleNode("ns:FirstName", nsmgr).InnerText;
                    string surName = result.SelectSingleNode("ns:SurName", nsmgr).InnerText;
                    string familyName = result.SelectSingleNode("ns:FamilyName", nsmgr).InnerText;

                    string regixname = firstName.Trim() + surName.Trim() + familyName.Trim();

                    if (regixname == name)
                        return "";
                    else
                        return "Несъответствие на имена с ЕГН. В НБД „Население“: Име: " + firstName.Trim() + ", Презиме: " + surName.Trim() + ", Фамилия: " + familyName.Trim();
                } catch (Exception e) { 
                    return "Грешен отговор от RegiX ("+egn+")!";
                }
            }
            else
            {
                return "Грешка при свързване с RegiX!";
            }
        }
    }
}
