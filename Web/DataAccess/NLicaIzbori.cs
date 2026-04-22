using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NLicaIzbori
    {
        public NLicaIzbori()
        {
            NLicaDopylnenie = new HashSet<NLicaDopylnenie>();
            NLicePariZanap = new HashSet<NLicePariZanap>();
            NLicePariZaplashtane = new HashSet<NLicePariZaplashtane>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int IdLice { get; set; }
        public string IzbAlias { get; set; }
        public int? Tur { get; set; }
        public string Toa { get; set; }
        public int? IdSik { get; set; }
        public int? IdSila { get; set; }
        public string Re { get; set; }
        public int CodeRolia { get; set; }
        public string ImeRolia { get; set; }
        public string User { get; set; }
        public DateTime? Koga { get; set; }
        public int? Hasmaxincome { get; set; }

        public virtual NLica IdLiceNavigation { get; set; }
        public virtual Wnsila IdSilaNavigation { get; set; }
        public virtual Wntoa ToaNavigation { get; set; }
        public virtual ICollection<NLicaDopylnenie> NLicaDopylnenie { get; set; }
        public virtual ICollection<NLicePariZanap> NLicePariZanap { get; set; }
        public virtual ICollection<NLicePariZaplashtane> NLicePariZaplashtane { get; set; }
    }
}
