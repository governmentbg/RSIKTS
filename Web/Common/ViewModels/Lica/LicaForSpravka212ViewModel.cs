using Common.ViewModels.Spravki;

using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Lica
{
    public class LicaForSpravka212ViewModel
    {
        public string NmRajon { get; set; }

        public string SikFullCode { get; set; }

        public string Rolia { get; set; }

        public string Imena { get; set; }

        public string Egn { get; set; }

        public string Sila { get; set; }

        public string Telephone { get; set; }

        public SikSpravkaFilter filter { get; set; }
    }
}
