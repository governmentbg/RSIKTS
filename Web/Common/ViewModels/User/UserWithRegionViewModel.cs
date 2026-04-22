namespace Common.ViewModels.User
{
    using Common.ViewModels.Raion;
    using System.Collections.Generic;

    public class UserWithRegionViewModel
    {
        public UserWithRegionViewModel()
        {
            allRaioni = new List<RaionViewModel>();
        }

        public ICollection<RaionViewModel> allRaioni;
    }
}
