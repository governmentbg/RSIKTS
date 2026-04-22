using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class Spravka211
    {
        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }

        public string SikFullCode { get; set; }

        public string Rolia { get; set; }

        public string Ime { get; set; }

        [Key]
        public string Egn { get; set; }

        public string Sila { get; set; }

        public string Tel { get; set; }

        public string Re { get; set; }

        public string Obra { get; set; }

        public string Spec { get; set; }
        
        public string SikAddress { get; set; }

        public string descript { get; set; }
    }
}
