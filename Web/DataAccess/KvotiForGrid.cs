using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class KvotiForGrid
    {
        [Key]
        public string Nkod { get; set; }

        public string Nime { get; set; }

        public int Total { get; set; }

        public int sum401 { get; set; }

        public int sum402 { get; set; }

        public int sum403 { get; set; }

        public int sum404 { get; set; }
    }
}
