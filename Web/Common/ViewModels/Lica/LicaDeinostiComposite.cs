using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Common.ViewModels.Lica
{
    public class LicaDeinostiComposite
    {
        public LicaMassUpdateComposite TableModel { get; set; }

        [Display(Name = "Дейност")]
        public ICollection<SelectListItem> AllDeinosti { get; set; }

        [Display(Name = "СИК")]
        public ICollection<SelectListItem> AllSik { get; set; }
    }
}
