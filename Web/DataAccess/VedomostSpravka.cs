using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class VedomostSpravka
    {
        [Key]
        public int Num { get; set; }

        public string SikCode { get; set; }

        public string Rolia { get; set; }

        public string Ime { get; set; }

        public decimal Suma { get; set; }

        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }

        public string Egn { get; set; }

        public string SikFullCode { get; set; }
    }
}
