using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Lica
{
    public class LicaMassUpdateComposite
    {
        public List<LicaMassUpdateViewModel> AllLica { get; set; }

        public int SelectedDeinostiMassUpdateValue { get; set; }

        public string SelectedResheniqMassUpdateValue { get; set; }
    }
}
