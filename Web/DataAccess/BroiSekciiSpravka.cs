using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class BroiSekciiSpravka
    {
        public string NmIzbRajon { get; set; }

        [Key]
        public string NmRajon { get; set; }

        public int Total { get; set; }

        public int Basic { get; set; }

        public int Mobail { get; set; }

        public int Official { get; set; }

        public int Another { get; set; }
    }
}
