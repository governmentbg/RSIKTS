namespace Common.ViewModels.Lica
{
    using Microsoft.AspNetCore.Mvc.Rendering;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public class LicaAddViewModel
    {
        public bool FromSelectedSik { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        public int Vid { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [MinLength(10, ErrorMessage = "Полето съдържа невалиден брой символи")]
        [MaxLength(10, ErrorMessage = "Полето съдържа невалиден брой символи")]
        [RegularExpression("^[0-9]*$", ErrorMessage = "Полето съдържа невалидни символи")]
        public string Egn { get; set; }

        [Display(Name = "Име")]
        [Required(ErrorMessage = "Полето е задължително")]
        [RegularExpression("^[а-яА-Я- ]+(([а-яА-Я- ])?[а-яА-Я- ]*)*$", ErrorMessage = "Невалидно име")]
        public string Ime1 { get; set; }

        [Display(Name = "Презиме")]
        [RegularExpression("^[а-яА-Я- ]+(([а-яА-Я])?[а-яА-Я- ]*)*$", ErrorMessage = "Невалидно име")]
        public string Ime2 { get; set; }

        [Display(Name = "Фамилия")]
        [Required(ErrorMessage = "Полето е задължително")]
        [RegularExpression("^[а-яА-Я- ]+(([а-яА-Я- ])?[а-яА-Я- ]*)*$", ErrorMessage = "Невалидно име")]
        public string Ime3 { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public string Lk { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public DateTime IzdadenaNa { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public string RuNaMVR { get; set; }

        [Display(Name = "Националност")]
        [Required(ErrorMessage = "Полето е задължително")]
        public string Nacionalnost { get; set; }

        [Display(Name = "Телефон")]
        //[Required(ErrorMessage = "Полето е задължително")]
        public string Telephone { get; set; }

        [Display(Name = "СИК")]
        [Required(ErrorMessage = "Полето е задължително")]
        [Range(1, Int32.MaxValue,ErrorMessage = "Полето е задължително")]
        public int IdSik { get; set; }

        [Display(Name = "Роля")]
        [Required(ErrorMessage = "Полето е задължително")]
        [Range(1, Int32.MaxValue, ErrorMessage = "Полето е задължително")]
        //        [RangeIf("JeZamestva", false, 1, Int32.MaxValue)]
        public int Rolq { get; set; }

        [Display(Name = "Решение")]
        [Required(ErrorMessage = "Полето е задължително")]
        public string Reshenie { get; set; }

        [Display(Name = "Сила")]
        [Required(ErrorMessage = "Полето е задължително")]
        [Range(1, Int32.MaxValue, ErrorMessage = "Полето е задължително")]
        public int PoliticheskaSila { get; set; }

        [Display(Name = "Образование")]
        [Required(ErrorMessage = "Полето е задължително")]
        public string Obrazovanie { get; set; }

        [Display(Name = "Специалност")]
        [Required(ErrorMessage = "Полето е задължително")]
        public string Specialnost { get; set; }

        [Display(Name = "Заместан")]
        [RangeIf("JeZamestva", true,  1, Int32.MaxValue)]
        public int IdLiceZamestvan { get; set; }

        public int JeZamestva { get; set; }

        [Display(Name = "Дейности")]
        //[Required(ErrorMessage = "Полето е задължително")]
        public int[] Deinosti { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public string Oblast { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public string Objina { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public string Raion { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public string NaselenoMqsto { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public string ZipCode { get; set; }
        
        //[Required(ErrorMessage = "Полето е задължително")]
        public string Ulica { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public string Nomer { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public string Jk { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public string Blok { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public string Vhod { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        public string Etaj { get; set; }
        
        //[Required(ErrorMessage = "Полето е задължително")]
        public string Apartament { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        public bool DohodaEpoGolqm { get; set; }

        public string USER { get; set; }

        public string ImpMessage { get; set; }

        public List<SelectListItem> AllDeinosti { get; set; }

        public List<SelectListItem> AllSpecialnosti { get; set; }

        public List<SelectListItem> AllObrazovaniq { get; set; }

        public List<SelectListItem> AllPoliticheskiSili { get; set; }

        public List<SelectListItem> AllRoli { get; set; }

        public List<SelectListItem> AllSik { get; set; }

        public List<SelectListItem> AllNacionalnosti { get; set; }

        public List<SelectListItem> AllRuNaMvr { get; set; }

        public List<SelectListItem> AllOblasti { get; set; }

        public List<SelectListItem> AllObjini { get; set; }

        public List<SelectListItem> AllAdministrativniRaioni { get; set; }

        public List<SelectListItem> AllNaseleniMesta { get; set; }

        public List<SelectListItem> AllUlici { get; set; }

        public List<SelectListItem> AllKvartali { get; set; }

        public List<SelectListItem> AllResheniq { get; set; }

        public List<SelectListItem> AllLica { get; set; }

    }
}
