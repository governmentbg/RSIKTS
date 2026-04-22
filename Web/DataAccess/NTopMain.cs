using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NTopMain
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string IzbAlias { get; set; }
        public string Description { get; set; }
        public DateTime? Date1tur { get; set; }
        public DateTime? Date2tur { get; set; }
        public int? StatusParameters { get; set; }
    }
}
