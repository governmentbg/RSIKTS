using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NTopParameters
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string IzbAlias { get; set; }
        public string Kod { get; set; }
        public string Description { get; set; }
        public string Znachenie { get; set; }
        public int? StatusParameters { get; set; }
    }
}
