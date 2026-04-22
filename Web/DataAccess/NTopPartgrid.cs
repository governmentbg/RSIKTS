using System;
using System.Collections.Generic;

namespace DataAccess
{
    public partial class NTopPartgrid
    {
        public int Id { get; set; }
        public string Izb_Alias { get; set; }
        public string Toa { get; set; }
        public int? Id_Sek { get; set; }
        public string Code_Wnsila { get; set; }
        public int? Code_Rolia { get; set; }
        public int? Status { get; set; }
        public string User { get; set; }
        public DateTime? Koga { get; set; }

        public int Order_Rolja { get; set; }
    }
}
