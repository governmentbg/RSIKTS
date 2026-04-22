namespace Common.ViewModels.Sik
{
    using Common.ViewModels.Shared;
    using System.Collections.Generic;

    public class SikCompositeViewModel : PaginationViewModel
    {
        public SikCompositeViewModel()
        {
            AllSiks = new List<SikBasicViewModel>();
        }

        public SikBasicViewModel RaionAddModel { get; set; }

        public string SikFilter { get; set; }

        public ICollection<SikBasicViewModel> AllSiks { get; set; }
    }
}
