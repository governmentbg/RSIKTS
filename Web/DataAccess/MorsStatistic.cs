using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class MorsStatistic
    {
        public string Izr_Rajon { get; set; }

        public string N_Toa_Main_Bul { get; set; }

        public string Lica_Fullname { get; set; }

        [Key]
        public string Lica_Egn { get; set; }

        public string N_Top_Main_Description { get; set; }

        public string N_Top_Main_Datetur { get; set; }

        public string Siks_Fullcode { get; set; }

        public decimal Suma { get; set; }

        public string Slovom { get; set; }

    }
}
