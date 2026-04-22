using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class SiksVidove
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string IzbAllias { get; set; }
        public int Tur { get; set; }
        public int IdSik { get; set; }
        public int Vid_codetable { get; set; }
        public int Idcodeposition { get; set; }
        public int? Status { get; set; }

        public virtual Siks IdSikNavigation { get; set; }
    }
}
