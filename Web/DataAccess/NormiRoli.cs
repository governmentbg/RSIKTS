using System;
using System.Collections.Generic;

namespace DataAccess
{
    public partial class NormiRoli
    {
        public int Id { get; set; }
        public string IzbAllias { get; set; }
        public int? Tur { get; set; }
        public int VidCodetable_1 { get; set; }
        public int Idcodeposition_1 { get; set; }
        public int VidCodetable { get; set; }
        public int Idcodeposition { get; set; }
        public decimal? Pari { get; set; }
        public int? Status { get; set; }
        public string User { get; set; }
        public DateTime? Koga { get; set; }
    }
}
