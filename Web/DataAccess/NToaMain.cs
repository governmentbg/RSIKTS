using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NToaMain
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Nrec { get; set; }
        public string IzbAlias { get; set; }
        public string Toa { get; set; }
        public int Tur { get; set; }
        public int? StatusMaster { get; set; }
        public string Ime { get; set; }
        public string Tel { get; set; }
        public string Tel1 { get; set; }
        public string Izr { get; set; }
        public string Obl { get; set; }
        public string Obs { get; set; }
        public string Raj { get; set; }
        public string Nas { get; set; }
        public string Ul { get; set; }
        public string Nom { get; set; }
        public string JkKv { get; set; }
        public string Blok { get; set; }
        public string Vh { get; set; }
        public string Et { get; set; }
        public string Ap { get; set; }
        public string Pk { get; set; }
        public string Epod { get; set; }
        public string Ipod { get; set; }
        public string Pred { get; set; }
        public string Sekr { get; set; }
        public int? Nsik { get; set; }
        public string Pris { get; set; }
        public string R1 { get; set; }
        public string R2 { get; set; }
        public int? Ano { get; set; }
        public string Bul { get; set; }

        public virtual WnjkKv JkKvNavigation { get; set; }
        public virtual Wnasm NasNavigation { get; set; }
        public virtual Wnobl OblNavigation { get; set; }
        public virtual Wnobs ObsNavigation { get; set; }
        public virtual Wntoa RajNavigation { get; set; }
        public virtual Wntoa ToaNavigation { get; set; }
        public virtual Wnuli UlNavigation { get; set; }
    }
}
