using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace DataAccess
{
    public class SikForGrid
    {
        [Key]
        public int IdSek { get; set; }

        public string Sik { get; set; }

        public string AdrIme { get; set; }

        public int StatusSekcia { get; set; }

        public string Vid { get; set; }

        public string Descript { get; set; }

    }
}
