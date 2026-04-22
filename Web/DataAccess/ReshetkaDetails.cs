using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class ReshetkaDetails
    {
        [Key]
        public string Nkod { get; set; }

        public string Nime { get; set; }

        public int CntHeadMembers { get; set; }

        public int CntMembers { get; set; }
    }
}
