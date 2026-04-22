namespace Services.Interfaces.Ulici
{
    using Common.ViewModels.Ulici;
    using System.Collections.Generic;

    public interface IUliciServices
    {
        ICollection<AllUliciViewModel> GetUliciByNaselenoMqsto(string naselenoMqstoId);
    }
}
