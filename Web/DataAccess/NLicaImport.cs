using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NLicaImport
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string Egn { get; set; }
        public string Im1 { get; set; }
        public string Im2 { get; set; }
        public string Im3 { get; set; }
        public string Sik { get; set; }
        public string Rolja { get; set; }
        public string Obra { get; set; }
        public string Spec { get; set; }
        public string Tel { get; set; }
        public int Status { get; set; }
        public string Opisanie { get; set; }
        public string User { get; set; }
        public string Pas1 { get; set; }

    }
}
