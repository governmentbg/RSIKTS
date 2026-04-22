using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Spravki
{
    public class IstoriaSikViewModel
    {

        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }
        public string User { get; set; }

        public DateTime Koga { get; set; }

        public string Toa { get; set; }

        public string SIK { get; set; }

        public string KodObr { get; set; }
        public string KodText { get; set; }
        public string OldVal { get; set; }
        public string NewVal { get; set; }
    }
}
