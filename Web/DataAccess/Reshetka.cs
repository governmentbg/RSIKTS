using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class Reshetka
    {
        [Key]
        public int Id_Sek { get; set; }

        public string SikFullCode { get; set; }

        public string Sum401 { get; set; }

        public int Cnt401 { get; set; }

        public string Sum402 { get; set; }

        public int Cnt402 { get; set; }

        public string Sum403 { get; set; }

        public int Cnt403 { get; set; }

        public string Sum404_1 { get; set; }

        public string Sum404_2 { get; set; }

        public string Sum404_3 { get; set; }

        public string Sum404_4 { get; set; }

        public string Sum404_5 { get; set; }

        public string Sum404_6 { get; set; }

        public int Cnt404 { get; set; }

    }
}
