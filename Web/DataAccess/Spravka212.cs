using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace DataAccess
{
    public class Spravka212
    {

        public string NmRajon { get; set; }

        public string SikFullCode { get; set; }

        public string Rolia { get; set; }

        public string Ime { get; set; }

        [Key]
        public string Egn { get; set; }

        public string Sila { get; set; }

        public string Tel { get; set; }
    }
}
