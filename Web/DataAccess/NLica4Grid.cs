using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess
{
    public partial class NLica4Grid
    {
        public NLica4Grid()
        {
        }

        public int Id { get; set; }

        public string Sekciq { get; set; }

        public string Egn { get; set; }

        public string Imena { get; set; }

        public string Dlujnost { get; set; }

        public string PoliticheskaSila { get; set; }

        public string Reshenie { get; set; }
        public int IdLiceIzbori { get; set; }
    }
}
