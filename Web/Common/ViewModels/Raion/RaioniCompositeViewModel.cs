namespace Common.ViewModels.Raion
{
    using Common.ViewModels.Shared;
    using System.Collections.Generic;

    public class RaioniCompositeViewModel : PaginationViewModel
    {
        public RaioniCompositeViewModel()
        {
            AllRaioni = new List<RaionMainViewModel>();
        }

        public RaionAddViewModel RaionAddModel { get; set; }

        public string ToaIdFilter { get; set; }

        public ICollection<RaionMainViewModel> AllRaioni { get; set; }
    }
}
