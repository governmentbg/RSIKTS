using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Common.ViewModels.Spravki
{
    public class RoliSpravkaFilter
    {

        [Display(Name = "Роля")]
        //[Required(ErrorMessage = "Полето е задължително")]
        public string Rolq { get; set; }

        public List<SelectListItem> AllRoli { get; set; }
    }
}
