using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class LicaForGrid
    {
        [Key]
        public int Id { get; set; }

        public string SIK { get; set; }

        public string Egn { get; set; }

        public string Ime { get; set; }

        public string Dlyzjnost { get; set; }

        public string Partia { get; set; }
        public string Deistvie { get; set; }
        public string Reshenie { get; set; }
        public string Telefon { get; set; }
        public int Tur { get; set; }
    }
}
