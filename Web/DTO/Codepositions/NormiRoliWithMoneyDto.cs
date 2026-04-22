using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.Codepositions
{
    public class CodePositionWithMoneyDto
    {
        public int Id { get; set; }

        public int Pkode { get; set; }

        public int Nkode { get; set; }

        public string Nime { get; set; }

        public bool Status { get; set; }

        public int Tur { get; set; }

        public decimal? Money { get; set; }
    }
}
