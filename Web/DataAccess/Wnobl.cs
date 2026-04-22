using System;
using System.Collections.Generic;

namespace DataAccess
{
    public partial class Wnobl
    {
        public Wnobl()
        {
            NToaMain = new HashSet<NToaMain>();
            Siks = new HashSet<Siks>();
        }

        public string Nkod { get; set; }
        public string Nime { get; set; }

        public virtual ICollection<NToaMain> NToaMain { get; set; }
        public virtual ICollection<Siks> Siks { get; set; }
    }
}
