using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Common.ViewModels.Kvoti
{
    public class ReshetkaEditViewModel
    {
        public int SikId { get; set; }

        [Display(Name="Председател")]
        public string PrecedatelPartiqId { get; set; }

        [Display(Name = "Заместник председател")]
        public string ZamestnikPrecedatelPartiqId { get; set; }

        [Display(Name = "Секретар")]
        public string SekretarPartiqId { get; set; }

        [Display(Name = "Член")]
        public string Chlen1PartiqId { get; set; }

        [Display(Name = "Член")]
        public string Chlen2PartiqId { get; set; }

        [Display(Name = "Член")]
        public string Chlen3PartiqId { get; set; }

        [Display(Name = "Член")]
        public string Chlen4PartiqId { get; set; }

        [Display(Name = "Член")]
        public string Chlen5PartiqId { get; set; }

        [Display(Name = "Член")]
        public string Chlen6PartiqId { get; set; }

        public List<SelectListItem> AllPoliticheskiSili { get; set; }
    }
}
