
namespace Common.ViewModels.Parameters
{
    using Microsoft.AspNetCore.Mvc.Rendering;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Text;

    public class NomenclaturesViewModel
    {

        public NomenclaturesViewModel()
        {
            TipNomenclatures = new List<SelectListItem>
            {
                new SelectListItem
                {
                    Value = "0",
                    Text = "Глобална номенклатура"
                },
                new SelectListItem
                {
                    Value = "1",
                    Text = "Локална номенклатура",
                    Selected = true
                },
            };
        }

        public List<SelectListItem> TipNomenclatures { get; set; }

        [Required]
        public int Id { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Наименование")]
        public string Description { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Тип номенклатура")]
        public int Tip { get; set; }

        [Required(ErrorMessage = "Полето е задължително")]
        [Display(Name = "Активна")]
        public bool Status { get; set; }
    }
}
