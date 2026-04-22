using Common.ViewModels.Spravki;
using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Spravki
{
    public class LicaForSpravkaRziViewModel
    {
        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }

        public string Egn { get; set; }

        public string Imena { get; set; }

        public string SikFullCode { get; set; }

        public string Telephone { get; set; }

        public string Deinost { get; set; }
        public string TOA { get; set; }

        public SpravkaRziFilter filter { get; set; }
    }
}
