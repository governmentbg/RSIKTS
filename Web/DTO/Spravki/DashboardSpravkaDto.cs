using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.Spravki
{
    public class DashboardSpravkaDto
    {
        public List<RazpredelenieDto> Razpredeleniq { get; set; }

        public List<SustoqnieNaRegistraciiteSpravkaDto> SustoqnieNaRegistraciite { get; set; }
    }
}
