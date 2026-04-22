using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Common.ViewModels.Spravki
{
    public class IzbRaionWithSikFilter : SikSpravkaFilter
    {
        public IzbRaionWithSikFilter ()
        {
            DateOt = new DateTime(2020, 1, 1);
            DateDo = DateTime.Now;
        }

        [Display(Name = "Избирателен район")]
        public string IzbRaionNkod {get;set;}

        public List<SelectListItem> AllIzbRaioni { get; set; }

        [Display(Name = "Административен район")]
        public string AdministrativenRaion { get; set; }

        [Display(Name = "от дата")]
        public DateTime DateOt { get; set; }

        [Display(Name = "до дата")]
        public DateTime DateDo { get; set; }

        public List<SelectListItem> AllAdministrativniRaioni { get; set; }

        //v.2
        [Display(Name = "Граници")]
        public string Granici { get; set; }

    }
}
