namespace Common.ViewModels.Parameters
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Text;

    public class ParametersViewModel
    {
        [Required]
        public string Kod { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        public string Opisanie { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Значение")]
        public string Znachenie { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        public bool Status { get; set; }
    }
}
