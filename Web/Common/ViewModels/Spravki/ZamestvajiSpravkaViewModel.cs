using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Spravki
{
    public class ZamestvajiSpravkaViewModel
    {
        public int Id { get; set; }

        public string NmIzbRajon { get; set; }

        public string NmIzbor { get; set; }

        public string NmRajon { get; set; }

        public string SikFullCode { get; set; }

        public string ImeNovo { get; set; }
        public string EgnNovo { get; set; }

        public string ImeStaro { get; set; }

        public string EgnStaro { get; set; }

        public string Rolia { get; set; }

        public string Partia { get; set; }

        public string Koga { get; set; }

        public string Telefon { get; set; }
        public string Deistvie { get; set; }


        public SikSpravkaFilter filter { get; set; }
    }
}
