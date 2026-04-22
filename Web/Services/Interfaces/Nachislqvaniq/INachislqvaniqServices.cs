using Common.ViewModels.Lica;
using Common.ViewModels.Obrabotki;
using System;
using System.Collections.Generic;
using System.Text;

namespace Services.Interfaces.Nachislqvaniq
{
    public interface INachislqvaniqServices
    {
        bool RaionHasNachislqvaniq(string administrativenRaion);

        void ToggleObrabotkiFlag(string userId, string administrativenRaion);

        ICollection<LiceGridViewModel> GetLicaByKorekciiPaymentFilter(KorekciiPaymentFilterViewModel model, string userId, int tip);
        ICollection<PaymentsCorrectionViewModel> GetPayments4Correction(int pIdLice);

        int SetPaymentsCorrection(int liceId, string user, float pari);
    }
}
