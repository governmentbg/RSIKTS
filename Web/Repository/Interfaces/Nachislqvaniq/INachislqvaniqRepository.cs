using Common.ViewModels.Lica;
using Common.ViewModels.Obrabotki;
using DTO.Izbori;
using DTO.Lica;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace Repository.Interfaces.Nachislqvaniq
{
    public interface INachislqvaniqRepository
    {
        bool RaionHasNachislqvaniq(string administrativenRaion);

        void ToggleObrabotkiFlag(string userId, string administrativenRaion);

        ICollection<LiceGridDTO> GetLicaByKorekciiPaymentFilter (KorekciiPaymentFilterViewModel model, string userId, int tip);

        ICollection<PaymentsCorrectionDTO> GetPayments4Correction(int pIdLice);

        int SetPaymentsCorrection(int liceId, string user, float pari);
    }
}
