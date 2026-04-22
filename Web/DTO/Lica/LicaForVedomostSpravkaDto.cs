using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.Lica
{
    public class LicaForVedomostSpravkaDto
    {
        public int Number { get; set; }

        public string SikCode { get; set; }

        public string Rolia { get; set; }

        public string Imena { get; set; }

        public decimal Suma { get; set; }

        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }
        public string Egn { get; set; }

        public string SikFullCode { get; set; }
    }
}
