using System;
using System.Collections.Generic;

namespace DataAccess
{
    public partial class NTopPartkvoti
    {
        public int Id { get; set; }
        public string IzbAlias { get; set; }
        public string IzbRajon { get; set; }
        public string Toa { get; set; }
        public int? StatusKvoti { get; set; }
        public string User { get; set; }
        public string CodeWnsila { get; set; }
        public int? CodeRolja { get; set; }
        public int? SikClenove { get; set; }
        public DateTime? Koga { get; set; }
    }
}
