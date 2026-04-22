using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Lica
{
    public class LicaForVedomostSpravkaViewModel
    {
        public int Number { get; set; }

        public string SikCode { get; set; }

        public string Rolia { get; set; }

        public string Imena { get; set; }

        public decimal Suma { get; set; }

        public string IzbName { get; set; }

        public string IzbrDate { get; set; }

        public string IzbrTur { get; set; }

        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }

        public string EGN { get; set; }

        public string SikFullCode { get; set; }

        public Spravki.TurWithSikSpravkaFilter filter { get; set; }

    }
}
