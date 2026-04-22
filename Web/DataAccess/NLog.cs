using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NLog
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdLog { get; set; }
        public string User { get; set; }
        public DateTime Koga { get; set; }
        public int Action { get; set; }
        public string KodObrabotka { get; set; }
        public string ImeObrabotka { get; set; }
        public int? Aaa { get; set; }
    }
}
