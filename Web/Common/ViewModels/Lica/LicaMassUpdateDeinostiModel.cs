using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Lica
{
    public class LicaMassUpdateDeinostiModel
    {
        public int Deinost { get; set; }

        public int[] AllLicaIds { get; set; }

        public int[] LicaIds { get; set; }
    }
}
