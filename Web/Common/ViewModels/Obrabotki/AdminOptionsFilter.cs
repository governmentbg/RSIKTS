using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Common.ViewModels.Obrabotki
{
    public class AdminOptionsFilter
    {

        public AdminOptionsFilter()
        {
            DateTur1 = DateTime.Now;
            DateTur2 = DateTime.Now;
        }

        public int Option { get; set; }

        public List<SelectListItem> AllTipove { get; set; }
        
        [Display(Name = "Тип")]
        [RequiredIf("Option",1, ErrorMessage = "Полето е задължително")]
        public string Tip { get; set; }

        [Display(Name = "Наименование")]
        [RequiredIf("Option", 1, ErrorMessage = "Полето е задължително")]
        [StringLength(int.MaxValue, MinimumLength = 3)]
        public string Naimenovanie { get; set; }

        [Display(Name = "Дата на тур 1")]
        [RequiredIf("Option", 1, ErrorMessage = "Полето е задължително")]
        public DateTime DateTur1 { get; set; }

        [Display(Name = "Дата на тур 2")]
        [RequiredIf("Option", 1, ErrorMessage = "Полето е задължително")]
        public DateTime DateTur2 { get; set; }
    }
}
