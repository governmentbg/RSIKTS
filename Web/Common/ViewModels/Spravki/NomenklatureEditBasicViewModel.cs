namespace Common.ViewModels.Spravki
{
    using Common.Enums.Spravki;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    public class NomenklatureEditBasicViewModel
    {
        public NomenklatureIds NomenklatureId { get; set; }

        [Display(Name = "Код")]
        [RequiredIfNot("NomenklatureId", new int[] {(int)NomenklatureIds.Dokumenti, (int)NomenklatureIds.Dokumenti } ,ErrorMessage = "Полето е задължително")]
        public string Nkod { get; set; }

        [Display(Name = "Наименование")]
        [Required(ErrorMessage = "Полето е задължително")]
        public string Nime { get; set; }
    }
}
