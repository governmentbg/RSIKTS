namespace Services.Implementations.Ulici
{
    using System.Collections.Generic;
    using System.Linq;
    using Common.ViewModels.Ulici;
    using Repository.Interfaces.Ulici;
    using Services.Interfaces.Ulici;

    public class UliciServices : IUliciServices
    {
        readonly private IUliciRepository _uliciRepository;

        public UliciServices(IUliciRepository uliciRepository)
        {
            _uliciRepository = uliciRepository;
        }

        public ICollection<AllUliciViewModel> GetUliciByNaselenoMqsto(string naselenoMqstoId)
        {
            return _uliciRepository.GetUliciByNaselenoMqsto(naselenoMqstoId).Select(u => new AllUliciViewModel
            {
                Nrec = u.Nrec,
                Wnasm_Nkod = u.Wnasm_Nkod,
                Nime = u.Nime,
                Nkod = u.Nkod
            }).ToList();
        }
    }
}
