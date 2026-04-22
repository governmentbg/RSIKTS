using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace Common.ViewModels.Parameters
{
    public class IzbRajonParamViewModel
    {
        [Required]
        public string Nkod { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        public string NIme { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Мин. брой членове")]
        public int MinMembers { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Макс. брой членове")]
        public int MaxMembers { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        public int Status { get; set; }
    }
}
