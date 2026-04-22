using System;
using System.Collections.Generic;

namespace DataAccess
{
    public partial class WnjkKv
    {
        public WnjkKv()
        {
            NToaMain = new HashSet<NToaMain>();
        }

        public string Nkod { get; set; }
        public string Nime { get; set; }

        public virtual ICollection<NToaMain> NToaMain { get; set; }
    }
}
