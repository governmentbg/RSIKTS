using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Spravki
{
    public class BroiSekciiSpravkaViewModel
    {

        public string NmIzbor { get; set; }
        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }

        public int Total { get; set; }

        public int Basic { get; set; }

        public int Mobail { get; set; }

        public int Official { get; set; }

        public int Another { get; set; }
    }
}
