namespace Repository.Implementations.Sik
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using Common.Exceptions.Sik;
    using Common.Static;
    using Common.ViewModels.Raion;
    using Common.ViewModels.Sik;
    using DataAccess;
    using DTO.Sik;
    using Microsoft.EntityFrameworkCore;
    using Repository.Interfaces.Izbori;
    using Repository.Interfaces.Sik;
    public class SikRepository : ISikRepository
    {
        readonly private VotingRegisterContext _context;
        readonly private IIzboriRepository _izboriRepository;

        public SikRepository(VotingRegisterContext context, IIzboriRepository izboriRepository)
        {
            _context = context;
            _izboriRepository = izboriRepository;
        }

        public ICollection<SikBasicDto> GetAllSiks(int page, string sikFilter, string administrativenRaion)
        {
            page = page - 1;


            if(sikFilter == null)
            {
                var listSikWithFilter = _context.SikForGridSet
                                                .FromSql("CALL selectSik4Grid(@p0)", administrativenRaion)
                                                .ToList();

                return listSikWithFilter.Select(s => new SikBasicDto
                {
                    IdSek = s.IdSek,
                    Id = s.Sik,
                    Address = s.AdrIme,
                    Vid = s.Vid,
                    Status = s.StatusSekcia > 0 ? true : false,
                    Toa = administrativenRaion,
                    Descript = s.Descript
                })
                .Skip(page * PaginationInfo.PageSize)
                .Take(PaginationInfo.PageSize)
                .ToList();
            }


            var listSikWithOutFilter = _context.SikForGridSet
                                                .FromSql("CALL selectSik4Grid(@p0)", administrativenRaion)
                                                .ToList();

            return listSikWithOutFilter.Where(s => s.Sik.Contains(sikFilter)).Select(s => new SikBasicDto
                    {
                        IdSek = s.IdSek,
                        Id = s.Sik,
                        Address = s.AdrIme,
                        Status = s.StatusSekcia > 0 ? true : false,
                        Vid = s.Vid,
                        Toa = administrativenRaion
            })
            .Skip(page * PaginationInfo.PageSize)
            .Take(PaginationInfo.PageSize)
            .ToList();
        }

        public int GetMaxSikPages(string sikFilter, string administrativenRaion)
        {
            int sikCnt = 0;
            if(sikFilter == null)
            {
                sikCnt = _context.Siks
                            .Where(s => s.Toa == administrativenRaion 
                                    && s.IzbAlias == _izboriRepository.GetIzborAlias()
                                    && s.Tur == _izboriRepository.GetIzborTUR())
                            .Count();
            }
            else
            {
                sikCnt = _context.Siks
                            .Where(s => s.Toa == administrativenRaion
                                    && s.IzbAlias == _izboriRepository.GetIzborAlias()
                                    && s.Tur == _izboriRepository.GetIzborTUR()
                                    && s.Sik.Contains(sikFilter))
                            .Count();
            }

            return (int)Math.Ceiling(Convert.ToDouble(sikCnt) / PaginationInfo.PageSize);
        }

        public void TryDelete(int sikId, string userId)
        {
            var sikDeleteStatus = _context.IdReturnSet.FromSql("CALL deleteSik(@p0, @p1)", sikId, userId).ToList()[0].Id;

            if(sikDeleteStatus == -1)
            {
                throw new DeleteSikException("Не може да се деактивира служебната секция.");
            }
            else if(sikDeleteStatus == -2)
            {
                throw new DeleteSikException("Секцията има хора в нея и не може да бъде деактивирана.");
            }

            _context.SaveChanges();
        }

        public SikEditViewModel GetSik(int sikId)
        {
            var sik = _context.Siks.FirstOrDefault(s => s.IdSek == sikId);

            if(sik == null)
            {
                return new SikEditViewModel();
            }

            var dataToa = from c in _context.Wntoa
                          join p in _context.SiksPodvizjni
                            on new { Toa = c.Nkod, v = true } equals new {p.Toa, v = p.IdSik == sikId }
                            into ps
                          from p in ps.DefaultIfEmpty()
                          select new
                          {
                              c.Nkod,
                              c.Nime,
                              VoterNumbere = p == null ? 0 : p.VoterNumbere
                          };

            var calcSik = from c in _context.SiksVidove
                          join p in _context.NListCodepositions
                            on new { Nkod = c.Idcodeposition, v = true } equals new { Nkod = p.Nkode, v = p.Pkode == 1 }
                          into ps
                          from p in ps.DefaultIfEmpty()
                          select new
                          {
                              p.Calc,
                          };

            return new SikEditViewModel
            {
                IdSek = sikId,
                TOA = sik.Toa,
                AABBCC = sik.AaBbCc,
                Sik = sik.Sik,
                Obl = sik.Obl,
                Obs = sik.Obs,
                Kodnsm = sik.Nas,
                JK_KV = sik.JkKv,
                ULKOD = sik.Ul,
                Nom = sik.Nom,
                Blok = sik.Blok,
                ADR_IME = sik.AdrIme,
                MaxBroiChlenove = sik.BroiMembers ?? 0,
                NUMBVOTERS = sik.NumbVoters ?? 0,
                BORDERS = sik.Borders,
                IzbRajon = sik.IzbRajon,
                Status = sik.StatusSekcia > 0 ? true : false,
                Vidove = _context.SiksVidove
                                .Where(s => s.Vid_codetable == 1 && s.IdSik == sikId)
                                .Select(s => s.Idcodeposition)
                                .FirstOrDefault(),
                Priznaci = _context.SiksVidove
                                    .Where(s => s.Vid_codetable == 2 && s.IdSik == sikId)
                                    .Select(s => s.Idcodeposition)
                                    .ToArray(),
                AllToaForPodvijnaSekciq = dataToa
                                .Select(s => new RaionForSikPodvijnaSekciqViewModel
                                {
                                    Toa = s.Nkod
                                        , Ime = s.Nime
                                        , Izbirateli = s.VoterNumbere })
                                .ToList(),
                isCalc = calcSik.FirstOrDefault().Calc 
            };         
        }

        public void TryEditSik(SikEditViewModel editModel)
        {
            var allSiks = _context.Siks.ToList();

            //if (allSiks.Any(s => s.IdSek != editModel.IdSek && s.Sik == editModel.Sik && s.IzbAlias == _izboriRepository.GetIzborAlias() && s.Toa== editModel.TOA))
            //{
            //    throw new ArgumentException("Дублиране на СИК");
            //}

            var egnCheckResult = _context.IdReturnSet.FromSql("CALL check4DoublicateSik(@p0,@p1,@p2,@p3,@p4)"
                                                            , editModel.Sik
                                                            , _izboriRepository.GetIzborAlias()
                                                            , _izboriRepository.GetIzborTUR()
                                                            , editModel.TOA
                                                            , editModel.IdSek)
                                                     .FirstOrDefault();

            if (egnCheckResult.Id == -1)
            {
                throw new ArgumentException("Дублиран СИК в базата.");
            }

            var sikId = _context.IdReturnSet.FromSql("CALL updateSik(@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11, @p12, @p13, @p14, @p15, @p16, @p17, @p18, @p19)"
                ,
                        editModel.IdSek
                        , _izboriRepository.GetIzborAlias()
                        , _izboriRepository.GetIzborTUR()
                        , editModel.TOA
                        , editModel.TOA
                        , editModel.AABBCC
                        , editModel.Sik
                        , editModel.Obl
                        , editModel.Obs
                        , editModel.Kodnsm
                        , editModel.JK_KV
                        , editModel.ULKOD
                        , editModel.Nom
                        , editModel.Blok
                        , editModel.ADR_IME
                        , editModel.Status
                        , editModel.MaxBroiChlenove
                        , editModel.NUMBVOTERS
                        , editModel.BORDERS
                        , editModel.USER
                    ).ToList();

            _context.SiksVidove.RemoveRange(_context.SiksVidove.Where(s => s.Vid_codetable == 1 && s.IdSik == editModel.IdSek));
            _context.SiksVidove.RemoveRange(_context.SiksVidove.Where(s => s.Vid_codetable == 2 && s.IdSik == editModel.IdSek));

            _context.SiksVidove.Add(new SiksVidove()
            {
                Id = _context.SiksVidove.LastOrDefault() == null ? 1 : _context.SiksVidove.LastOrDefault().Id + 1,
                IzbAllias = _izboriRepository.GetIzborAlias(),
                Tur = _izboriRepository.GetIzborTUR(),
                IdSik = sikId.First().Id,
                Vid_codetable = 1,
                Idcodeposition = editModel.Vidove,
                Status = Convert.ToInt32(editModel.Status)
            });
            _context.SaveChanges();

            if (editModel.Priznaci != null)
            {

                for (var i = 0; i < editModel.Priznaci.Count(); i++)
                {
                    _context.SiksVidove.Add(new SiksVidove()
                    {
                        Id = _context.SiksVidove.LastOrDefault() == null ? 1 : _context.SiksVidove.LastOrDefault().Id + 1,
                        IzbAllias = _izboriRepository.GetIzborAlias(),
                        Tur = _izboriRepository.GetIzborTUR(),
                        IdSik = sikId.First().Id,
                        Vid_codetable = 2,
                        Idcodeposition = editModel.Priznaci[i],
                        Status = Convert.ToInt32(editModel.Status)
                    });
                    _context.SaveChanges();
                }
            }

            //v.2
            if (editModel.Vidove == 102 && editModel.AllToaForPodvijnaSekciq != null)
            {

                _context.SiksPodvizjni.RemoveRange(_context.SiksPodvizjni.Where(s => s.IdSik == editModel.IdSek));

                for (var i = 0; i < editModel.AllToaForPodvijnaSekciq.Count(); i++)
                {
                    if (editModel.AllToaForPodvijnaSekciq[i].Izbirateli > 0) { 
                        _context.SiksPodvizjni.Add(new SiksPodvijni()
                        {
                            IdSik = sikId.First().Id,
                            Toa= editModel.AllToaForPodvijnaSekciq[i].Toa,
                            VoterNumbere = editModel.AllToaForPodvijnaSekciq[i].Izbirateli,
                            User = editModel.USER,
                            Koga =DateTime.Now
                        });

                        _context.SaveChanges();
                    }
                }
            }

        }

        public void TryAddSik(SikAddViewModel addModel)
        {
            //var allSiks = _context.Siks.ToList();

            //if (allSiks.Any(s => s.Sik == addModel.Sik && s.IzbAlias == _izboriRepository.GetIzborAlias() && s.Toa== addModel.TOA.ToString()))
            //{
            //    throw new ArgumentException("Дублиране на СИК");
            //}

            var egnCheckResult = _context.IdReturnSet.FromSql("CALL check4DoublicateSik(@p0,@p1,@p2,@p3,@p4)"
                                                        , addModel.Sik
                                                        , _izboriRepository.GetIzborAlias()
                                                        , _izboriRepository.GetIzborTUR()
                                                        , addModel.TOA
                                                        , 0)
                .FirstOrDefault();

            if (egnCheckResult.Id == -1)
            {
                throw new ArgumentException("Дублиран СИК в базата.");
            }

            var sikId = _context.IdReturnSet.FromSql("CALL insertSik(@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11, @p12, @p13, @p14, @p15, @p16, @p17, @p18, @out_value)"
                ,
                        _izboriRepository.GetIzborAlias()
                        , _izboriRepository.GetIzborTUR()
                        , addModel.TOA
                        , addModel.TOA
                        , addModel.AABBCC
                        , addModel.Sik
                        , addModel.Obl
                        , addModel.Obs
                        , addModel.Kodnsm
                        , addModel.JK_KV
                        , addModel.ULKOD
                        , addModel.Nom
                        , addModel.Blok
                        , addModel.ADR_IME
                        , addModel.USER
                        , addModel.Status
                        , addModel.MaxBroiChlenove
                        , addModel.NUMBVOTERS
                        , addModel.BORDERS
                ).ToList();

                _context.SiksVidove.Add(new SiksVidove()
            {
                Id = _context.SiksVidove.LastOrDefault() == null ? 1 : _context.SiksVidove.LastOrDefault().Id + 1,
                IzbAllias = _izboriRepository.GetIzborAlias(),
                Tur = _izboriRepository.GetIzborTUR(),
                IdSik = sikId.First().Id,
                Vid_codetable = 1,
                Idcodeposition = addModel.Vidove,
                Status = Convert.ToInt32(addModel.Status)
            });
            _context.SaveChanges();
 
            if (addModel.Priznaci != null) {

                for (var i = 0; i < addModel.Priznaci.Count(); i++)
                {
                    _context.SiksVidove.Add(new SiksVidove()
                    {
                        Id = _context.SiksVidove.LastOrDefault() == null ? 1 : _context.SiksVidove.LastOrDefault().Id + 1,
                        IzbAllias = _izboriRepository.GetIzborAlias(),
                        Tur = _izboriRepository.GetIzborTUR(),
                        IdSik = sikId.First().Id,
                        Vid_codetable = 2,
                        Idcodeposition = addModel.Priznaci[i],
                        Status = Convert.ToInt32(addModel.Status)
                    });
                    _context.SaveChanges();
                }
            }

            //v.2
            if (addModel.Vidove == 102 && addModel.AllToaForPodvijnaSekciq != null)
            {
                for (var i = 0; i < addModel.AllToaForPodvijnaSekciq.Count(); i++)
                {
                    if (addModel.AllToaForPodvijnaSekciq[i].Izbirateli > 0)
                    {
                        _context.SiksPodvizjni.Add(new SiksPodvijni()
                        {
                            IdSik = sikId.First().Id,
                            Toa = addModel.AllToaForPodvijnaSekciq[i].Toa,
                            VoterNumbere = addModel.AllToaForPodvijnaSekciq[i].Izbirateli,
                            User = addModel.USER,
                            Koga = DateTime.Now
                        });

                        _context.SaveChanges();
                    }
                }
            }
        }

    

        public ICollection<SikBasicDto> GetAllSiks()
        {
            var siks = from p in _context.Siks
                       join v in _context.SiksVidove on p.IdSek equals v.IdSik
                       join s in _context.NListCodepositions on new { id = v.Idcodeposition, a = v.Vid_codetable == 1 } equals new { id = s.Nkode, a = true }
                       where p.StatusSekcia == 1
                           && p.IzbAlias == _izboriRepository.GetIzborAlias()
                           && p.Tur == _izboriRepository.GetIzborTUR()
                           && s.Calc == 1
                       select new SikBasicDto()
                       {
                           IdSek = p.IdSek,
                           Id = p.Sik,
                           Address = p.ToaNavigation.Nime,
                           fullcode = p.AaBbCc,
                           Toa = p.Toa,
                           Vid = s.Nime
                       };

            return siks
                    .Select(s => new SikBasicDto
                        {
                            IdSek = s.IdSek,
                            Id = s.Id,
                            Address = s.Address,
                            Toa = s.Toa,
                            Vid = s.Vid
                        })
                    .OrderBy(p => p.fullcode)
                    .ToList();
        }

        public ICollection<SikBasicDto> GetAllSiksIncludingDefault(string administrativenRaion)
        {
            //v.2
            var siks = from p in _context.Siks
                       join v in _context.SiksVidove on p.IdSek equals v.IdSik
                       join s in _context.NListCodepositions on new { id = v.Idcodeposition, a = v.Vid_codetable == 1 } equals new { id = s.Nkode, a = true }
                       where p.StatusSekcia == 1
                           && p.IzbAlias == _izboriRepository.GetIzborAlias()
                           && p.Tur == _izboriRepository.GetIzborTUR()
            //               && s.Calc == 1 -- trqbwa da pokazwa wsichki aktivni
                       where p.StatusSekcia == 1
                           && p.Toa == administrativenRaion
                           && p.IzbAlias == _izboriRepository.GetIzborAlias()
                           && p.Tur == _izboriRepository.GetIzborTUR()
                       select new SikBasicDto()
                       {
                           IdSek = p.IdSek,
                           Id = p.Sik,
                           Address = p.ToaNavigation.Nime,
                           fullcode = p.AaBbCc,
                           Toa = p.Toa,
                           Vid = s.Nime
                       };

            return siks
                    .Select(s => new SikBasicDto
                        {
                            IdSek = s.IdSek,
                            Id = s.Id,
                            Address = s.Address,
                            fullcode = s.fullcode,
                            Toa = s.Toa,
                            Vid = s.Vid
                        })
                    .OrderBy(p => p.fullcode)
                    .ToList();
        }

        public ICollection<SikBasicDto> GetSiksByAdministrativenRaion(string nkod)
        {

            var siks = from p in _context.Siks
                       join v in _context.SiksVidove on p.IdSek equals v.IdSik
                       join s in _context.NListCodepositions on new { id=v.Idcodeposition, a=v.Vid_codetable==1} equals new { id=s.Nkode, a = true }
                       where p.StatusSekcia == 1
                           && p.IzbAlias == _izboriRepository.GetIzborAlias()
                           && p.Tur == _izboriRepository.GetIzborTUR()
                           && s.Calc == 1
                       select new SikBasicDto()
                        {
                            IdSek = p.IdSek,
                            Id = p.Sik,
                            Address = p.ToaNavigation.Nime,
                            fullcode = p.AaBbCc,
                            Toa = p.Toa,
                            Vid = s.Nime
                        };


            if (nkod == null)
            {
                return siks
                        .Select(s => new SikBasicDto
                            {
                                IdSek = s.IdSek,
                                Id = s.Id,
                                Address = s.Address,
                                Toa = s.Toa,
                                Vid = s.Vid
                            })
                        .OrderBy(p => p.Toa).ThenBy(n => n.fullcode)
                        .ToList();
            } 

            return siks
                    .Where(s => s.Toa == nkod)
                    .Select(s => new SikBasicDto
                            {
                                IdSek = s.IdSek,
                                Id = s.Id,
                                Address = s.Address,
                                Toa = s.Toa,
                                Vid = s.Vid
                    })
                    .OrderBy(p => p.fullcode)
                    .ToList();
        }


        public bool CheckSikType(int IdSik)
        {
             var sikvid = from p in _context.Siks
                           join v in _context.SiksVidove on p.IdSek equals v.IdSik
                           join s in _context.NListCodepositions on new { id = v.Idcodeposition, a = v.Vid_codetable == 1 } equals new { id = s.Nkode, a = true }
                          where p.IdSek == IdSik
                              && p.StatusSekcia == 1
                              && s.Calc == 1
                           select(new
                           {
                               v.Idcodeposition,
                           });

            if (sikvid.FirstOrDefault() != null)
                return true;
            else
                return false;
        }

        public int isSikVidCalc(int Id)
        {
            return _context.NListCodepositions
                    .Where(s => s.Nkode == Id && s.Pkode == 1)
                    .FirstOrDefault().Calc;
        }
    }
}
