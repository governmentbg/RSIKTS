using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Common.ViewModels.List
{
    public class CodePositionsWithMoneyViewModel
    {
        public int Id { get; set; }

        public int Pkode { get; set; }

        public int Nkode { get; set; }

        [Display(Name = "Описание")]
        [Required(ErrorMessage = "Полето е задължително")]
        public string Nime { get; set; }

        [Display(Name = "Пари")]
        [Required(ErrorMessage = "Полето е задължително")]
        public decimal? Money { get; set; }

        [Display(Name = "Статус")]
        public bool Status { get; set; }

        public string User { get; set; }

        public int Tur { get; set; }

        public DateTime? Koga { get; set; }
    }
}
