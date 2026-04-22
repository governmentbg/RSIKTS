namespace Common.ViewModels.User
{
    using Microsoft.AspNetCore.Mvc.Rendering;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public class SSOUserRegisterViewModel
    {

        public SSOUserRegisterViewModel()
        {
            AllParti = new List<SelectListItem>();
            AllRaioni = new List<SelectListItem>();
        }

        [Required(ErrorMessage = "Полето е задължително")]
        [EmailAddress]
        [Display(Name = "Поща")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Име, Презиме и Фамилия")]
        public string Names { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 6)]
        [Display(Name = "Потребител")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Парола")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Повтори парола")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Роля")]
        public int Role { get; set; }

        [Display(Name = "Партия")]
        public int Partiq { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Обхват")]
        public int Obhvat { get; set; }

        [Display(Name = "Административен район")]
        public string AdministrativenRaion { get; set; }

        public IEnumerable<SelectListItem> AllParti { get; set; }

        public IEnumerable<SelectListItem> AllRaioni { get; set; }

        [Display(Name = "Телефон")]
        public string PhoneNumber { get; set; }


    }
}
