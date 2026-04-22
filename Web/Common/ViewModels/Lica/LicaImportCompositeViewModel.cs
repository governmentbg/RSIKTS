namespace Common.ViewModels.Lica
{
    using Microsoft.AspNetCore.Mvc.Rendering;
    using System.Collections.Generic;

    public class LicaImportCompositeViewModel
    {
        public List<LicaImportViewModel> allLica { get; set; }

        public List<SelectListItem> AllPoliticheskiSili { get; set; }

        public int PoliticheskaSila { get; set; }
        public string file { get; set; }
    }
}
