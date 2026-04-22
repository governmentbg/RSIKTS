namespace Common.ViewModels.Parameters
{
    using Microsoft.AspNetCore.Mvc.Rendering;
    using System;
    using System.ComponentModel.DataAnnotations;
    using System.Text;

    public class IzbDateViewModel
    {

        public int Id { get; set; }

        [Display(Name = "Наименование")]
        [Required(ErrorMessage = "Полето е задължително")]
        [StringLength(int.MaxValue, MinimumLength = 3)]
        public string Naimenovanie { get; set; }

        [Display(Name = "Дата на тур 1")]
        [Required(ErrorMessage = "Полето е задължително")]
        public DateTime DateTur1 { get; set; }

        [Display(Name = "Дата на тур 2")]
        public DateTime? DateTur2 { get; set; }
    }
}
