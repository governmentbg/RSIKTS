using Common.ViewModels.Lica;
using Common.ViewModels.Obrabotki;
using Repository.Interfaces.Nachislqvaniq;
using Services.Interfaces.Nachislqvaniq;
using System.Collections.Generic;
using System.Linq;

namespace Services.Implementations.Nachislqvaniq
{
    public class NachislqvaniqServices : INachislqvaniqServices
    {
        private readonly INachislqvaniqRepository _nachislqvaniqRepository;

        public NachislqvaniqServices(INachislqvaniqRepository nachislqvaniqRepository)
        {
            _nachislqvaniqRepository = nachislqvaniqRepository;
        }

        public bool RaionHasNachislqvaniq(string administrativenRaion)
        {
            return _nachislqvaniqRepository.RaionHasNachislqvaniq(administrativenRaion);
        }

        public void ToggleObrabotkiFlag(string userId, string administrativenRaion)
        {
            _nachislqvaniqRepository.ToggleObrabotkiFlag(userId, administrativenRaion);
        }

        public ICollection <LiceGridViewModel> GetLicaByKorekciiPaymentFilter(KorekciiPaymentFilterViewModel model, string userId, int tip)
        {
            return _nachislqvaniqRepository.GetLicaByKorekciiPaymentFilter(model, userId, tip)
                    .Select(l => new LiceGridViewModel
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

        public ICollection<PaymentsCorrectionViewModel> GetPayments4Correction(int pIdLice)
        {
            return _nachislqvaniqRepository.GetPayments4Correction(pIdLice)
                                           .Select(l => new PaymentsCorrectionViewModel
                                                   {
                                                       Text = l.Text,
                                                       Pari = l.Pari
                                                   }).ToList();
        }

        public int SetPaymentsCorrection(int liceId, string user, float pari)
        {
            return _nachislqvaniqRepository.SetPaymentsCorrection(liceId, user, pari);
        }
    }
}
