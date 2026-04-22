using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class SpisukSekciiGraniciSpravka
    {
        [Key]
        public int Id { get; set; }

        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }

        public string SikNumb { get; set; }

        public string Borders { get; set; }

        public int NumbVoters { get; set; }
    }
}
