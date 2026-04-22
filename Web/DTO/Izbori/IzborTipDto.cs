using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.Izbori
{
    public class IzborTipDto
    {
        public int Id { get; set; }

        public string Nkod { get; set; }

        public string Nime { get; set; }

        public int Tur { get; set; }

        public bool Status { get; set; }
    }
}
