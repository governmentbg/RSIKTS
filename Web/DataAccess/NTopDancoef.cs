using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NTopDancoef
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdCoef { get; set; }
        public string IzbAllias { get; set; }
        public string Nred { get; set; }
        public string FieldName{ get; set; }
        public string Tekst { get; set; }
        public decimal? CoefStoinost { get; set; }
        public int? NapKolona { get; set; }
        public int? StatusCoef { get; set; }
    }
}
