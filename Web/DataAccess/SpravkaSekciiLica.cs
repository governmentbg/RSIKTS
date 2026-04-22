using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class SpravkaSekciiLica
    {
        [Key]
        public int Id { get; set; }
        public string NmIzbRajon { get; set; }
        public string NmRajon { get; set; }
        public decimal rowno { get; set; }
        public string Pokazatel { get; set; }
        public int SIK0 { get; set; }

        public int SIK1 { get; set; }

        public int PSIK { get; set; }

        public int Total { get; set; }
    }
}
