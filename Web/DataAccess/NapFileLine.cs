using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class NapFileLine
    {
        [Key]
        public string Line { get; set; }
    }
}
