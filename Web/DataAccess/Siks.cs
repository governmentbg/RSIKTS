using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class Siks
    {
        public Siks()
        {
            SiksVidove = new HashSet<SiksVidove>();
            SiksPodvijni = new HashSet<SiksPodvijni>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdSek { get; set; }
        public string IzbAlias { get; set; }
        public int? Tur { get; set; }
        public string IzbRajon { get; set; }
        public string Toa { get; set; }
        public string AaBbCc { get; set; }
        public string Sik { get; set; }
        public int StatusSekcia { get; set; }
        public string Obl { get; set; }
        public string Obs { get; set; }
        public string Nas { get; set; }
        public string JkKv { get; set; }
        public string Ul { get; set; }
        public string Nom { get; set; }
        public string Blok { get; set; }
        public string Tel { get; set; }
        public string AdrIme { get; set; }
        public string User { get; set; }
        public DateTime? Koga { get; set; }
        //v.2
        public int? BroiMembers { get; set; }
        public int? NumbVoters { get; set; }
        public string Borders { get; set; }

        public virtual ICollection<SiksVidove> SiksVidove { get; set; }

        public virtual Wnasm NasNavigation { get; set; }
        public virtual Wnobl OblNavigation { get; set; }
        public virtual Wnobs ObsNavigation { get; set; }
        public virtual Wntoa ToaNavigation { get; set; }
        //v.2
        public virtual ICollection<SiksPodvijni> SiksPodvijni { get; set; }

    }
}
