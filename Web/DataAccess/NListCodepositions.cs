using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NListCodepositions
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int Pkode { get; set; }
        public string IzbAllias { get; set; }
        public int Nkode { get; set; }
        public string Nime { get; set; }
        public int? Status { get; set; }
        public int Calc { get; set; }

        public virtual NListCodetables PkodeNavigation { get; set; }

    }
}
