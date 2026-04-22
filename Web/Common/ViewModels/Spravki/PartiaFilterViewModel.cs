namespace Common.ViewModels.Spravki
{
    using Microsoft.AspNetCore.Mvc.Rendering;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public class PartiaFilterViewModel
    {
        [Display(Name="Партия")]
        public string Sila { get; set; }

        public List<SelectListItem> AllSili { get; set; }
    }
}
