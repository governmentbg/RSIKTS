using Common.ViewModels.Spravki;
using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Obrabotki
{
    public class ObrabotkiCompositeModel
    {
        public SikSpravkaFilter SikFilter { get; set; }

        public TurWithSikSpravkaFilter TurAndSikFilter { get; set; }

        public ObrabotkiFileForNapViewModel FileForNapViewModel { get; set; }
    }
}
