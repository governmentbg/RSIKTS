using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Izbori
{
    public class IzborTipViewModel
    {
        public int Id { get; set; }

        public string Nkod { get; set; }

        public string Nime { get; set; }

        public int Tur { get; set; }

        public bool Status { get; set; }
    }
}
