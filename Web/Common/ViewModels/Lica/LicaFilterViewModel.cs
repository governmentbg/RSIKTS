using Common.Enums.Spravki;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Common.ViewModels.Lica
{
    public class LicaFilterViewModel
    {

        public LicaFilterViewModel()
        {
            AllTurs = new List<SelectListItem>{};
        }

        public Statistics StatisticId { get; set; }

        [Display(Name = "Филтър(ЕГН/Име)")]
        public string Egn { get; set; }

        [Display(Name = "Административен район")]
        public string AdministrativenRaion { get; set; }

        [Display(Name = "Секции")]
        //v.2 --public string Sekciq { get; set; }
        public List<string> Sekciq { get; set; }

        [Display(Name = "Роля")]
        public string Rolq { get; set; }

        [Display(Name = "Партия")]
        public string Partiq { get; set; }

        [Display(Name = "Решения")]
        public string Reshenie { get; set; }

        [Display(Name = "Дейност")]
        public string Deistvie { get; set; }

        [Display(Name = "Тур")]
        public int SelectedTurs { get; set; }

        [Display(Name = "Глобално търсене на лице (в цялата БД)")]
        public bool GlobalSearch { get; set; }

        public List<SelectListItem> AllTurs { get; set; }

        public List<SelectListItem> AllAdministrativniRaioni { get; set; }

        public List<SelectListItem> AllSekcii { get; set; }

        public List<SelectListItem> AllRoli { get; set; }

        public List<SelectListItem> AllPartii { get; set; }

        public List<SelectListItem> AllResheniq { get; set; }

        public List<SelectListItem> AllDeistviq { get; set; }
    }
}
