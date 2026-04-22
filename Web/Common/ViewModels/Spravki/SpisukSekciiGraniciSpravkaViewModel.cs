using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Spravki
{
    public class SpisukSekciiGraniciSpravkaViewModel
    {
        public int Id { get; set; }
        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }

        public string SikNumb { get; set; }

        public string Borders { get; set; }

        public int NumbVoters { get; set; }
    }
}
