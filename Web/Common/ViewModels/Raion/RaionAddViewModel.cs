namespace Common.ViewModels.Raion
{
    using Microsoft.AspNetCore.Mvc.Rendering;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public class RaionAddViewModel
    {
        public int Nrec { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Пощенски код")]      
        public string ZipCode { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Номер")]
        public string Nomer { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Блок")]
        public string Blok { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Вход")]
        public string Vhod { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Етаж")]
        public string Etaj { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Апартамент")]
        public string Apartament { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Телефон")]
        public string Telephone { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Брой секции")]
        public int BroiSekcii { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Представка")]
        public string Predstavka { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Председател на РИК")]
        public string Precedatel { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Име на изборите")]
        public string ImeNaIzborite { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Брой членове в секция за района")]
        public int MaxBroiChlenove   { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Кмет на район")]
        public string KmetNaRaion { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Кмет на район")]
        public string KmetNaRaion2 { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Секретар на РИК")]
        public string Sekretar { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [MinLength(9, ErrorMessage = "Полето съдържа невалиден брой символи")]
        [MaxLength(13, ErrorMessage = "Полето съдържа невалиден брой символи")]
        [RegularExpression("^[0-9]*$", ErrorMessage = "Полето съдържа невалидни символи")]

        [Display(Name = "БУЛСТАТ")]
        public string Bulstat { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Изборен район")]
        public string RikOrSik { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name="Област")]
        public string Oblast { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Община")]
        public string Objina { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Административен район")]
        public string AdministrativenRaion { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Населено място")]
        public string NaselenoMqsto{ get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Улица")]
        public string Ulica { get; set; }

        //[Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Квартал")]
        public string Kvartal { get; set; }

        public List<SelectListItem> AllOblasti { get; set; }

        public List<SelectListItem> AllObjini { get; set; }

        public List<SelectListItem> AllAdministrativniRaioni { get; set; }

        public List<SelectListItem> AllNaseleniMesta { get; set; }

        public List<SelectListItem> AllUlici { get; set; }

        public List<SelectListItem> AllKvartali { get; set; }
    }
}
