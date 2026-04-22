using Common.ViewModels.Shared;
using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Lica
{
    public class LicaFilterCompositeViewModel : PaginationViewModel
    {
        public ICollection<LiceGridViewModel> AllLica { get; set; }
    }
}
