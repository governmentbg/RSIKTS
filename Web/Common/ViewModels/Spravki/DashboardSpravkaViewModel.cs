using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Spravki
{
    public class DashboardSpravkaViewModel
    {
        public List<RazpredelenieViewModel> Razpredeleniq { get; set; }

        public List<SustoqnieNaRegistraciiteSpravkaViewModel> SustoqnieNaRegistraciite { get; set; }
    }
}
