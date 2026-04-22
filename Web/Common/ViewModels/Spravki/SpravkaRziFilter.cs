namespace Common.ViewModels.Spravki
{
    using Microsoft.AspNetCore.Mvc.Rendering;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public class SpravkaRziFilter
    {

        [Display(Name = "Избирателен район")]
        public string IzbRaionNkod { get; set; }

        [Display(Name = "Дейност")]
        public int[] Deistvie { get; set; }

        public List<SelectListItem> AllIzbRaioni { get; set; }

        public List<SelectListItem> AllDeistviq { get; set; }
    }
}
