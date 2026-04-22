using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NListCodetables
    {
        public NListCodetables()
        {
            NListCodepositions = new HashSet<NListCodepositions>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Nkode { get; set; }
        public string Nime { get; set; }
        public int Status { get; set; }

        public virtual ICollection<NListCodepositions> NListCodepositions { get; set; }
    }
}
