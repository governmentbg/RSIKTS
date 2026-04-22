namespace Repository.Implementations.Raion
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using Common.Static;
    using Common.ViewModels.Raion;
    using DataAccess;
    using DTO.Raion;
    using Repository.Interfaces.Izbori;
    using Repository.Interfaces.Raion;
    using Microsoft.EntityFrameworkCore;

    public class RaionRepository : IRaionRepository
    {
        private readonly VotingRegisterContext _context;
        private readonly IIzboriRepository _izboriRepository;

        public RaionRepository(VotingRegisterContext context, IIzboriRepository izboriRepository)
        {
            _context = context;
            _izboriRepository = izboriRepository;
        }

        public void AddRaionMain(RaionAddViewModel newRaion, string userId)
        {
            var checkResult = _context.IdReturnSet.FromSql("CALL checkBulstat(@p0)"
                                                            ,newRaion.Bulstat)
                                                  .FirstOrDefault();

            if (checkResult.Id < 0)
            {
                throw new ArgumentException("Грешен БУЛСТАТ");
            }

            var insertedId = _context.IdReturnSet.FromSql("CALL insertToaMain(@p0,@p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@p9,@p10,@p11,@p12,@p13,@p14,@p15,@p16,@p17,@p18,@p19,@p20,@p21,@p22,@p23,@p24,@p25,@p26,@p27,@p28,@p29,@p30)",                
                                        _izboriRepository.GetIzborAlias(),
                                        newRaion.AdministrativenRaion,
                                        _izboriRepository.GetIzborTUR(),
                                        1,          //status
                                        GetAllRaioni(newRaion.AdministrativenRaion).ToList().ElementAt(0).Name,
                                        newRaion.Telephone,
                                        "",         //Tel1
                                        "",         //IzbRajoin
                                        newRaion.Oblast,
                                        newRaion.Objina,
                                        newRaion.AdministrativenRaion,
                                        newRaion.NaselenoMqsto,
                                        newRaion.Ulica,
                                        newRaion.Nomer,
                                        newRaion.Kvartal,
                                        newRaion.Blok,
                                        newRaion.Vhod,
                                        newRaion.Etaj,
                                        newRaion.Apartament,
                                        newRaion.ZipCode,
                                        newRaion.KmetNaRaion,
                                        newRaion.KmetNaRaion2,
                                        newRaion.Precedatel,
                                        newRaion.Sekretar,
                                        newRaion.BroiSekcii,
                                        newRaion.Predstavka,
                                        "",         //R1
                                        newRaion.ImeNaIzborite,
                                        newRaion.MaxBroiChlenove,
                                        newRaion.Bulstat,
                                        userId
                ).ToList();
            
                _context.SaveChanges();
        }

        public RaionAddViewModel GetRaionMain(string administrativenRaion)
        {

            bool has = _context.NToaMain.Any(m => m.Toa == administrativenRaion);

            if (!has)
            {
                var newRaion = new RaionAddViewModel();
                newRaion.AdministrativenRaion = administrativenRaion;

                var insertedId = _context.IdReturnSet.FromSql("CALL insertToaMain(@p0,@p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@p9,@p10,@p11,@p12,@p13,@p14,@p15,@p16,@p17,@p18,@p19,@p20,@p21,@p22,@p23,@p24,@p25,@p26,@p27,@p28,@p29,@p30)",
                                        _izboriRepository.GetIzborAlias(),
                                        newRaion.AdministrativenRaion,
                                        _izboriRepository.GetIzborTUR(),
                                        1,          //status
                                        GetAllRaioni(newRaion.AdministrativenRaion).ToList().ElementAt(0).Name,
                                        newRaion.Telephone,
                                        "",         //Tel1
                                        "",         //IzbRajoin
                                        "",
                                        "",
                                        newRaion.AdministrativenRaion,
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        0,
                                        "",
                                        "",         //R1
                                        "",
                                        0,
                                        "",
                                        ""
                ).ToList();
            }

            var currentRaionMain = _context.NToaMain.FirstOrDefault(m => m.Toa == administrativenRaion);

            var currentRaionMainModel = new RaionAddViewModel()
            {
                Nrec = currentRaionMain.Nrec,
                Oblast = currentRaionMain.Obl,
                Objina = currentRaionMain.Obs,
                AdministrativenRaion = currentRaionMain.Toa,
                NaselenoMqsto = currentRaionMain.Nas,
                ZipCode = currentRaionMain.Pk,
                Ulica = currentRaionMain.Ul,
                Nomer = currentRaionMain.Nom,
                Vhod = currentRaionMain.Vh,
                Etaj = currentRaionMain.Et,
                Apartament = currentRaionMain.Ap,
                Telephone = currentRaionMain.Tel,
                Bulstat = currentRaionMain.Bul,
                ImeNaIzborite = currentRaionMain.R2,
                MaxBroiChlenove = currentRaionMain.Ano ?? 0,
                BroiSekcii = currentRaionMain.Nsik ?? 0,
                Predstavka = currentRaionMain.Pris,
                Sekretar = currentRaionMain.Sekr,
                RikOrSik = currentRaionMain.R1,
                KmetNaRaion = currentRaionMain.Epod,
                KmetNaRaion2 = currentRaionMain.Ipod,
                Precedatel = currentRaionMain.Pred,
                Blok = currentRaionMain.Blok,
                Kvartal = currentRaionMain.JkKv
            };

            return currentRaionMainModel;
        }

        public void EditRaionMain(RaionAddViewModel editRaion, string userId)
        {
            var checkResult = _context.IdReturnSet.FromSql("CALL checkBulstat(@p0)"
                                                          , editRaion.Bulstat)
                                                  .FirstOrDefault();

            if (checkResult.Id < 0)
            {
                throw new ArgumentException("Грешен БУЛСТАТ");
            }

            var updatedId1 = _context.IdReturnSet.FromSql("CALL updateToaMain(@p0,@p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@p9,@p10,@p11,@p12,@p13,@p14,@p15,@p16,@p17,@p18,@p19,@p20,@p21,@p22,@p23,@p24,@p25,@p26,@p27,@p28,@p29,@p30,@p31)",
                                    editRaion.Nrec,
                                    _izboriRepository.GetIzborAlias(),
                                    editRaion.AdministrativenRaion,
                                    _izboriRepository.GetIzborTUR(),
                                    1,          //status
                                    GetAllRaioni(editRaion.AdministrativenRaion).ToList().ElementAt(0).Name,
                                    editRaion.Telephone,
                                    "",         //Tel1
                                    "",         //IzbRajoin
                                    editRaion.Oblast,
                                    editRaion.Objina,
                                    editRaion.AdministrativenRaion,
                                    editRaion.NaselenoMqsto,
                                    editRaion.Ulica,
                                    editRaion.Nomer,
                                    editRaion.Kvartal,
                                    editRaion.Blok,
                                    editRaion.Vhod,
                                    editRaion.Etaj,
                                    editRaion.Apartament,
                                    editRaion.ZipCode,
                                    editRaion.KmetNaRaion,
                                    editRaion.KmetNaRaion2,
                                    editRaion.Precedatel,
                                    editRaion.Sekretar,
                                    editRaion.BroiSekcii,
                                    editRaion.Predstavka,
                                    "",         //R1
                                    editRaion.ImeNaIzborite,
                                    editRaion.MaxBroiChlenove,
                                    editRaion.Bulstat,
                                    userId
            ).ToList();


            _context.SaveChanges();
 
        }

        public void DeleteRaionMainById(int raionMainId)
        {
            _context.Remove(_context.NToaMain.FirstOrDefault(m => m.Nrec == raionMainId));

            _context.SaveChanges();
        }

        public ICollection<RaionDTO> GetAllRaioni(string administrativenRaion)
        {
            if (administrativenRaion == null)
            {
                return _context.Wntoa
                                .Select(r => new RaionDTO
                                        {
                                            Id = r.Nkod,
                                            Name = r.Nime
                                        })
                                .ToList();
            }

            return _context.Wntoa.Where(r => r.Nkod == administrativenRaion)
                                 .Select(r => new RaionDTO
                                        {
                                            Id = r.Nkod,
                                            Name = r.Nime
                                        })
                                 .ToList();
        }

        public ICollection<RaionMainDTO> GetMainRaioniByUserAndPage(string userId, int page, string toaId)
        {
            //page = page - 1;

            var user = _context.Aspnetusers.FirstOrDefault(u => u.Id == userId);

            if (user.AdministrativeRajon == null && toaId == null)
            {
                return _context.NToaMain
                               .Where(m => m.Tur == _izboriRepository.GetIzborTUR())
                               .Select(m => new RaionMainDTO
                                {
                                    Nrec = m.Nrec,
                                    ToaId = m.Toa,
                                    Name = m.Ime
                                }).Skip(page * PaginationInfo.PageSize)
                                  .Take(PaginationInfo.PageSize)
                                  .ToList();
            }
            else if (toaId != null && user.AdministrativeRajon == null)
            {
                return _context.NToaMain
                                .Where(m => m.Toa.Contains(toaId) && m.Tur == _izboriRepository.GetIzborTUR())
                                .Select(m => new RaionMainDTO
                {
                    Nrec = m.Nrec,
                    ToaId = m.Toa,
                    Name = m.Ime
                }).Skip(page * PaginationInfo.PageSize)
                  .Take(PaginationInfo.PageSize)
                  .ToList();
            }
            else if (toaId == null && user.AdministrativeRajon != null)
            {
                return _context.NToaMain.Where(m => m.Toa == user.AdministrativeRajon && m.Tur == _izboriRepository.GetIzborTUR())
                    .Select(m => new RaionMainDTO
                {
                    Nrec = m.Nrec,
                    ToaId = m.Toa,
                    Name = m.Ime
                }).Skip(page * PaginationInfo.PageSize)
                  .Take(PaginationInfo.PageSize)
                  .ToList();
            }
            else
            {
                return _context.NToaMain.Where(m => m.Toa == user.AdministrativeRajon 
                                                && m.Toa.Contains(toaId) 
                                                && m.Tur == _izboriRepository.GetIzborTUR())
                    .Select(m => new RaionMainDTO
                {
                    Nrec = m.Nrec,
                    ToaId = m.Toa,
                    Name = m.Ime
                }).Skip(page * PaginationInfo.PageSize)
                  .Take(PaginationInfo.PageSize)
                  .ToList();
            }
        }

        public int GetMaxRaioniMainPagesByUser(string userId, int page, string toaId)
        {
            var user = _context.Aspnetusers.FirstOrDefault(u => u.Id == userId);

            if (toaId == null && user.AdministrativeRajon == null)
            {
                return (int)Math.Ceiling(Convert.ToDouble(_context.NToaMain.Count()) / PaginationInfo.PageSize);
            }
            else if (toaId != null && user.AdministrativeRajon == null)
            {
                return (int)Math.Ceiling(Convert.ToDouble(_context.NToaMain.Where(m => m.Toa.Contains(toaId)).Count()) / PaginationInfo.PageSize);
            }
            else if (toaId == null && user.AdministrativeRajon != null)
            {
                return (int)Math.Ceiling(Convert.ToDouble(_context.NToaMain.Where(m => m.Toa == user.AdministrativeRajon).Count()) / PaginationInfo.PageSize);
            }
            else
            {
                return (int)Math.Ceiling(Convert.ToDouble(_context.NToaMain.Where(m => m.Toa.Contains(toaId) && m.Toa == user.AdministrativeRajon).Count()) / PaginationInfo.PageSize);
            }

        }

        public ICollection<AdministrativenRaionDto> GetAdmninistrativniRaioniByIzbRaion(string nkod)
        {

            if(nkod == "00")
            {
                return _context.Wntoa
                .Where(w => _context.WntoaIzbraion
                                    .Select(i => i.Nkod)
                                    .Contains(w.Nkod))
                .Select(w => new AdministrativenRaionDto
                {
                    Nkod = w.Nkod,
                    Nime = w.Nime
                }).ToList();
            }

            return _context.Wntoa
                .Where(w => _context.WntoaIzbraion
                                    .Where(i => i.IzbR == nkod)
                                    .Select(i => i.Nkod)
                                    .Contains(w.Nkod))
                .Select(w => new AdministrativenRaionDto {
                    Nkod = w.Nkod,
                    Nime = w.Nime
                }).ToList();
        }

        public int RegionHasBulstat(string nkod)
        {
            var raion = _context.NToaMain.FirstOrDefault(t => t.Toa == nkod && t.IzbAlias == _izboriRepository.GetIzborAlias() && t.Tur == _izboriRepository.GetIzborTUR());

            if (raion != null)
                return (string.IsNullOrEmpty(raion.Bul)?-1:0);
            else
                return -2;
        }

        public int GetIzbRaionMaxBroiSikByNime(string nime) => _context.WnIzbRaion.FirstOrDefault(i => i.Nime == nime).Max_Broi_Sik;

        public int GetIzbRaionMinBroiSikByNime(string nime) => _context.WnIzbRaion.FirstOrDefault(i => i.Nime == nime).Min_Broi_Sik;

        public string GetAdministrativenRaionIzbRaionNime(int nrec) => _context.NToaMain.FirstOrDefault(n => n.Nrec == nrec).R1;

        public int GetIzbRaionMinBroiSikByNkod(string nkod) => _context.WnIzbRaion.FirstOrDefault(i => i.Nkod == nkod).Min_Broi_Sik;

        public int GetIzbRaionMaxBroiSikByNkod(string nkod) => _context.WnIzbRaion.FirstOrDefault(i => i.Nkod == nkod).Max_Broi_Sik;

        public int GetAdministrativenRaionChlenove(string nkod) => _context.NToaMain.FirstOrDefault(a => a.Toa == nkod).Ano ?? 0;

        public ICollection<AdministrativenRaionWithIzbirateliDto> GetAdmninistrativniRaioniWithIzbirateliByIzbRaion(string nkod)
        {          
            return _context.Wntoa
                .Where(w => _context.WntoaIzbraion
                                    .Select(i => i.Nkod)
                                    .Contains(w.Nkod))
                .Select(w => new AdministrativenRaionWithIzbirateliDto
                        {
                            Toa = w.Nkod,
                            Ime = w.Nime,
                            Izbirateli = 0
                        })
                .ToList();   
        }

        public string GetIzbRaion(string toa) {
            var obj = from w1 in _context.WntoaIzbraion
                        join w2 in _context.WnIzbRaion
                            on w1.IzbR equals w2.Nkod
                      where w2.Izb_Alias == _izboriRepository.GetIzborAlias() && w2.Status==1                      
                       select new { w2.Nkod };
            return obj.FirstOrDefault().Nkod; 
        }        
    }
}
