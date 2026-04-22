namespace Common.ViewModels.List
{
    using Microsoft.AspNetCore.Mvc.Rendering;
    using System.Collections.Generic;

    public class NormiRoliComposite
    {
        public ICollection<NormiRoliWithMoneyViewModel> Roli { get; set; }

        public IEnumerable<SelectListItem> VidSekcii { get; set; }

        public int Tur { get; set; }
    }
}
