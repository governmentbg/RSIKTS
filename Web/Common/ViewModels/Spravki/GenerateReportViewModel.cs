using Common.Enums.Spravki;
using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Spravki
{
    public class GenerateReportViewModel
    {
        public int Seleciq { get; set; }

        public int Tur { get; set; }

        public int[] AllLicaIds { get; set; }

        public int[] LicaIds { get; set; }

        public Statistics statisticId { get; set; }
    }
}
