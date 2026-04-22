using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NLicaDopylnenie
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int? IdLice { get; set; }
        public int VidCodetable { get; set; }
        public int Idcodeposition { get; set; }
        public int? Status { get; set; }
        public string User { get; set; }
        public DateTime? Koga { get; set; }

        public virtual NLicaIzbori IdLiceNavigation { get; set; }
    }
}
