using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class MsbdStatistic
    {
        [Key]
        public string Lica_Egn { get; set; }

        public string Lica_Fullname { get; set; }

        public string Lica_Izbori_Rolia { get; set; }

        public string Siks_Fullcode { get; set; }

        public decimal Par_Dc_20 { get; set; }

    }
}
