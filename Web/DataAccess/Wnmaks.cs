using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class Wnmaks
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdShablon { get; set; }
        public string IzbAlias { get; set; }
        public string Nkod { get; set; }
        public string Nime { get; set; }
        public byte? StatusSh { get; set; }
    }
}
