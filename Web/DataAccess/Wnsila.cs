using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class Wnsila
    {
        public Wnsila()
        {
            Aspnetusers = new HashSet<Aspnetusers>();
            NLicaIzbori = new HashSet<NLicaIzbori>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdParty { get; set; }
        public string IzbAlias { get; set; }
        public string Nkod { get; set; }
        public string ShortName { get; set; }
        public string Nime { get; set; }
        public string LegalKod { get; set; }
        public int? StatusPartii { get; set; }

        public virtual ICollection<Aspnetusers> Aspnetusers { get; set; }
        public virtual ICollection<NLicaIzbori> NLicaIzbori { get; set; }
    }
}
