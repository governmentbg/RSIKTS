using Common.Enums.Spravki;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;


namespace Common.ViewModels.Obrabotki
{
    public class PaymentsCorrectionViewModel
    {
        public string Text { get; set; }

        public decimal Pari { get; set; }
    }
}
