using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Obrabotki
{
    public class PaymentCorrectionCompositeViewModel
    {
        public ICollection<PaymentsCorrectionViewModel> PaymentCorrectionList { get; set; }

        public int pIdLice { get; set; }

        public decimal TotalSum { get; set; }
    }
}
