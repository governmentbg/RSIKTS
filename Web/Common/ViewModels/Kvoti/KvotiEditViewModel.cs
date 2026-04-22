using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Common.ViewModels.Kvoti
{
    public class KvotiEditViewModel
    {
        public string Id { get; set; }

        [Display(Name = "Председател")]
        [Required(ErrorMessage = "Полето е задължително")]
        public int Precedatel { get; set; }

        [Display(Name = "Заместник председател")]
        [Required(ErrorMessage = "Полето е задължително")]
        public int ZamestnikPrecedatel { get; set; }

        [Display(Name = "Секретар")]
        [Required(ErrorMessage = "Полето е задължително")]
        public int Sekretar { get; set; }

        [Display(Name = "Членове")]
        [Required(ErrorMessage = "Полето е задължително")]
        public int Chlenove { get; set; }
    }
}
