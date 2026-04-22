namespace Common.ViewModels.Spravki
{
    using Microsoft.AspNetCore.Mvc.Rendering;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public class SikSpravkaFilter
    {
        public SikSpravkaFilter()
        {
            SikIds = new List<string>();
        }

        [Display(Name = "СИК")]
        public List<string> SikIds { get; set; }

        public List<SelectListItem> AllSik { get; set; }
    }
}
