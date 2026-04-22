using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class Wnizbraion
    {
        public string Izb_Alias { get; set; }

        [Key]
        public string Nkod { get; set; }

        public string Nime { get; set; }

        public string Prefix { get; set; }

        public int Min_Broi_Sik { get; set; }

        public int Max_Broi_Sik { get; set; }

        public int Status { get; set; } 

    }
}
