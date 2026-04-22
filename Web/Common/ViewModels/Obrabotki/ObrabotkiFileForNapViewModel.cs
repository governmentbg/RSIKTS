using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Common.ViewModels.Spravki;

namespace Common.ViewModels.Obrabotki
{ 

    public class ObrabotkiFileForNapViewModel : SikSpravkaFilter
    {
        public ObrabotkiFileForNapViewModel()
        {
            AllTurs = new List<SelectListItem>
            {
                new SelectListItem
                {
                    Value = "1",
                    Text = "Първи",
                    Selected = true
                },

                new SelectListItem
                {
                    Value = "2",
                    Text = "Втори"
                }
            };
        }

        [Display(Name = "Тур")]
        public int SelectedTurs { get; set; }

        public List<SelectListItem> AllTurs { get; set; }
        public SikSpravkaFilter SikFilterModel { get; set; }

        public int NapFileOption { get; set; }
    }
}
