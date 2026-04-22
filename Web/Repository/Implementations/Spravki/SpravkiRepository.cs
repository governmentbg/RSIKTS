namespace Repository.Implementations.Spravki
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Text;
    using Common.Enums.Spravki;
    using Common.Static;
    using Common.ViewModels.Spravki;
    using DataAccess;
    using DTO.Spravki;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.EntityFrameworkCore;
    using Novacode;
    using Repository.Interfaces.Izbori;
    using Repository.Interfaces.Spravki;

    public class SpravkiRepository : ISpravkiRepository
    {
        private readonly VotingRegisterContext _context;
        private readonly IIzboriRepository _izboriRepository;
        private readonly IHostingEnvironment _hostingEnvironment;

        public SpravkiRepository(VotingRegisterContext context, IIzboriRepository izboriRepository, IHostingEnvironment hostingEnvironment)
        {
            _context = context;
            _izboriRepository = izboriRepository;
            _hostingEnvironment = hostingEnvironment;
        }

        public ICollection<NomenklatureDTO> GetAllNomenklatures(int tip)
        {
            return _context.NNomenclatures
                .Where(n => n.Tip == tip && n.Status==1)
                .Select(n => new NomenklatureDTO
                    {
                        nomenklatureId = (NomenklatureIds)n.Id,
                        Description = n.Description
                    })
                .OrderBy(n => n.nomenklatureId)
                .ToList();
        }

        public ICollection<StatisticDTO> GetAllStatistics(int tip)
        {
            return _context.NStatistics.Where(s => s.Tip == tip).Select(s => new StatisticDTO
            {
                Id = s.Id,
                ShortDesctiption = s.Shortdescription,
                LongDescription = s.Longdescription
            }).ToList();
        }

        public ICollection<NomenklaturaBasicViewModel> GetNomenklatureBasicDetails(NomenklatureIds nomenklatureEnum, int page, string nameFilter, string administrativenRaion)
        {

            page -= 1;

            switch (nomenklatureEnum)
            {
                case NomenklatureIds.NaseleniMesta:
                    if (nameFilter == null)
                        return _context.Wnasm.Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Name = w.Nime
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.Wnasm.Where(w => w.Nime.Contains(nameFilter)).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.Ulici:
                    if (nameFilter == null)
                        return _context.Wnuli.Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Kod_Nas = w.WnasmNkod,
                            Kod_Ulica = w.WnuliNkod,
                            Name = w.Nime
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.Wnuli.Where(w => w.Nime.Contains(nameFilter)).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Kod_Nas = w.WnasmNkod,
                        Kod_Ulica = w.WnuliNkod,
                        Name = w.Nime
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.Oblasti:
                    if (nameFilter == null)
                        return _context.Wnobl.Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Name = w.Nime
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.Wnobl.Where(w => w.Nime.Contains(nameFilter)).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.Objini:
                    if (nameFilter == null)
                        return _context.Wnobs.Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Name = w.Nime
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.Wnobs.Where(w => w.Nime.Contains(nameFilter)).Where(w => w.Nime.Contains(nameFilter)).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.Raioni:
                    if (nameFilter == null)
                        return _context.Wntoa.Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Name = w.Nime
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.Wntoa.Where(w => w.Nime.Contains(nameFilter)).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.Kmetstva:
                    if (nameFilter == null)
                        return _context.Wnkmetstva.Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Name = w.Nime
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.Wnkmetstva.Where(w => w.Nime.Contains(nameFilter)).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.JilijenKompleks:
                    if (nameFilter == null)
                        return _context.WnjkKv.Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Name = w.Nime
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.WnjkKv.Where(w => w.Nime.Contains(nameFilter)).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.RaionnoUpravlenie:
                    if (nameFilter == null)
                        return _context.Wnnru.Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Name = w.Nime
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.Wnnru.Where(w => w.Nime.Contains(nameFilter)).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.Nacionalnosti:
                    if (nameFilter == null)
                        return _context.Wnnaz.Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Name = w.Nime
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.Wnnaz.Where(w => w.Nime.Contains(nameFilter)).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.Obrazovanie:
                    if (nameFilter == null)
                        return _context.Wnszem.Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Name = w.Nime
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.Wnszem.Where(w => w.Nime.Contains(nameFilter)).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.Specialnost:
                    if (nameFilter == null)
                        return _context.Wnspec.Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Name = w.Nime
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.Wnspec.Where(w => w.Nime.Contains(nameFilter)).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime,
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.Dokumenti:
                    if (nameFilter == null)
                        return _context.Wndocs.Where(n => n.IzbAlias == _izboriRepository.GetIzborAlias() && n.Toa == administrativenRaion).Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Name = w.Nime,
                            Status = (w.StatusNdocs ?? 0) > 0 ? true : false,
                            Has_Status = true
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.Wndocs.Where(w => w.Nime.Contains(nameFilter) && w.StatusNdocs == 1 && w.IzbAlias == _izboriRepository.GetIzborAlias() && w.Toa == administrativenRaion).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime,
                        Status = (w.StatusNdocs ?? 0) > 0 ? true : false,
                        Has_Status = true
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.PoliticheskiSili:
                    if (nameFilter == null)
                        return _context.Wnsila.Where(n => n.IzbAlias == _izboriRepository.GetIzborAlias()).Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkod,
                            Name = w.Nime,
                            ID_Party = w.IdParty,
                            Status = Convert.ToBoolean(w.StatusPartii ?? 0),
                            Has_Status = true
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.Wnsila.Where(w => w.Nime.Contains(nameFilter) &&  w.IzbAlias == _izboriRepository.GetIzborAlias()).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime,
                        ID_Party = w.IdParty,
                        Status = Convert.ToBoolean(w.StatusPartii ?? 0),
                        Has_Status = true
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                case NomenklatureIds.VidoveSekcii:
                    if (nameFilter == null)
                        return _context.NListCodepositions
                            .Where(w => w.Pkode == (int)CodeTables.VidoveSekcii && w.IzbAllias == _izboriRepository.GetIzborAlias())
                            .Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkode.ToString(),
                            Name = w.Nime,
                            Status = Convert.ToBoolean(w.Status ?? 0),
                            Has_Status = true
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize)
                        .OrderBy(c=>c.Code)
                        .ToList();

                    return _context.NListCodepositions.Where(w => w.Nime.Contains(nameFilter) && w.Pkode == (int)CodeTables.VidoveSekcii && w.Status == 1 && w.IzbAllias == _izboriRepository.GetIzborAlias()).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkode.ToString(),
                        Name = w.Nime,
                        Status = Convert.ToBoolean(w.Status ?? 0),
                        Has_Status = true
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize)
                    .OrderBy(c => c.Code)
                    .ToList();
                case NomenklatureIds.VidovePrazniciNaSekcii:
                    if (nameFilter == null)
                        return _context.NListCodepositions.Where(w => w.Pkode == (int)CodeTables.VidovePrazniciNaSekcii && w.IzbAllias == _izboriRepository.GetIzborAlias()).Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkode.ToString(),
                            Name = w.Nime,
                            Status = Convert.ToBoolean(w.Status ?? 0),
                            Has_Status = true
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize)
                        .OrderBy(c => c.Code)
                        .ToList();

                    return _context.NListCodepositions.Where(w => w.Nime.Contains(nameFilter) && w.Pkode == (int)CodeTables.VidovePrazniciNaSekcii && w.IzbAllias == _izboriRepository.GetIzborAlias()).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkode.ToString(),
                        Name = w.Nime,
                        Status = Convert.ToBoolean(w.Status ?? 0),
                        Has_Status = true
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize)
                    .OrderBy(c => c.Code)
                    .ToList();
                case NomenklatureIds.VidoveOperacii:
                    if (nameFilter == null)
                        return _context.NListCodepositions.Where(w => w.Pkode == (int)CodeTables.VidoveOperacii && w.IzbAllias == _izboriRepository.GetIzborAlias()).Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkode.ToString(),
                            Name = w.Nime,
                            Status = Convert.ToBoolean(w.Status ?? 0),
                            Has_Status = true
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize)
                        .OrderBy(c => c.Code)
                        .ToList();

                    return _context.NListCodepositions.Where(w => w.Nime.Contains(nameFilter) && w.Pkode == (int)CodeTables.VidoveOperacii && w.IzbAllias == _izboriRepository.GetIzborAlias()).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkode.ToString(),
                        Name = w.Nime,
                        Status = Convert.ToBoolean(w.Status ?? 0),
                        Has_Status = true
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize)
                    .OrderBy(c => c.Code)
                    .ToList();
                case NomenklatureIds.Roli:
                    if (nameFilter == null)
                        return _context.NListCodepositions.Where(w => w.Pkode == (int)CodeTables.Roli && w.IzbAllias == _izboriRepository.GetIzborAlias()).Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nkode.ToString(),
                            Name = w.Nime,
                            Status = Convert.ToBoolean(w.Status ?? 0),
                            Has_Status = true
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize)
                        .OrderBy(c => c.Code)
                        .ToList();

                    return _context.NListCodepositions.Where(w => w.Nime.Contains(nameFilter) && w.Pkode == (int)CodeTables.Roli && w.IzbAllias == _izboriRepository.GetIzborAlias()).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkode.ToString(),
                        Name = w.Nime,
                        Status = Convert.ToBoolean(w.Status ?? 0),
                        Has_Status = true
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize)
                    .OrderBy(c => c.Code)
                    .ToList();
                case NomenklatureIds.DanuchniParametri:
                    if (nameFilter == null)
                        return _context.NTopDancoef.Where(d => d.IzbAllias == _izboriRepository.GetIzborAlias()).Select(w => new NomenklaturaBasicViewModel
                        {
                            Code = w.Nred,
                            Name = w.Tekst,
                            Stoinost = w.CoefStoinost ?? 0,
                            Status = Convert.ToBoolean(w.StatusCoef ?? 0)
                        }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();

                    return _context.NTopDancoef.Where(d => d.Nred.Contains(nameFilter) && d.IzbAllias == _izboriRepository.GetIzborAlias()).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nred,
                        Name = w.Tekst,
                        Stoinost = w.CoefStoinost ?? 0,
                        Status = Convert.ToBoolean(w.StatusCoef ?? 0)
                    }).Skip(page * PaginationInfo.PageSize).Take(PaginationInfo.PageSize).ToList();
                default:
                    return new List<NomenklaturaBasicViewModel>();
            }
        }

        public NomenklatureEditFullViewModel GetNomenklatureEdit(NomenklatureIds nomenklatureEnum, string nomenklatureCode, int id)
        {
            switch (nomenklatureEnum)
            {
                case NomenklatureIds.NaseleniMesta:
                    return _context.Wnasm.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.Ulici:
                    return _context.Wnuli.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime,
                        Kod_Nas = w.WnasmNkod,
                        Kod_Ulica = w.WnuliNkod,
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.Oblasti:
                    return _context.Wnobl.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.Objini:
                    return _context.Wnobs.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.Raioni:
                    return _context.Wntoa.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.Kmetstva:
                    return _context.Wnkmetstva.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.JilijenKompleks:
                    return _context.WnjkKv.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.RaionnoUpravlenie:
                    return _context.Wnnru.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.Nacionalnosti:
                    return _context.Wnnaz.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.Obrazovanie:
                    return _context.Wnszem.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.Specialnost:
                    return _context.Wnspec.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.Dokumenti:
                    return _context.Wndocs.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime,
                        Izb_Alias = w.IzbAlias,
                        Status = (w.StatusNdocs ?? 0) > 0 ? true : false
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.PoliticheskiSili:
                    return _context.Wnsila.Select(w => new NomenklatureEditFullViewModel
                    {
                        ID_Party = w.IdParty,
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkod,
                        Nime = w.Nime,
                        Short_Name = w.ShortName,
                        Legal_Code = w.LegalKod,
                        Status = (w.StatusPartii ?? 0) > 0 ? true : false
                    }).FirstOrDefault(w => w.ID_Party == id);
                case NomenklatureIds.VidoveSekcii:
                    return _context.NListCodepositions.Where(w => w.Pkode == (int) CodeTables.VidoveSekcii).Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkode.ToString(),
                        Nime = w.Nime,
                        Status = (w.Status ?? 0) > 0 ? true : false
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.VidovePrazniciNaSekcii:
                    return _context.NListCodepositions.Where(w => w.Pkode == (int)CodeTables.VidovePrazniciNaSekcii).Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkode.ToString(),
                        Nime = w.Nime,
                        Status = (w.Status ?? 0) > 0 ? true : false
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.VidoveOperacii:
                    return _context.NListCodepositions.Where(w => w.Pkode == (int)CodeTables.VidoveOperacii).Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkode.ToString(),
                        Nime = w.Nime,
                        Status = (w.Status ?? 0) > 0 ? true : false
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.Roli:
                    return _context.NListCodepositions.Where(w => w.Pkode == (int)CodeTables.Roli).Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nkode.ToString(),
                        Nime = w.Nime,
                        Status = (w.Status ?? 0) > 0 ? true : false
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                case NomenklatureIds.DanuchniParametri:
                    return _context.NTopDancoef.Select(w => new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Nkod = w.Nred.ToString(),
                        Nime = w.Tekst,
                        Stoinost = w.CoefStoinost ?? 0,
                        Status = (w.StatusCoef ?? 0) > 0 ? true : false
                    }).FirstOrDefault(w => w.Nkod == nomenklatureCode);
                default:
                    return new NomenklatureEditFullViewModel();
            }
        }

        public NomenklatureEditFullViewModel GetNomenklatureAdd(NomenklatureIds nomenklatureEnum)
        {
            switch (nomenklatureEnum)
            {
                case NomenklatureIds.PoliticheskiSili:
                    return new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Has_Short_Name = true,
                        Has_Legal_Code = true,
                        Has_Status = true
                    };
                case NomenklatureIds.Ulici:
                    return new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Has_Kod_Ulica = true,
                        Has_Kod_Nas = true
                    };
                case NomenklatureIds.Dokumenti:
                    return new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Has_Status = true
                    };
                case NomenklatureIds.VidoveSekcii:
                    return new NomenklatureEditFullViewModel
                    {
                        Pkode  = 1,
                        NomenklatureId = nomenklatureEnum,
                        Has_Pkode = true,
                        Has_Status = true,
                        Status = false
                    };
                case NomenklatureIds.VidovePrazniciNaSekcii:
                    return new NomenklatureEditFullViewModel
                    {
                        Pkode = 2,
                        NomenklatureId = nomenklatureEnum,
                        Has_Pkode = true,
                        Has_Status = true,
                        Status = false
                    };
                case NomenklatureIds.VidoveOperacii:
                    return new NomenklatureEditFullViewModel
                    {
                        Pkode = 3,
                        NomenklatureId = nomenklatureEnum,
                        Has_Pkode = true,
                        Has_Status = true,
                        Status = false
                    };
                case NomenklatureIds.Roli:
                    return new NomenklatureEditFullViewModel
                    {
                        Pkode = 4,
                        NomenklatureId = nomenklatureEnum,
                        Has_Pkode = true,
                        Has_Status = true,
                        Status = false
                    };
                case NomenklatureIds.DanuchniParametri:
                    return new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                        Has_Status = true,
                        Has_Stoinost = true
                    };
                default:
                    return new NomenklatureEditFullViewModel
                    {
                        NomenklatureId = nomenklatureEnum,
                    };
            }
        }

        public void NomenklatureAdd(NomenklatureEditFullViewModel model, string administrativenRaion)
        {
            switch (model.NomenklatureId)
            {
                case NomenklatureIds.NaseleniMesta:
                    if(_context.Wnasm.Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.Wnasm.Add(new Wnasm
                    {
                        Nkod = model.Nkod,
                        Nime = model.Nime
                    });
                    break;
                case NomenklatureIds.Ulici:
                    if (_context.Wnuli.Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.Wnuli.Add(new Wnuli
                    {
                        Nkod = Convert.ToInt32(_context.Wnuli.Last().Nkod + 1).ToString().PadLeft(5, '0'),
                        Nime = model.Nime,
                        WnasmNkod = model.Kod_Nas,
                        WnuliNkod = model.Kod_Ulica
                    });
                    break;
                case NomenklatureIds.Oblasti:
                    if (_context.Wnobl.Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.Wnobl.Add(new Wnobl
                    {
                        Nkod = model.Nkod,
                        Nime = model.Nime
                    });
                    break;
                case NomenklatureIds.Objini:
                    if (_context.Wnobs.Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.Wnobs.Add(new Wnobs
                    {
                        Nkod = model.Nkod,
                        Nime = model.Nime
                    });
                    break;
                case NomenklatureIds.Raioni:
                    if (_context.Wntoa.Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.Wntoa.Add(new Wntoa
                    {
                        Nkod = model.Nkod,
                        Nime = model.Nime
                    });
                    break;
                case NomenklatureIds.Kmetstva:
                    if (_context.Wnkmetstva.Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.Wnkmetstva.Add(new Wnkmetstva
                    {
                        Nkod = model.Nkod,
                        Nime = model.Nime
                    });
                    break;
                case NomenklatureIds.JilijenKompleks:
                    if (_context.WnjkKv.Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.WnjkKv.Add(new WnjkKv
                    {
                        Nkod = model.Nkod,
                        Nime = model.Nime
                    });
                    break;
                case NomenklatureIds.RaionnoUpravlenie:
                    if (_context.Wnnru.Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.Wnnru.Add(new Wnnru
                    {
                        Nkod = model.Nkod,
                        Nime = model.Nime
                    });
                    break;
                case NomenklatureIds.Obrazovanie:
                    if (_context.Wnszem.Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.Wnszem.Add(new Wnszem
                    {
                        Nkod = model.Nkod,
                        Nime = model.Nime
                    });
                    break;
                case NomenklatureIds.Specialnost:
                    if (_context.Wnspec.Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.Wnspec.Add(new Wnspec
                    {
                        Nkod = model.Nkod,
                        Nime = model.Nime
                    });
                    break;
                case NomenklatureIds.Nacionalnosti:
                    if (_context.Wnnaz.Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.Wnnaz.Add(new Wnnaz
                    {
                        Nkod = model.Nkod,
                        Nime = model.Nime
                    });
                    break;

                case NomenklatureIds.Dokumenti:
                    if (_context.Wndocs.Where(w => w.IzbAlias == _izboriRepository.GetIzborAlias()).Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.Wndocs.Add(new Wndocs
                    {
                        Nkod = Guid.NewGuid().ToString(),
                        Nime = model.Nime,
                        IzbAlias = _izboriRepository.GetIzborAlias(),
                        StatusNdocs = model.Status_ndocs,
                        Toa = administrativenRaion
                    });
                    break;

                case NomenklatureIds.PoliticheskiSili:
                    if (_context.Wnsila.Where(w => w.IzbAlias == _izboriRepository.GetIzborAlias()).Any(w => w.Nkod == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.Wnsila.Add(new Wnsila
                    {
                        IzbAlias = _izboriRepository.GetIzborAlias(),
                        Nkod = model.Nkod,
                        Nime = model.Nime,
                        ShortName = model.Short_Name,
                        LegalKod = model.Legal_Code,
                        StatusPartii = model.Status_Partii
                    });
                    break;
                case NomenklatureIds.VidoveSekcii:
                    if (_context.NListCodepositions.Any(w => w.Nkode == Convert.ToInt32(model.Nkod)))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.NListCodepositions.Add(new NListCodepositions
                    {
                        IzbAllias = _izboriRepository.GetIzborAlias(),
                        Nkode = Convert.ToInt32(model.Nkod),
                        Nime = model.Nime,
                        Pkode = model.Pkode
                    });
                    break;
                case NomenklatureIds.VidovePrazniciNaSekcii:
                    if (_context.NListCodepositions.Any(w => w.Nkode == Convert.ToInt32(model.Nkod)))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.NListCodepositions.Add(new NListCodepositions
                    {
                        IzbAllias = _izboriRepository.GetIzborAlias(),
                        Nkode = Convert.ToInt32(model.Nkod),
                        Nime = model.Nime,
                        Pkode = model.Pkode
                    });
                    break;
                case NomenklatureIds.VidoveOperacii:
                    if (_context.NListCodepositions.Any(w => w.Nkode == Convert.ToInt32(model.Nkod)))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.NListCodepositions.Add(new NListCodepositions
                    {
                        IzbAllias = _izboriRepository.GetIzborAlias(),
                        Nkode = Convert.ToInt32(model.Nkod),
                        Nime = model.Nime,
                        Pkode = model.Pkode
                    });
                    break;
                case NomenklatureIds.Roli:
                    if (_context.NListCodepositions.Any(w => w.Nkode == Convert.ToInt32(model.Nkod)))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.NListCodepositions.Add(new NListCodepositions
                    {
                        IzbAllias = _izboriRepository.GetIzborAlias(),
                        Nkode = Convert.ToInt32(model.Nkod),
                        Nime = model.Nime,
                        Pkode = model.Pkode
                    });
                    break;
                case NomenklatureIds.DanuchniParametri:
                    if (_context.NTopDancoef.Any(w => w.Nred == model.Nkod))
                    {
                        throw new ArgumentException("Дублиран код в базата.");
                    }

                    _context.NTopDancoef.Add(new NTopDancoef
                    {
                        IzbAllias = _izboriRepository.GetIzborAlias(),
                        Nred = model.Nkod,
                        Tekst = model.Nime,
                        CoefStoinost = model.Stoinost,
                        StatusCoef = Convert.ToInt32(model.Status)
                    });
                    break;

            }

            _context.SaveChanges();
        }

        public void NomenklatureDelete(NomenklatureIds nomenklatureEnum, string nomenklatureCode, int id)
        {
            switch (nomenklatureEnum)
            {
                case NomenklatureIds.NaseleniMesta:
                    var entityToRemoveNaseleNimesta = _context.Wnasm.FirstOrDefault(w => w.Nkod == nomenklatureCode);
                    _context.Wnasm.Remove(entityToRemoveNaseleNimesta);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Ulici:
                    var entityToRemoveUlici = _context.Wnuli.FirstOrDefault(w => w.Nkod == nomenklatureCode);
                    _context.Wnuli.Remove(entityToRemoveUlici);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Oblasti:
                    var entityToRemoveOblasti = _context.Wnobl.FirstOrDefault(w => w.Nkod == nomenklatureCode);
                    _context.Wnobl.Remove(entityToRemoveOblasti);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Objini:
                    var entityToRemoveObjini = _context.Wnobs.FirstOrDefault(w => w.Nkod == nomenklatureCode);
                    _context.Wnobs.Remove(entityToRemoveObjini);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Raioni:
                    var entityToRemoveRaioni = _context.Wntoa.FirstOrDefault(w => w.Nkod == nomenklatureCode);
                    _context.Wntoa.Remove(entityToRemoveRaioni);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Kmetstva:
                    var entityToRemoveKmetstva = _context.Wnkmetstva.FirstOrDefault(w => w.Nkod == nomenklatureCode);
                    _context.Wnkmetstva.Remove(entityToRemoveKmetstva);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.JilijenKompleks:
                    var entityToRemoveJilijenKompleks = _context.WnjkKv.FirstOrDefault(w => w.Nkod == nomenklatureCode);
                    _context.WnjkKv.Remove(entityToRemoveJilijenKompleks);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.RaionnoUpravlenie:
                    var entityToRemoveRaionnoUpravlenie = _context.Wnnru.FirstOrDefault(w => w.Nkod == nomenklatureCode);
                    _context.Wnnru.Remove(entityToRemoveRaionnoUpravlenie);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Nacionalnosti:
                    var entityToRemoveNacionalnosti = _context.Wnnaz.FirstOrDefault(w => w.Nkod == nomenklatureCode);
                    _context.Wnnaz.Remove(entityToRemoveNacionalnosti);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Obrazovanie:
                    var entityToRemoveObrazovanie = _context.Wnszem.FirstOrDefault(w => w.Nkod == nomenklatureCode);
                    _context.Wnszem.Remove(entityToRemoveObrazovanie);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Specialnost:
                    var entityToRemoveSpecialnost = _context.Wnspec.FirstOrDefault(w => w.Nkod == nomenklatureCode);
                    _context.Wnspec.Remove(entityToRemoveSpecialnost);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Dokumenti:
                    var entityToRemoveDokumenti = _context.Wndocs.FirstOrDefault(w => w.Nkod == nomenklatureCode);
                    _context.Wndocs.Remove(entityToRemoveDokumenti);
                    //entityToRemoveDokumenti.StatusNdocs = 0;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.PoliticheskiSili:
                    var entityToRemovePoliticheskiSili = _context.Wnsila.FirstOrDefault(w => w.IdParty == id);
                    _context.Wnsila.Remove(entityToRemovePoliticheskiSili);
                    //entityToRemovePoliticheskiSili.StatusPartii = 0;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.VidoveSekcii:
                    var entityToRemoveVidoveSekcii = _context.NListCodepositions.FirstOrDefault(w => w.Nkode.ToString() == nomenklatureCode);
                    _context.NListCodepositions.Remove(entityToRemoveVidoveSekcii);
//                    entityToRemoveVidoveSekcii.Status = 0;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.VidovePrazniciNaSekcii:
                    var entityToRemoveVidovePrazniciNaSekcii = _context.NListCodepositions.FirstOrDefault(w => w.Nkode.ToString() == nomenklatureCode);
                    _context.NListCodepositions.Remove(entityToRemoveVidovePrazniciNaSekcii);
//                    entityToRemoveVidovePrazniciNaSekcii.Status = 0;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.VidoveOperacii:
                    var entityToRemoveVidoveOperacii = _context.NListCodepositions.FirstOrDefault(w => w.Nkode.ToString() == nomenklatureCode);
                    _context.NListCodepositions.Remove(entityToRemoveVidoveOperacii);
//                  entityToRemoveVidoveOperacii.Status = 0;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Roli:
                    var entityToRemoveRoli = _context.NListCodepositions.FirstOrDefault(w => w.Nkode.ToString() == nomenklatureCode);
                    _context.NListCodepositions.Remove(entityToRemoveRoli);
//                  entityToRemoveRoli.Status = 0;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.DanuchniParametri:
                    var entityToRemoveDanuchniParametri = _context.NTopDancoef.FirstOrDefault(w => w.Nred == nomenklatureCode);
                    entityToRemoveDanuchniParametri.StatusCoef = 0;
                    _context.SaveChanges();
                    break;
            }
        }

        public void NomenklatureEdit(NomenklatureEditFullViewModel editModel)
        {
            switch (editModel.NomenklatureId)
            {
                case NomenklatureIds.NaseleniMesta:
                    var nomenklatureNaseleNimesta = _context.Wnasm.FirstOrDefault(w => w.Nkod == editModel.Nkod);
                    nomenklatureNaseleNimesta.Nime = editModel.Nime;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Ulici:
                    var nomenklatureUlici = _context.Wnuli.FirstOrDefault(w => w.Nkod == editModel.Nkod);
                    nomenklatureUlici.Nime = editModel.Nime;
                    nomenklatureUlici.WnasmNkod = editModel.Kod_Nas;
                    nomenklatureUlici.WnuliNkod = editModel.Kod_Ulica;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Oblasti:
                    var nomenklatureOblasti = _context.Wnobl.FirstOrDefault(w => w.Nkod == editModel.Nkod);
                    nomenklatureOblasti.Nime = editModel.Nime;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Objini:
                    var nomenklatureObjini = _context.Wnobs.FirstOrDefault(w => w.Nkod == editModel.Nkod);
                    nomenklatureObjini.Nime = editModel.Nime;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Raioni:
                    var nomenklatureRaioni = _context.Wntoa.FirstOrDefault(w => w.Nkod == editModel.Nkod);
                    nomenklatureRaioni.Nime = editModel.Nime;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Kmetstva:
                    var nomenklatureKmetstva = _context.Wnkmetstva.FirstOrDefault(w => w.Nkod == editModel.Nkod);
                    nomenklatureKmetstva.Nime = editModel.Nime;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.JilijenKompleks:
                    var nomenklatureJilijenKompleks = _context.WnjkKv.FirstOrDefault(w => w.Nkod == editModel.Nkod);
                    nomenklatureJilijenKompleks.Nime = editModel.Nime;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.RaionnoUpravlenie:
                    var nomenklatureRaionnoUpravlenie = _context.Wnnru.FirstOrDefault(w => w.Nkod == editModel.Nkod);
                    nomenklatureRaionnoUpravlenie.Nime = editModel.Nime;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Nacionalnosti:
                    var nomenklatureNacionalnosti = _context.Wnnaz.FirstOrDefault(w => w.Nkod == editModel.Nkod);
                    nomenklatureNacionalnosti.Nime = editModel.Nime;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Obrazovanie:
                    var nomenklatureObrazovanie = _context.Wnszem.FirstOrDefault(w => w.Nkod == editModel.Nkod);
                    nomenklatureObrazovanie.Nime = editModel.Nime;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Specialnost:
                    var nomenklatureSpecialnost = _context.Wnspec.FirstOrDefault(w => w.Nkod == editModel.Nkod);
                    nomenklatureSpecialnost.Nime = editModel.Nime;
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Dokumenti:
                    var nomenklatureDokumenti = _context.Wndocs.FirstOrDefault(w => w.Nkod == editModel.Nkod);
                    nomenklatureDokumenti.Nime = editModel.Nime;
                    nomenklatureDokumenti.StatusNdocs = Convert.ToByte(editModel.Status);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.PoliticheskiSili:
                    var nomenklaturePoliticheskiSili = _context.Wnsila.FirstOrDefault(w => w.IdParty == editModel.ID_Party);
                    nomenklaturePoliticheskiSili.Nime = editModel.Nime;
                    nomenklaturePoliticheskiSili.LegalKod = editModel.Legal_Code;
                    nomenklaturePoliticheskiSili.ShortName = editModel.Short_Name;
                    nomenklaturePoliticheskiSili.StatusPartii = Convert.ToByte(editModel.Status);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.VidoveSekcii:
                    var nomenklatureVidoveSekcii = _context.NListCodepositions.FirstOrDefault(w => w.Nkode.ToString() == editModel.Nkod);
                    nomenklatureVidoveSekcii.Nime = editModel.Nime;
                    nomenklatureVidoveSekcii.Status = Convert.ToInt32(editModel.Status);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.VidovePrazniciNaSekcii:
                    var nomenklatureVidovePrazniciNaSekcii = _context.NListCodepositions.FirstOrDefault(w => w.Nkode.ToString() == editModel.Nkod);
                    nomenklatureVidovePrazniciNaSekcii.Nime = editModel.Nime;
                    nomenklatureVidovePrazniciNaSekcii.Status = Convert.ToInt32(editModel.Status);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.VidoveOperacii:
                    var nomenklatureVidoveOperacii = _context.NListCodepositions.FirstOrDefault(w => w.Nkode.ToString() == editModel.Nkod);
                    nomenklatureVidoveOperacii.Nime = editModel.Nime;
                    nomenklatureVidoveOperacii.Status = Convert.ToInt32(editModel.Status);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.Roli:
                    var nomenklatureRoli = _context.NListCodepositions.FirstOrDefault(w => w.Nkode.ToString() == editModel.Nkod);
                    nomenklatureRoli.Nime = editModel.Nime;
                    nomenklatureRoli.Status = Convert.ToInt32(editModel.Status);
                    _context.SaveChanges();
                    break;
                case NomenklatureIds.DanuchniParametri:
                    var nomenklatureDanuchniParametri = _context.NTopDancoef.FirstOrDefault(w => w.Nred.ToString() == editModel.Nkod);
                    nomenklatureDanuchniParametri.Tekst = editModel.Nime;
                    nomenklatureDanuchniParametri.StatusCoef = Convert.ToInt32(editModel.Status);
                    nomenklatureDanuchniParametri.CoefStoinost = editModel.Stoinost;
                    _context.SaveChanges();
                    break;
                default:
                    break;
            }
        }

        public int GetNumenklatureMaxPages(NomenklatureIds nomenklatureEnum, string nameFilter, string administrativenRaion)
        {
            switch (nomenklatureEnum)
            {
                case NomenklatureIds.NaseleniMesta:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.Wnasm.Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.Wnasm.Where(w => w.Nime.Contains(nameFilter)).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.Ulici:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.Wnuli.Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.Wnuli.Where(w => w.Nime.Contains(nameFilter)).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.Oblasti:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.Wnobl.Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.Wnobl.Where(w => w.Nime.Contains(nameFilter)).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.Objini:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.Wnobs.Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.Wnobs.Where(w => w.Nime.Contains(nameFilter)).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.Raioni:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.Wntoa.Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.Wntoa.Where(w => w.Nime.Contains(nameFilter)).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.Kmetstva:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.Wnkmetstva.Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.Wnkmetstva.Where(w => w.Nime.Contains(nameFilter)).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.JilijenKompleks:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.WnjkKv.Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.WnjkKv.Where(w => w.Nime.Contains(nameFilter)).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.RaionnoUpravlenie:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.Wnnru.Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.Wnnru.Where(w => w.Nime.Contains(nameFilter)).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.Nacionalnosti:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.Wnnaz.Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.Wnnaz.Where(w => w.Nime.Contains(nameFilter)).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.Obrazovanie:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.Wnszem.Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.Wnszem.Where(s => s.Nime.Contains(nameFilter)).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.Specialnost:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.Wnspec.Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.Wnspec.Where(s => s.Nime.Contains(nameFilter)).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.Dokumenti:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.Wndocs.Where(n =>n.IzbAlias == _izboriRepository.GetIzborAlias() && n.Toa == administrativenRaion).Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.Wndocs.Where(m => m.Nime.Contains(nameFilter) && m.StatusNdocs == 1 && m.IzbAlias == _izboriRepository.GetIzborAlias() && m.Toa == administrativenRaion).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.PoliticheskiSili:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.Wnsila.Where(n =>n.IzbAlias == _izboriRepository.GetIzborAlias()).Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.Wnsila.Where(s => s.Nime.Contains(nameFilter) && s.StatusPartii == 1 && s.IzbAlias == _izboriRepository.GetIzborAlias()).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.VidoveSekcii:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.NListCodepositions.Where(n => n.Pkode == (int)CodeTables.VidoveSekcii && n.IzbAllias == _izboriRepository.GetIzborAlias()).Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.NListCodepositions.Where(n => n.Nime.Contains(nameFilter) && n.Pkode == (int)CodeTables.Roli && n.Status == 1 && n.IzbAllias == _izboriRepository.GetIzborAlias()).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.VidovePrazniciNaSekcii:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.NListCodepositions.Where(n => n.Pkode == (int)CodeTables.VidovePrazniciNaSekcii && n.IzbAllias == _izboriRepository.GetIzborAlias()).Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.NListCodepositions.Where(n => n.Nime.Contains(nameFilter) && n.Pkode == (int)CodeTables.Roli && n.Status == 1 && n.IzbAllias == _izboriRepository.GetIzborAlias()).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.VidoveOperacii:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.NListCodepositions.Where(n => n.Pkode == (int)CodeTables.VidoveOperacii && n.IzbAllias == _izboriRepository.GetIzborAlias()).Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.NListCodepositions.Where(n => n.Nime.Contains(nameFilter) && n.Pkode == (int)CodeTables.Roli && n.Status == 1 && n.IzbAllias == _izboriRepository.GetIzborAlias()).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.Roli:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.NListCodepositions.Where(n => n.Pkode == (int)CodeTables.Roli && n.IzbAllias == _izboriRepository.GetIzborAlias()).Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.NListCodepositions.Where(n => n.Nime.Contains(nameFilter) && n.Pkode == (int)CodeTables.Roli && n.Status == 1 && n.IzbAllias == _izboriRepository.GetIzborAlias()).Count() / PaginationInfo.PageSize);
                case NomenklatureIds.DanuchniParametri:
                    if (nameFilter == null)
                        return (int)Math.Ceiling((double)_context.NTopDancoef.Where(d => d.IzbAllias == _izboriRepository.GetIzborAlias()).Count() / PaginationInfo.PageSize);

                    return (int)Math.Ceiling((double)_context.NTopDancoef.Where(d => d.Nred.Contains(nameFilter) && d.IzbAllias == _izboriRepository.GetIzborAlias()).Count() / PaginationInfo.PageSize);
                default:
                    return 0;
            }
        }

        public ICollection<NomenklaturaBasicViewModel> GetAllNomeklatureBasicDetails(NomenklatureIds nomenklatureEnum, string administrativenRaion)
        {
            switch (nomenklatureEnum)
            {
                case NomenklatureIds.Dokumenti:
                    return _context.Wndocs.Where(d => d.Toa == administrativenRaion && d.IzbAlias == _izboriRepository.GetIzborAlias()).Select(w => new NomenklaturaBasicViewModel
                    {
                        Code = w.Nkod,
                        Name = w.Nime
                    }).OrderBy(c=>c.Code)
                    .ToList();
                default:
                    return new List<NomenklaturaBasicViewModel>();
            }
        }

        public string GetMsbStatisticContents(GenerateReportViewModel model, string userId)
        {

            var userReports = new List<MsbStatistic>();

            if(model.Seleciq == 0)
            {
                foreach (var liceId in model.AllLicaIds) {

                    userReports.Add(_context.MsbStatistics.FromSql("CALL spravka_MSB1(@p0, @p1, @p2, @p3)",
                        liceId,
                        _izboriRepository.GetIzborTUR(),
                        userId,
                        CryptoConstants.CryptoKey
                    ).First());
                }
            }

            if (model.Seleciq == 1)
            {
                var nonSelectedLica = model.AllLicaIds.Where(l => !model.LicaIds.Contains(l)).ToArray();

                foreach (var liceId in nonSelectedLica)
                {

                    userReports.Add(_context.MsbStatistics.FromSql("CALL spravka_MSB1(@p0, @p1, @p2, @p3)",
                        liceId,
                        _izboriRepository.GetIzborTUR(),
                        userId,
                        CryptoConstants.CryptoKey
                    ).First());
                }
            }

            if (model.Seleciq == 2)
            {
                foreach (var liceId in model.LicaIds)
                {

                    userReports.Add(_context.MsbStatistics.FromSql("CALL spravka_MSB1(@p0, @p1, @p2, @p3)",
                        liceId,
                        _izboriRepository.GetIzborTUR(),
                        userId,
                        CryptoConstants.CryptoKey
                    ).First());
                }
            }
            
            var path = Path.Combine(_hostingEnvironment.WebRootPath, "templates", "MSB1.rtf");

            var documentTemplate = DocX.Create("MSB1.rtf");

            foreach (var user in userReports)
            {
                var persdoc = DocX.Load(path);
                persdoc.ReplaceText("/izr_rajon/", user.Izr_Rajon.ToString());
                persdoc.ReplaceText("/lica_izbori_re/", user.Lica_Izbori_Re);
                persdoc.ReplaceText("/lica_fullname/", user.Lica_Fullname);
                persdoc.ReplaceText("/lica_egn/", user.Lica_Egn);
                persdoc.ReplaceText("/lica_izbori_rolia/", user.Lica_Izbori_Rolia);
                persdoc.ReplaceText("/siks_fullcode/", user.Siks_Fullcode);
                persdoc.ReplaceText("/siks_kmet/", user.Siks_Kmet);
                persdoc.ReplaceText("/siks_nas/", user.Siks_Nas);
                persdoc.ReplaceText("/siks_toa/", user.Siks_Toa);
                persdoc.ReplaceText("/n_top_main_description/", user.N_Top_Main_Description);
                persdoc.ReplaceText("/n_top_main_datetur/", user.N_Top_Main_Datetur);
                persdoc.ReplaceText("/n_toa_main_epod/", user.N_Toa_Main_Epod);

                documentTemplate.InsertDocument(persdoc);

            }

            var guid = new Guid();

            guid = Guid.NewGuid();

            documentTemplate.SaveAs(Path.Combine(_hostingEnvironment.WebRootPath, "templates").ToString() + "/"+ Statistics.MSB.EnumDescription() + "_" + guid.ToString() + ".rtf");

            return guid.ToString();

        }

        public string GetMorsStatisticContents(GenerateReportViewModel model, string userId)
        {

            var userReports = new List<MorsStatistic>();

            if (model.Seleciq == 0)
            {
                foreach (var liceId in model.AllLicaIds)
                {

                    userReports.Add(_context.MorsStatistics.FromSql("CALL spravka_MORS(@p0, @p1, @p2, @p3)",
                        liceId,
                        model.Tur,
                        userId,
                        CryptoConstants.CryptoKey
                    ).First());
                }
            }

            if (model.Seleciq == 1)
            {
                var nonSelectedLica = model.AllLicaIds.Where(l => !model.LicaIds.Contains(l)).ToArray();

                foreach (var liceId in nonSelectedLica)
                {

                    userReports.Add(_context.MorsStatistics.FromSql("CALL spravka_MORS(@p0, @p1, @p2, @p3)",
                        liceId,
                        model.Tur,
                        userId,
                        CryptoConstants.CryptoKey
                    ).First());
                }
            }

            if (model.Seleciq == 2)
            {
                foreach (var liceId in model.LicaIds)
                {

                    userReports.Add(_context.MorsStatistics.FromSql("CALL spravka_MORS(@p0, @p1, @p2, @p3)",
                        liceId,
                        model.Tur,
                        userId,
                        CryptoConstants.CryptoKey
                    ).First());
                }
            }

            var path = Path.Combine(_hostingEnvironment.WebRootPath, "templates", "MORS.rtf");

            var documentTemplate = DocX.Create("MORS.rtf");

            foreach (var user in userReports)
            {
                var persdoc = DocX.Load(path);
                persdoc.ReplaceText("/izr_rajon/", user.Izr_Rajon.ToString());
                persdoc.ReplaceText("/lica_fullname/", user.Lica_Fullname);
                persdoc.ReplaceText("/lica_egn/", user.Lica_Egn);
                persdoc.ReplaceText("/n_toa_main_bul/", (user.N_Toa_Main_Bul != null ? user.N_Toa_Main_Bul : ""));
                persdoc.ReplaceText("/n_top_main_description/", user.N_Top_Main_Description);
                persdoc.ReplaceText("/n_top_main_datetur/", user.N_Top_Main_Datetur);
                persdoc.ReplaceText("/siks_fullcode/", user.Siks_Fullcode);
                persdoc.ReplaceText("/suma/", user.Suma.ToString());
                persdoc.ReplaceText("/slovom/", user.Slovom);

                documentTemplate.InsertDocument(persdoc);

            }

            var guid = new Guid();

            guid = Guid.NewGuid();

            documentTemplate.SaveAs(Path.Combine(_hostingEnvironment.WebRootPath, "templates").ToString() + "/" + Statistics.MORS.EnumDescription() + "_" + guid.ToString() + ".rtf");

            return guid.ToString();

        }

        public string GetMudoStatisticContents(GenerateReportViewModel model, string userId)
        {

            var userReports = new List<MudoStatistic>();

            if (model.Seleciq == 0)
            {
                foreach (var liceId in model.AllLicaIds)
                {

                    var lice = _context.MudoStatistics.FromSql("CALL spravka_MUDO(@p0, @p1, @p2, @p3)",
                                 liceId,
                                  _izboriRepository.GetIzborTUR(),
                                 userId,
                                 CryptoConstants.CryptoKey
                             ).First();

                    if (lice.Izr_Rajon.Length > 0)
                        userReports.Add(lice);

                }
            }

            if (model.Seleciq == 1)
            {
                var nonSelectedLica = model.AllLicaIds.Where(l => !model.LicaIds.Contains(l)).ToArray();

                foreach (var liceId in nonSelectedLica)
                {

                    var lice = _context.MudoStatistics.FromSql("CALL spravka_MUDO(@p0, @p1, @p2, @p3)",
                                      liceId,
                                       _izboriRepository.GetIzborTUR(),
                                      userId,
                                      CryptoConstants.CryptoKey
                                  ).First();

                    if (lice.Izr_Rajon.Length > 0)
                        userReports.Add(lice);

                }
            }

            if (model.Seleciq == 2)
            {
                foreach (var liceId in model.LicaIds)
                {

                    var lice = _context.MudoStatistics.FromSql("CALL spravka_MUDO(@p0, @p1, @p2, @p3)",
                                    liceId,
                                     _izboriRepository.GetIzborTUR(),
                                    userId,
                                    CryptoConstants.CryptoKey
                                ).First();

                    if (lice.Izr_Rajon.Length>0)
                        userReports.Add(lice);
                }
            }

            var path = Path.Combine(_hostingEnvironment.WebRootPath, "templates", "MUDO.rtf");

            var documentTemplate = DocX.Create("MUDO.rtf");

            int cnt = 0;
            foreach (var user in userReports)
            {
                cnt++;
                var persdoc = DocX.Load(path);

                persdoc.ReplaceText("/izr_rajon/", user.Izr_Rajon.ToString());
                persdoc.ReplaceText("/udocnom/", user.Udocnom.ToString());
                persdoc.ReplaceText("/lica_izbori_re/", user.Lica_Izbori_Re);
                persdoc.ReplaceText("/lica_fullname/", user.Lica_Fullname);
                persdoc.ReplaceText("/lica_egn/", user.Lica_Egn);
                persdoc.ReplaceText("/lica_izbori _rolia/", user.Lica_Izbori_Rolia);
                persdoc.ReplaceText("/siks_fullcod/", user.Siks_Fullcode);
                persdoc.ReplaceText("/siks_kmet/", user.Siks_Kmet);
                persdoc.ReplaceText("/siks_nas/", user.Siks_Nas);
                persdoc.ReplaceText("/siks_toa/", user.Siks_Toa);
                persdoc.ReplaceText("/n_top_main_description/", user.N_Top_Main_Description);
                persdoc.ReplaceText("/n_top_main.datetur/", user.N_Top_Main_Datetur);

                documentTemplate.InsertDocument(persdoc);
            }

            var guid = new Guid();

            guid = Guid.NewGuid();

            documentTemplate.SaveAs(Path.Combine(_hostingEnvironment.WebRootPath, "templates").ToString() + "/" + Statistics.MUDO.EnumDescription() + "_" + guid.ToString() + ".rtf");

            return guid.ToString();

        }

        public string GetMsbdStatisticContents(GenerateReportViewModel model, string userId)
        {
            var userReports = new List<MsbdStatistic>();

            if (model.Seleciq == 0)
            {
                foreach (var liceId in model.AllLicaIds)
                {

                    userReports.Add(_context.MsbdStatistics.FromSql("CALL spravka_MSBDECL(@p0, @p1, @p2)",
                        liceId,
                        userId,
                        CryptoConstants.CryptoKey
                    ).First());
                }
            }

            if (model.Seleciq == 1)
            {
                var nonSelectedLica = model.AllLicaIds.Where(l => !model.LicaIds.Contains(l)).ToArray();

                foreach (var liceId in nonSelectedLica)
                {

                    userReports.Add(_context.MsbdStatistics.FromSql("CALL spravka_MSBDECL(@p0, @p1, @p2)",
                        liceId,
                        userId,
                        CryptoConstants.CryptoKey
                    ).First());
                }
            }

            if (model.Seleciq == 2)
            {
                foreach (var liceId in model.LicaIds)
                {

                    userReports.Add(_context.MsbdStatistics.FromSql("CALL spravka_MSBDECL(@p0, @p1, @p2)",
                        liceId,
                        userId,
                        CryptoConstants.CryptoKey
                    ).First());
                }
            }

            var path = Path.Combine(_hostingEnvironment.WebRootPath, "templates", "MSB_DECLAR.rtf");

            var documentTemplate = DocX.Create("MSB_DECLAR.rtf");

            foreach (var user in userReports)
            {
                var persdoc = DocX.Load(path);
                persdoc.ReplaceText("/siks_fullcode/", user.Siks_Fullcode);
                persdoc.ReplaceText("/lica_izbori_rolia/", user.Lica_Izbori_Rolia);
                persdoc.ReplaceText("/lica_fullname/", user.Lica_Fullname);
                persdoc.ReplaceText("/lica_egn/", user.Lica_Egn);
                persdoc.ReplaceText("/par_dc_20/", user.Par_Dc_20.ToString());

                documentTemplate.InsertDocument(persdoc);

            }

            var guid = new Guid();

            guid = Guid.NewGuid();

            documentTemplate.SaveAs(Path.Combine(_hostingEnvironment.WebRootPath, "templates").ToString() + "/"+ Statistics.MSBD.EnumDescription() + "_" + guid.ToString() + ".rtf");

            return guid.ToString();
        }

        public ICollection<SpisukNaSekciiteSpravkaDto> GetSpisukNaSekciiteSpravka(IzbRaionWithSikFilter filter, string userId)
        {
            return _context.SpisukNaSekciiteSpravkaSet
                            .FromSql("CALL spravka_1_2(@p0,@p1,@p2,@p3)", 
                                                                    filter.IzbRaionNkod, 
                                                                    filter.AdministrativenRaion, 
                                                                    userId,
                                                                    string.Join(",", filter.SikIds)
                                                                    ).ToList().Select(s => new SpisukNaSekciiteSpravkaDto {
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

        public ICollection<ZaetiPoziciiSpravkaDto> GetZaetiPoziciiPublichnaSpravka(IzbRaionWithSikFilter filter, string userId)
        {
            return _context.ZaetiPoziciiSet
                            .FromSql("CALL spravka_4_1(@p0,@p1,@p2,@p3)",
                                                                    filter.IzbRaionNkod,
                                                                    filter.AdministrativenRaion,
                                                                    1,
                                                                    userId
                                                                    ).ToList().Select(s => new ZaetiPoziciiSpravkaDto
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

        public ICollection<ZaetiPoziciiSpravkaDto> GetZaetiPoziciiObjoPublichnaSpravka(IzbRaionWithSikFilter filter, string userId)
        {
            return _context.ZaetiPoziciiSet
                            .FromSql("CALL spravka_4_1(@p0,@p1,@p2,@p3)",
                                                                    filter.IzbRaionNkod,
                                                                    filter.AdministrativenRaion,
                                                                    0,
                                                                    userId
                                                                    ).ToList().Select(s => new ZaetiPoziciiSpravkaDto
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

        public ICollection<ReshetkaSpravkaDto> GetReshetkaSpravka(PartiaFilterViewModel filter, string administrativenRaion, string userId)
        {
            return _context.ReshetkaSpravkaSet
                            .FromSql("CALL spravka_4_3(@p0,@p1,@p2)",
                                                                    administrativenRaion,
                                                                    filter.Sila ?? "",
                                                                    userId
                                                                    ).ToList().Select(s => new ReshetkaSpravkaDto
                                                                    {
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

        public ICollection<ZamestvajiSpravkaDto> GetZamestvajiSpravka(SikSpravkaFilter filter, string administrativenRaion, string userId)
        {
            return _context.ZamestvajiSpravka
                            .FromSql("CALL spravka_2_3(@p0,@p1,@p2,@p3)",
                                                                    administrativenRaion,
                                                                    string.Join(",", filter.SikIds),
                                                                    userId,
                                                                    CryptoConstants.CryptoKey
                                                                    ).ToList().Select(s => new ZamestvajiSpravkaDto
                                                                    {
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
                                                                        Telefon = s.TEL,
                                                                        Deistvie = s.Deistvie


    }).ToList();
        }
        public DashboardSpravkaDto GetDashboardSpravka(string administrativenRaion, string userId)
        {
            var sustoqnieNaRegistrite = _context.SustoqnieNaRegistraciiteSpravkaSet
                            .FromSql("CALL spravka_9_3(@p0,@p1,@p2)",
                                                                    administrativenRaion,
                                                                    "",
                                                                    userId
                                                                    ).ToList().Select(s => new SustoqnieNaRegistraciiteSpravkaDto
                                                                    {
                                                                       Id = s.Id,
                                                                       Col1 = s.Col1,
                                                                       Col2 = s.Col2,
                                                                       Col3 = s.Col3,
                                                                       Col4 = s.Col4
                                                                    }).ToList();
            var razpredelenie = _context.Spravka91Set
                            .FromSql("CALL spravka_9_1(@p0,@p1)",
                                                                    administrativenRaion,
                                                                    userId
                                                                    ).ToList().Select(s => new RazpredelenieDto
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
                                                                    }).ToList();

            var model = new DashboardSpravkaDto
            {
                Razpredeleniq = razpredelenie,
                SustoqnieNaRegistraciite = sustoqnieNaRegistrite
            };

            return model;
        }

        public ICollection<SustoqnieNaRegistraciiteSpravkaDto> GetSustoqnieNaRegistraciiteSpravka(RoliSpravkaFilter filter, string administrativenRaion, string userId)
        {
            return _context.SustoqnieNaRegistraciiteSpravkaSet
                            .FromSql("CALL spravka_9_3(@p0,@p1,@p2)",
                                                                    administrativenRaion,
                                                                    filter.Rolq ?? "",
                                                                    userId
                                                                    ).ToList().Select(s => new SustoqnieNaRegistraciiteSpravkaDto
                                                                    {
                                                                       Id = s.Id,
                                                                       Col1 = s.Col1,
                                                                       Col2 = s.Col2,
                                                                       Col3 = s.Col3,
                                                                       Col4 = s.Col4
                                                                    }).ToList();
        }

        public ICollection<BroiSekciiSpravkaDto> GetBroiSekciiSpravka(IzbRaionWithSikFilter filter, string userId)
        {
            return _context.BroiSekciiSpravkaSet
                            .FromSql("CALL spravka_1_1(@p0,@p1)",
                                                                filter.IzbRaionNkod,
                                                                userId
                                                                ).ToList().Select(s => new BroiSekciiSpravkaDto
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

        public ICollection<IstoriaSikViewModel> GetSikIstoria(IzbRaionWithSikFilter filter, string user)
        {
            return _context.IstoriaSikSet
                           .FromSql("CALL spravka_9_2(@p0,@p1,@p2,@p3,@p4)",
                                                               filter.IzbRaionNkod,
                                                               (string.IsNullOrEmpty(filter.AdministrativenRaion)?"00":filter.AdministrativenRaion),
                                                               filter.DateOt,
                                                               filter.DateDo,
                                                               user
                                                               )
                           .ToList()
                           .Select(s => new IstoriaSikViewModel
                           {
                                        NmIzbRajon = s.NmIzbRajon,
                                        NmRajon = s.NmRajon,
                                        User = s.User,
                                        Koga = s.Koga,
                                        Toa = s.Toa,
                                        SIK = s.SIK,
                                        KodObr = s.KodObr,
                                        KodText = s.KodText,
                                        OldVal = s.OldVal,
                                        NewVal = s.NewVal
                           }).ToList();
        }


        public ICollection<SpisykPodvizjniSekciiViewModel> GetSpisykPodvizjniSekcii(IzbRaionWithSikFilter filter, string user)
        {
            return _context.SpisykPodvizjniSekciiSet
                              .FromSql("CALL spravka_1_4(@p0,@p1,@p2)",
                                        filter.IzbRaionNkod,
                                        (string.IsNullOrEmpty(filter.AdministrativenRaion) ? "00" : filter.AdministrativenRaion),
                                        user
                                      )
                              .ToList()
                              .Select(s => new SpisykPodvizjniSekciiViewModel
                              {
                                  NmIzbRajon = s.NmIzbRajon,
                                  NmRajon = s.NmRajon,
                                  SumVoter = s.SumVoter,
                                  SikNumb = s.SikNumb,
                                  Address = s.Address,
                                  ObsRajon = s.ObsRajon,
                                  Voters = s.Voters
                              }).ToList();
        }

        public ICollection<SpisukSekciiGraniciSpravkaDto> GetSpisukSekciiGraniciSpravka(IzbRaionWithSikFilter filter, string userId)
        {
            return _context.SpisukSekciiGraniciSpravkaSet
                            .FromSql("CALL spravka_1_5(@p0,@p1,@p2)",
                                    filter.AdministrativenRaion,
                                    filter.Granici,
                                    userId
                                    ).ToList()
                                    .Select(s => new SpisukSekciiGraniciSpravkaDto
                                    {
                                        Id = s.Id,
                                        NmIzbRajon = s.NmIzbRajon,
                                        NmRajon = s.NmRajon,
                                        SikNumb = s.SikNumb,
                                        Borders = s.Borders,
                                        NumbVoters = s.NumbVoters
                                    }).ToList();
        }

        
        public ICollection<SpisukSpravkaRziDto> GetSpisukRziSpravka(SpravkaRziFilter filter, string toa)
        {
            var deinosti = "";
            if (!(filter.Deistvie == null || filter.Deistvie.Length == 0))
                deinosti = string.Join(",", filter.Deistvie);

            return _context.SpisukSpravkaRziSet
                            .FromSql("CALL spravka_1_6(@p0,@p1,@p2,@p3)",
                                    (filter.IzbRaionNkod == null ? "00": filter.IzbRaionNkod),
                                    deinosti,
                                    toa,
                                    CryptoConstants.CryptoKey
                                    ).ToList()
                                    .Select(s => new SpisukSpravkaRziDto
                                    {
                                        NmIzbRajon = s.NmIzbRajon,
                                        NmRajon = s.NmRajon,
                                        EGN = s.EGN,
                                        Ime = s.Ime,
                                        SikNumb = s.SikNumb,
                                        Telefon = s.Telefon,
                                        Deinost = s.Deinost,
                                        TOA = s.TOA
                                    }).ToList();
        }

        public ICollection<SpravkaSekciiLicaDto> GetSpisukSekciiLica(IzbRaionWithSikFilter filter)
        {
            return _context.SpravkaSekciiLica
                              .FromSql("CALL spravka_1_7(@p0,@p1)",
                                      (filter.IzbRaionNkod == null ? "00" : filter.IzbRaionNkod),
                                      (filter.AdministrativenRaion == null ? "00" : filter.AdministrativenRaion),
                                      CryptoConstants.CryptoKey
                                      ).ToList()
                                      .Select(s => new SpravkaSekciiLicaDto
                                      {
                                          NmIzbRajon = s.NmIzbRajon,
                                          NmRajon = s.NmRajon,
                                          rowno = s.rowno,
                                          Pokazatel = s.Pokazatel,
                                          SIK0 = s.SIK0,
                                          SIK1 = s.SIK1,
                                          PSIK = s.PSIK,
                                          Total = s.Total
                                      }).ToList();
        }

    }
}
