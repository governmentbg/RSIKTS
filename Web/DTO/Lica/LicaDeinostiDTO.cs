using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.Lica
{
    public class LicaDeinostiDTO
    {
        public int Id { get; set; }

        public string Sekciq { get; set; }

        public string Imena { get; set; }

        public string Dlujnost { get; set; }

        public string PoliticheskaSila { get; set; }

        public string Reshenie { get; set; }

        public int[] Deinosti { get; set; }
        public int IdLiceIzbori { get; set; }
    }
}
