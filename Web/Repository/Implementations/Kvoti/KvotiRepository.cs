using Common.ViewModels.Kvoti;
using DataAccess;
using DTO.Kvoti;
using Microsoft.EntityFrameworkCore;
using Repository.Interfaces.Izbori;
using Repository.Interfaces.Kvoti;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;

namespace Repository.Implementations.Kvoti
{
    public class KvotiRepository : IKvotiRepository
    {
        private readonly VotingRegisterContext _context;
        private readonly IIzboriRepository _izboriRepository;

        public KvotiRepository(VotingRegisterContext context, IIzboriRepository izboriRepository)
        {
            _izboriRepository = izboriRepository;
            _context = context;
        }

        public ICollection<KvotiDto> AllKvoti(string administrativenRaion)
        {
            var allKvoti = _context.KvotiForGridSet.FromSql("CALL selectKvoti(@p0)", administrativenRaion).ToList().Select(k => new KvotiDto {
                Id = k.Nkod,
                PoliticheskaSila = k.Nime,
                Total = k.Total,
                Precedatel = k.sum401,
                ZamestnikPrecedatel = k.sum402,
                Sekretar = k.sum403,
                Chlenove = k.sum404
            }).ToList();

            return allKvoti;
        }

        public void EditKvota(KvotiEditViewModel kvota, string administrativenRaion, string userId)
        {
  
            var kvotaEntity = _context.NTopPartkvoti.Where(k => k.Toa == administrativenRaion &&
                                                                k.IzbAlias == _izboriRepository.GetIzborAlias() &&
                                                                k.CodeWnsila == kvota.Id
                                                           ).ToList();


            var kvotaPrecedatel = kvotaEntity.FirstOrDefault(k => k.CodeRolja == 401);

            if(kvotaPrecedatel == null)
            {
                _context.NTopPartkvoti.Add(new NTopPartkvoti
                {
                    Id = _context.NTopPartkvoti.LastOrDefault() == null ? 1 : _context.NTopPartkvoti.Last().Id + 1,
                    IzbAlias = _izboriRepository.GetIzborAlias(),
                    IzbRajon = "nz",
                    Toa = administrativenRaion,
                    CodeWnsila = kvota.Id,
                    CodeRolja = 401,
                    SikClenove = kvota.Precedatel,
                    Koga = DateTime.Now,
                    User = userId,
                    StatusKvoti = 1
                });
            }
            else
            {
                kvotaPrecedatel.SikClenove = kvota.Precedatel;
            }

            _context.SaveChanges();

            var kvotaZamestnikPrecedatel = kvotaEntity.FirstOrDefault(k => k.CodeRolja == 402);

            if (kvotaZamestnikPrecedatel == null)
            {
                _context.NTopPartkvoti.Add(new NTopPartkvoti
                {
                    Id = _context.NTopPartkvoti.LastOrDefault() == null ? 1 : _context.NTopPartkvoti.Last().Id + 1,
                    IzbAlias = _izboriRepository.GetIzborAlias(),
                    IzbRajon = "nz",
                    Toa = administrativenRaion,
                    CodeWnsila = kvota.Id,
                    CodeRolja = 402,
                    SikClenove = kvota.ZamestnikPrecedatel,
                    Koga = DateTime.Now,
                    User = userId,
                    StatusKvoti = 1
                });
            }
            else
            {
                kvotaZamestnikPrecedatel.SikClenove = kvota.ZamestnikPrecedatel;
            }

            _context.SaveChanges();

            var kvotaSekretar = kvotaEntity.FirstOrDefault(k => k.CodeRolja == 403);

            if (kvotaSekretar == null)
            {
                _context.NTopPartkvoti.Add(new NTopPartkvoti
                {
                    Id = _context.NTopPartkvoti.LastOrDefault() == null ? 1 : _context.NTopPartkvoti.Last().Id + 1,
                    IzbAlias = _izboriRepository.GetIzborAlias(),
                    IzbRajon = "nz",
                    Toa = administrativenRaion,
                    CodeWnsila = kvota.Id,
                    CodeRolja = 403,
                    SikClenove = kvota.Sekretar,
                    Koga = DateTime.Now,
                    User = userId,
                    StatusKvoti = 1
                });
            }
            else
            {
                kvotaSekretar.SikClenove = kvota.Sekretar;
            }

            _context.SaveChanges();

            var kvotaChlenove = kvotaEntity.FirstOrDefault(k => k.CodeRolja == 404);

            if (kvotaChlenove == null)
            {
                _context.NTopPartkvoti.Add(new NTopPartkvoti
                {
                    Id = _context.NTopPartkvoti.LastOrDefault() == null ? 1 : _context.NTopPartkvoti.Last().Id + 1,
                    IzbAlias = _izboriRepository.GetIzborAlias(),
                    IzbRajon = "nz",
                    Toa = administrativenRaion,
                    CodeWnsila = kvota.Id,
                    CodeRolja = 404,
                    SikClenove = kvota.Chlenove,
                    Koga = DateTime.Now,
                    User = userId,
                    StatusKvoti = 1
                });
            }
            else
            {
                kvotaChlenove.SikClenove = kvota.Chlenove;
            }

            _context.SaveChanges();

            
        }

        public KvotiEditViewModel GetKvotaById(string id, string administrativenRaion)
        {
            var kvotaEntity = _context.NTopPartkvoti.Where(k => k.CodeWnsila == id && k.Toa == administrativenRaion).ToList();


            var kvotaPrecedateli = kvotaEntity.FirstOrDefault(k => k.CodeRolja == 401)?.SikClenove;

            var kvotaZamestnikPrecedateli = kvotaEntity.FirstOrDefault(k => k.CodeRolja == 402)?.SikClenove;

            var kvotaSekretar = kvotaEntity.FirstOrDefault(k => k.CodeRolja == 403)?.SikClenove;

            var kvotaChlenove = kvotaEntity.FirstOrDefault(k => k.CodeRolja == 404)?.SikClenove;

            if (kvotaEntity.Count == 0)
            {
                return new KvotiEditViewModel
                {
                    Id = id,
                    Precedatel = 0,
                    ZamestnikPrecedatel = 0,
                    Sekretar = 0,
                    Chlenove = 0
                };
            }
            else
            {
                return new KvotiEditViewModel
                {
                   Id = id,
                   Precedatel = kvotaPrecedateli ?? 0,
                   ZamestnikPrecedatel = kvotaZamestnikPrecedateli ?? 0,
                   Sekretar = kvotaSekretar ?? 0,
                   Chlenove = kvotaChlenove ?? 0
                };
            }
        }

        public List<ReshetkaDto> GetReshetkaInfo(string administrativenRaion)
        {
            return _context.ReshetkaSet.FromSql("CALL selectGrid(@p0)", administrativenRaion).ToList().Select(r => new ReshetkaDto
            {
                Id = r.Id_Sek,
                PrecedatelPartiq = r.Sum401,
                ZamestnikPrecedatelPartiq = r.Sum402,
                SekretarPartiq = r.Sum403,
                Chlen1Partiq = r.Sum404_1,
                Chlen2Partiq = r.Sum404_2,
                Chlen3Partiq = r.Sum404_3,
                Chlen4Partiq = r.Sum404_4,
                Chlen5Partiq = r.Sum404_5,
                Chlen6Partiq = r.Sum404_6,
                SikFullCode = r.SikFullCode
            }).ToList();
        }
        
        public ReshetkaEditViewModel GetReshetkaEdit(int sikId)
        {
            var reshetaRazpredeleniq = _context.NTopPartgrids.Where(p => p.Id_Sek == sikId && p.Izb_Alias == _izboriRepository.GetIzborAlias()).ToList();

            var precedatelPartiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 401)?.Code_Wnsila;

            var zamestnikPrecedatelPartiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 402)?.Code_Wnsila;

            var sekretarPartiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 403)?.Code_Wnsila;

            var chlen1Partiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 404 && r.Order_Rolja == 1)?.Code_Wnsila;

            var chlen2Partiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 404 && r.Order_Rolja == 2)?.Code_Wnsila;

            var chlen3Partiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 404 && r.Order_Rolja == 3)?.Code_Wnsila;

            var chlen4Partiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 404 && r.Order_Rolja == 4)?.Code_Wnsila;

            var chlen5Partiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 404 && r.Order_Rolja == 5)?.Code_Wnsila;

            var chlen6Partiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 404 && r.Order_Rolja == 6)?.Code_Wnsila;

            return new ReshetkaEditViewModel
            {
                SikId = sikId,
                PrecedatelPartiqId = precedatelPartiq ?? "0",
                ZamestnikPrecedatelPartiqId = zamestnikPrecedatelPartiq ?? "0",
                SekretarPartiqId = sekretarPartiq ?? "0",
                Chlen1PartiqId = chlen1Partiq ?? "0",
                Chlen2PartiqId = chlen2Partiq ?? "0",
                Chlen3PartiqId = chlen3Partiq ?? "0",
                Chlen4PartiqId = chlen4Partiq ?? "0",
                Chlen5PartiqId = chlen5Partiq ?? "0",
                Chlen6PartiqId = chlen6Partiq ?? "0"
            };
        }

        public void EditReshetka(ReshetkaEditViewModel model, string administrativenRaion, string user)
        {
            int maxmembers = GetMaxNumber4Sik(administrativenRaion);

            var reshetaRazpredeleniq = _context.NTopPartgrids.Where(p => p.Id_Sek == model.SikId && p.Izb_Alias == _izboriRepository.GetIzborAlias()).ToList();

            var precedatelPartiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 401);

            var zamestnikPrecedatelPartiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 402);

            var sekretarPartiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 403);

            var chlen1Partiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 404 && r.Order_Rolja == 1);

            var chlen2Partiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 404 && r.Order_Rolja == 2);

            var chlen3Partiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 404 && r.Order_Rolja == 3);

            var chlen4Partiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 404 && r.Order_Rolja == 4);

            var chlen5Partiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 404 && r.Order_Rolja == 5);

            var chlen6Partiq = reshetaRazpredeleniq.FirstOrDefault(r => r.Code_Rolia == 404 && r.Order_Rolja == 6);

            if (precedatelPartiq == null)
            {
                _context.NTopPartgrids.Add(new NTopPartgrid
                {
                    Id = _context.NTopPartgrids.LastOrDefault() == null ? 1 : _context.NTopPartgrids.Last().Id + 1,
                    Izb_Alias = _izboriRepository.GetIzborAlias(),
                    Toa = administrativenRaion,
                    Id_Sek = model.SikId,
                    Code_Wnsila = model.PrecedatelPartiqId,
                    Code_Rolia = 401,
                    Status = 1,
                    User = user,
                    Koga = DateTime.Now,
                    Order_Rolja = 1
                });
            }
            else
            {
                precedatelPartiq.Code_Wnsila = model.PrecedatelPartiqId;
            }

            _context.SaveChanges();

            if (zamestnikPrecedatelPartiq == null)
            {
                _context.NTopPartgrids.Add(new NTopPartgrid
                {
                    Id = _context.NTopPartgrids.LastOrDefault() == null ? 1 : _context.NTopPartgrids.Last().Id + 1,
                    Izb_Alias = _izboriRepository.GetIzborAlias(),
                    Toa = administrativenRaion,
                    Id_Sek = model.SikId,
                    Code_Wnsila = model.ZamestnikPrecedatelPartiqId,
                    Code_Rolia = 402,
                    Status = 1,
                    User = user,
                    Koga = DateTime.Now,
                    Order_Rolja = 1
                });
            }
            else
            {
                zamestnikPrecedatelPartiq.Code_Wnsila = model.ZamestnikPrecedatelPartiqId;
            }

            _context.SaveChanges();

            if (sekretarPartiq == null)
            {
                _context.NTopPartgrids.Add(new NTopPartgrid
                {
                    Id = _context.NTopPartgrids.LastOrDefault() == null ? 1 : _context.NTopPartgrids.Last().Id + 1,
                    Izb_Alias = _izboriRepository.GetIzborAlias(),
                    Toa = administrativenRaion,
                    Id_Sek = model.SikId,
                    Code_Wnsila = model.SekretarPartiqId,
                    Code_Rolia = 403,
                    Status = 1,
                    User = user,
                    Koga = DateTime.Now,
                    Order_Rolja = 1
                });
            }
            else
            {
                sekretarPartiq.Code_Wnsila = model.SekretarPartiqId;
            }

            _context.SaveChanges();

            //member 1
            if (maxmembers >= 1)
            {
                if (chlen1Partiq == null)
                {
                    _context.NTopPartgrids.Add(new NTopPartgrid
                    {
                        Id = _context.NTopPartgrids.LastOrDefault() == null ? 1 : _context.NTopPartgrids.Last().Id + 1,
                        Izb_Alias = _izboriRepository.GetIzborAlias(),
                        Toa = administrativenRaion,
                        Id_Sek = model.SikId,
                        Code_Wnsila = model.Chlen1PartiqId,
                        Code_Rolia = 404,
                        Status = 1,
                        User = user,
                        Koga = DateTime.Now,
                        Order_Rolja = 1
                    });
                }
                else
                {
                    chlen1Partiq.Code_Wnsila = model.Chlen1PartiqId;
                }
            } else
            {
                if (chlen1Partiq != null)
                {
                    _context.Remove(chlen1Partiq);
                }
            }                   
            _context.SaveChanges();


            //member 2
            if (maxmembers >= 2)
            {
                if (chlen2Partiq == null)
                {
                    _context.NTopPartgrids.Add(new NTopPartgrid
                    {
                        Id = _context.NTopPartgrids.LastOrDefault() == null ? 1 : _context.NTopPartgrids.Last().Id + 1,
                        Izb_Alias = _izboriRepository.GetIzborAlias(),
                        Toa = administrativenRaion,
                        Id_Sek = model.SikId,
                        Code_Wnsila = model.Chlen2PartiqId,
                        Code_Rolia = 404,
                        Status = 1,
                        User = user,
                        Koga = DateTime.Now,
                        Order_Rolja = 2
                    });
                }
                else
                {
                    chlen2Partiq.Code_Wnsila = model.Chlen2PartiqId;
                }
            }
            else
            {
                if (chlen2Partiq != null)
                {
                    _context.Remove(chlen2Partiq);
                }
            }
            _context.SaveChanges();

            //member 3
            if (maxmembers >= 3)
            {
                if (chlen3Partiq == null)
                {
                    _context.NTopPartgrids.Add(new NTopPartgrid
                    {
                        Id = _context.NTopPartgrids.LastOrDefault() == null ? 1 : _context.NTopPartgrids.Last().Id + 1,
                        Izb_Alias = _izboriRepository.GetIzborAlias(),
                        Toa = administrativenRaion,
                        Id_Sek = model.SikId,
                        Code_Wnsila = model.Chlen3PartiqId,
                        Code_Rolia = 404,
                        Status = 1,
                        User = user,
                        Koga = DateTime.Now,
                        Order_Rolja = 3
                    });
                }
                else
                {
                    chlen3Partiq.Code_Wnsila = model.Chlen3PartiqId;
                }
            }
            else
            {
                if (chlen3Partiq != null)
                {
                    _context.Remove(chlen3Partiq);
                }
            }

            _context.SaveChanges();

            //member 4
            if (maxmembers >= 4)
            {
                if (chlen4Partiq == null)
                {
                    _context.NTopPartgrids.Add(new NTopPartgrid
                    {
                        Id = _context.NTopPartgrids.LastOrDefault() == null ? 1 : _context.NTopPartgrids.Last().Id + 1,
                        Izb_Alias = _izboriRepository.GetIzborAlias(),
                        Toa = administrativenRaion,
                        Id_Sek = model.SikId,
                        Code_Wnsila = model.Chlen4PartiqId,
                        Code_Rolia = 404,
                        Status = 1,
                        User = user,
                        Koga = DateTime.Now,
                        Order_Rolja = 4
                    });
                }
                else
                {
                    chlen4Partiq.Code_Wnsila = model.Chlen4PartiqId;
                }
            }
            else
            {
                if (chlen4Partiq != null)
                {
                    _context.Remove(chlen4Partiq);
                }
            }
            _context.SaveChanges();

            //member 5
            if (maxmembers >= 5)
            {
                if (chlen5Partiq == null)
                {
                    _context.NTopPartgrids.Add(new NTopPartgrid
                    {
                        Id = _context.NTopPartgrids.LastOrDefault() == null ? 1 : _context.NTopPartgrids.Last().Id + 1,
                        Izb_Alias = _izboriRepository.GetIzborAlias(),
                        Toa = administrativenRaion,
                        Id_Sek = model.SikId,
                        Code_Wnsila = model.Chlen5PartiqId,
                        Code_Rolia = 404,
                        Status = 1,
                        User = user,
                        Koga = DateTime.Now,
                        Order_Rolja = 5
                    });
                }
                else
                {
                    chlen5Partiq.Code_Wnsila = model.Chlen5PartiqId;
                }
            }
            else
            {
                if (chlen5Partiq != null)
                {
                    _context.Remove(chlen5Partiq);
                }
            }
            _context.SaveChanges();

            //member 6
            if (maxmembers >= 6)
            {
                if (chlen6Partiq == null)
                {
                    _context.NTopPartgrids.Add(new NTopPartgrid
                    {
                        Id = _context.NTopPartgrids.LastOrDefault() == null ? 1 : _context.NTopPartgrids.Last().Id + 1,
                        Izb_Alias = _izboriRepository.GetIzborAlias(),
                        Toa = administrativenRaion,
                        Id_Sek = model.SikId,
                        Code_Wnsila = model.Chlen6PartiqId,
                        Code_Rolia = 404,
                        Status = 1,
                        User = user,
                        Koga = DateTime.Now,
                        Order_Rolja = 6
                    });
                }
                else
                {
                    chlen6Partiq.Code_Wnsila = model.Chlen6PartiqId;
                }
            }
            else
            {
                if (chlen6Partiq != null)
                {
                    _context.Remove(chlen6Partiq);
                }
            }
            _context.SaveChanges();

        }

        public List<ReshetkaDetailsDto> GetReshetkaDetails(int sikId)
        {
            return _context.ReshetkaDetailsSet.FromSql("CALL selectSikGrid(@p0)", sikId).ToList().Select(r => new ReshetkaDetailsDto
            {
                Nkod = r.Nkod,
                Nime = r.Nime,
                BroiRukChlenove = r.CntHeadMembers,
                Objo = r.CntMembers
            }).ToList();
        }

        public List<ReshetkaSumDto> GetReshetkaSum(string administrativenRaion)
        {
            return _context.ReshetkaSumGrids.FromSql("CALL selectSumGrid(@p0)", administrativenRaion).ToList().Select(r => new ReshetkaSumDto
            {
                Nime = r.Nime,
                PrecedatelCount = r.Cnt401,
                PrecedatelMax = r.Max401,
                ZamestnikPrecedatelCount = r.Cnt402,
                ZamestnikPrecedatelMax = r.Max402,
                SekretarCount = r.Cnt403,
                SekretarMax = r.Max403,
                ChlenCount = r.Cnt404,
                ChlenMax = r.Max404
            }).ToList();
        }

        

        public int GetMaxNumber4Sik(string prmRegion)
        {
            var data = _context.IdReturnSet.FromSql("CALL getMaxMemebers4IzbRajoni(@p0)", prmRegion).FirstOrDefault();
            return data.Id;
        }
    }
}
