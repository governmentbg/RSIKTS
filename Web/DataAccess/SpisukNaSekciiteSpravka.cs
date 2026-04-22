using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class SpisukNaSekciiteSpravka
    {
        [Key]
        public int Id { get; set; }

        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }

        public string SikNumb { get; set; }

        public string Address { get; set; }

        public string Vid { get; set; }

        public string Priznak { get; set; }
        public string Control { get; set; }
        public string status { get; set; }
        
        public string descript { get; set; }

    }
}
