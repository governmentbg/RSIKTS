namespace Common.ViewModels.Spravki
{
    using Common.Enums.Spravki;
    using Common.ViewModels.Shared;
    using System.Collections.Generic;

    public class NomenklatureComposite : PaginationViewModel
    {
        public NomenklatureComposite()
        {
            AllNomenklatures = new List<NomenklaturaBasicViewModel>();
        }
        public NomenklatureIds NomenklatureId { get; set; }

        public ICollection<NomenklaturaBasicViewModel> AllNomenklatures { get; set; }

        public string NameFilter { get; set; }
    }
}
