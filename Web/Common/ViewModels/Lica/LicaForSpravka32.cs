
using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Lica
{
    public class LicaForSpravka32ViewModel
    {
        public int Orders { get; set; }

        public int BirthYear { get; set; }

        public decimal T { get; set; }

        public string IzbName { get; set; }

        public string IzbTur { get; set; }

        public string IzbDate1 { get; set; }

        public string IzbDate2 { get; set; }

        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }

        public string Col1 { get; set; }

        public string Col2 { get; set; }

        public string Col3 { get; set; }

        public string Col4 { get; set; }

        public string Col5 { get; set; }

        public string Col6 { get; set; }

        public string S01 { get; set; }

        public string S02 { get; set; }

        public string S03 { get; set; }

        public string S04 { get; set; }

        public string S05 { get; set; }

        public string S06 { get; set; }

        public string S07 { get; set; }

        public string S08 { get; set; }

        public string S09 { get; set; }

        public string S10 { get; set; }

        public string S { get; set; }

        public Spravki.TurWithSikSpravkaFilter filter { get; set; }
    }
}
