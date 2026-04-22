using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Spravki
{
    public class SpravkaSekciiLicaViewModel
    {
        public string NmIzbRajon { get; set; }
        public string NmRajon { get; set; }

        public decimal rowno { get; set; }
        public string Pokazatel { get; set; }
        public int SIK0 { get; set; }

        public int SIK1 { get; set; }

        public int PSIK { get; set; }

        public int Total { get; set; }

        public IzbRaionWithSikFilter filter { get; set; }
    }
}
