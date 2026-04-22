using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NLicaZamestvane
    { 
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int? IdLiceNovo { get; set; }
        public int? IdLiceStaro { get; set; }
        public string User { get; set; }
        public DateTime? Koga { get; set; }

        //public virtual NLicaIzbori IdLiceNavigation { get; set; }
    }
}
