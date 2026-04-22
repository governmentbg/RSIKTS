using Common.Static;
using Common.ViewModels.Lica;
using Common.ViewModels.Obrabotki;
using DataAccess;
using DTO.Izbori;
using DTO.Lica;
using Microsoft.EntityFrameworkCore;
using Repository.Interfaces.Nachislqvaniq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Repository.Implementations.Nachislqvaniq
{
    public class NachislqvaniqRepository : INachislqvaniqRepository
    {
        private readonly VotingRegisterContext _context;

        public NachislqvaniqRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public bool RaionHasNachislqvaniq(string administrativenRaion)
        {
            return !(_context.SysMains.Where(s => s.Name == "FINANCE" && s.Value == administrativenRaion).FirstOrDefault() == null);
        }

        public void ToggleObrabotkiFlag(string userId, string administrativenRaion)
        {
            _context.Database.ExecuteSqlCommand("CALL setObrabotkiOnOff(@p0,@p1)", userId, administrativenRaion);
        }

        public ICollection<LiceGridDTO> GetLicaByKorekciiPaymentFilter(KorekciiPaymentFilterViewModel model, string userId, int tip)
        {
            //int tur = (model.SelectedTurs == 0 ? _izboriRepository.GetIzborTUR() : model.SelectedTurs);

            return _context.LicaForGridSet.FromSql("CALL spravka_select_lica(@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11)",
                                                    model.AdministrativenRaion,
                                                    model.Rolq ?? "",
                                                    model.Partiq ?? "",
                                                    model.Reshenie ?? "",
                                                    model.Deistvie ?? "",
                                                    model.Sekciq ?? "",
                                                    model.Egn ?? "",
                                                    userId,
                                                    tip,
                                                    CryptoConstants.CryptoKey,
                                                    1,
                                                    0
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
                                            })
                                        .ToList();
        }

        public ICollection<PaymentsCorrectionDTO> GetPayments4Correction(int pIdLice)
        {

            return _context.PaymentsForGridSet.FromSql("CALL getPaymentCorrection(@p0)",
                                                   pIdLice)
                                       .ToList()
                                       .Select(l => new PaymentsCorrectionDTO
                                       {
                                           Text = l.Text,
                                           Pari = l.Pari,
                                       })
                                       .ToList();
        }

        public int SetPaymentsCorrection(int liceId, string user, float pari)
        {
            return _context.IdReturnSet.FromSql("CALL setPaymentCorrection(@p0,@p1,@p2,@p3)"
                                                , liceId
                                                , user
                                                , pari
                                                , CryptoConstants.CryptoKey)
                                        .ToList()
                                        .First().Id;
        }
    }
}
