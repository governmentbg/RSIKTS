using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Common.ViewModels.Spravki
{
    public class TurWithSikSpravkaFilter : SikSpravkaFilter
    {
        public TurWithSikSpravkaFilter()
        {
            AllTurs = new List<SelectListItem> {};
            SelectedTurs = 1;
        }

        [Display(Name = "Тур")]
        public int SelectedTurs { get; set; }

        public List<SelectListItem> AllTurs { get; set; }
    }
}
