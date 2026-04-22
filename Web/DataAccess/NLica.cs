using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NLica
    {
        public NLica()
        {
            NLicaIzbori = new HashSet<NLicaIzbori>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]        
        public int Id { get; set; }
        public int? VidId { get; set; }
        public string Egn { get; set; }
        public string Im1 { get; set; }
        public string Im2 { get; set; }
        public string Im3 { get; set; }
        public string Obra { get; set; }
        public string Spec { get; set; }
        public string Tel { get; set; }
        public string Pas1 { get; set; }
        public string Pas2 { get; set; }
        public DateTime? Pas3 { get; set; }
        public string Pas4 { get; set; }
        public string Naz { get; set; }
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
        public int? Impstatus { get; set; }
        public string Impmessage { get; set; }
        public string User { get; set; }
        public DateTime? Koga { get; set; }

        public virtual ICollection<NLicaIzbori> NLicaIzbori { get; set; }
    }
}
