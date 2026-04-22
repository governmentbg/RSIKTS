using Common.Enums.Lica;
using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Lica
{
    public class LicaMassUpdateResheniqModel
    {
        public SelectionType Seleciq { get; set; }

        public string Reshenie { get; set; }

        public int[] AllLicaIds { get; set; }

        public int[] LicaIds { get; set; }
    }
}
