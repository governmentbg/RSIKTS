using System;
using System.Collections.Generic;

namespace DataAccess
{
    public partial class Wnuli
    {
        public Wnuli()
        {
            NToaMain = new HashSet<NToaMain>();
        }

        public string Nkod { get; set; }
        public string WnasmNkod { get; set; }
        public string WnuliNkod { get; set; }
        public string Nime { get; set; }

        public virtual ICollection<NToaMain> NToaMain { get; set; }
    }
}
