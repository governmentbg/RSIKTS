using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class Spravka23Set
    {
        [Key]
        public int Id { get; set; }
        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }

        public string SikFullCode { get; set; }

        public string ImeNovo { get; set; }

        public string EgnNovo { get; set; }

        public string ImeStaro { get; set; }

        public string EgnStaro { get; set; }

        public string Rolia { get; set; }

        public string Koga { get; set; }

        public string Partia { get; set; }
        public string TEL { get; set; }
        public string Deistvie { get; set; }

    }
}
