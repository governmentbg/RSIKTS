using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NLicePariZanap
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int IdLice { get; set; }
        public string CodeDancoef { get; set; }
        public decimal? Pari { get; set; }
        public DateTime? Koga { get; set; }

        public virtual NLicaIzbori IdLiceNavigation { get; set; }
    }
}
