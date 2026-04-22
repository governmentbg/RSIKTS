namespace Common.ViewModels.Lica
{
    using Common.ViewModels.Shared;
    using System.Collections.Generic;

    public class LicaRegisterComposite : PaginationViewModel
    {
        public LicaRegisterComposite()
        {
            AllLica = new List<LiceGridViewModel>();
        }

        public string EgnFilter { get; set; }

        public int Sik { get; set; }

        public ICollection<LiceGridViewModel> AllLica { get; set; }
    }
}
