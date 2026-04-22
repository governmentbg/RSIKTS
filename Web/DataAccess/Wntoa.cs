using System;
using System.Collections.Generic;

namespace DataAccess
{
    public partial class Wntoa
    {
        public Wntoa()
        {
            Aspnetusers = new HashSet<Aspnetusers>();
            NLicaIzbori = new HashSet<NLicaIzbori>();
            NToaMainRajNavigation = new HashSet<NToaMain>();
            NToaMainToaNavigation = new HashSet<NToaMain>();
            Siks = new HashSet<Siks>();
        }

        public string Nkod { get; set; }
        public string Nime { get; set; }

        public virtual ICollection<Aspnetusers> Aspnetusers { get; set; }
        public virtual ICollection<NLicaIzbori> NLicaIzbori { get; set; }
        public virtual ICollection<NToaMain> NToaMainRajNavigation { get; set; }
        public virtual ICollection<NToaMain> NToaMainToaNavigation { get; set; }
        public virtual ICollection<Siks> Siks { get; set; }
    }
}
