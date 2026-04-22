using Common.ViewModels.Raion;
using Common.ViewModels.Spravki;
using System.Collections.Generic;

namespace Common.ViewModels.Izbori
{
    public class IzboriCompositeViewModel
    {
        public ICollection<RaionViewModel> UserRegions { get; set; }

        public ICollection<RaionViewModel> AllRegions { get; set; }

        public DashboardSpravkaViewModel DashboardSpravka { get; set; }

        public string IzborAlias { get; set; }

        public bool IsUserGlobal { get; set; }

        public string IzborTur { get; set; }

    }
}
