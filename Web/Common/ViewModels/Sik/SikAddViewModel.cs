namespace Common.ViewModels.Sik
{
    using Common.ViewModels.Raion;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public class SikAddViewModel
    {
        public string Izb_Alias { get; set; }

        public int TUR { get; set; }

        public string IzbRajon { get; set; }

        [Display(Name = "Административен район")]
        [Required(ErrorMessage = "Полето е задължително")]
        public string TOA { get; set; }

        [Display(Name = "Пълен номер")]
        //[Required(ErrorMessage = "Полето е задължително")]
        public string AABBCC { get; set; }

        [Display(Name = "СИК")]
        [Required(ErrorMessage = "Полето е задължително")]
        public string Sik { get; set; }

        [Display(Name = "Област")]
        [Required(ErrorMessage = "Полето е задължително")]
        public string Obl { get; set; }

        [Display(Name = "Община")]
        [Required(ErrorMessage = "Полето е задължително")]
        public string Obs { get; set; }

        [Display(Name = "Населено място")]
        [Required(ErrorMessage = "Полето е задължително")]
        [Range(1,Int32.MaxValue,ErrorMessage = "Полето е задължително")]
        public string Kodnsm { get; set; }

        [Display(Name = "Ж.К.")]
        [Required(ErrorMessage = "Полето е задължително")]
        public string JK_KV { get; set; }

        [Display(Name = "Улица")]
        [Required(ErrorMessage = "Полето е задължително")]
        public string ULKOD { get; set; }

        [Display(Name = "Номер")]
        [MaxLength(6, ErrorMessage = "Невалидна дължина")]
        //[Required(ErrorMessage = "Полето е задължително")]
        public string Nom { get; set; }

        [Display(Name = "Блок")]
        [MaxLength(6, ErrorMessage = "Невалидна дължина")]
        //[Required(ErrorMessage = "Полето е задължително")]
        public string Blok { get; set; }

        [Display(Name = "Допълнително описание")]
        //[Required(ErrorMessage = "Полето е задължително")]
        public string ADR_IME { get; set; }

        public string USER { get; set; }

        [Display(Name = "Вид")]
        [Required(ErrorMessage = "Полето е задължително")]
        public int Vidove { get; set; }

        [Display(Name = "Признак")]
        //[Required(ErrorMessage = "Полето е задължително")]
        public int[] Priznaci { get; set; }

        public bool Status { get; set; }

        public List<SelectListItem> AllOblasti { get; set; }

        public List<SelectListItem> AllObjini { get; set; }

        public List<SelectListItem> AllAdministrativniRaioni { get; set; }

        public List<SelectListItem> AllNaseleniMesta { get; set; }

        public List<SelectListItem> AllUlici { get; set; }

        public List<SelectListItem> AllKvartali { get; set; }

        public List<SelectListItem> AllVidove { get; set; }

        public List<SelectListItem> AllPriznaci { get; set; }

        public List<RaionForSikPodvijnaSekciqViewModel> AllToaForPodvijnaSekciq { get; set; }

        //v.2
        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Брой членове в секция")]
        public int MaxBroiChlenove { get; set; }

        [Display(Name = "Брой избиратели")]
        public int NUMBVOTERS { get; set; }

        [Display(Name = "Граници на секцията")]
        public string BORDERS { get; set; }
    }
}
