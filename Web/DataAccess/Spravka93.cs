using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class Spravka93
    {
        [Key]
        public int Id { get; set; }

        public string Col1 { get; set; }

        public string Col2 { get; set; }

        public int Col3 { get; set; }

        public decimal Col4 { get; set; }
    }
}
