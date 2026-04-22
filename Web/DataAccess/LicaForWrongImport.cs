using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class LicaForWrongImport
    {
        [Key]
        public int Id { get; set; }
        public string Egn { get; set; }

        public string Im1 { get; set; }

        public string Im2 { get; set; }

        public string Im3 { get; set; }

        public string SIK { get; set; }

        public string Rolja { get; set; }

        public string Obra { get; set; }

        public string Spec { get; set; }

        public string Tel { get; set; }

        public string Opisanie { get; set; }

        public int Status { get; set; }
    }
}
