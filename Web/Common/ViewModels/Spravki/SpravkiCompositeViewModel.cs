namespace Common.ViewModels.Spravki
{
    using System.Collections.Generic;
    using Common.ViewModels.Lica;

    public class SpravkiCompositeViewModel : LicaFilterViewModel
    {
        public int typestatistics { get; set; }

        public IzbRaionWithSikFilter IzbRaionFilter { get; set; }

        public PartiaFilterViewModel PartiaFilter { get; set; }

        public RoliSpravkaFilter RoliFilter { get; set; }

        public SikSpravkaFilter SlujebnaSpravka221FiletModel { get; set; }

        public List<StatisticViewModel> AllStatistics { get; set; }

        public SpravkaRziFilter RziFilter { get; set; }



    }
}
