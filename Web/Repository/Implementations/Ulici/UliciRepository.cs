namespace Repository.Implementations.Ulici
{
    using System.Collections.Generic;
    using System.Linq;
    using DataAccess;
    using DTO.Ulici;
    using Repository.Interfaces.Ulici;

    public class UliciRepository : IUliciRepository
    {
        readonly private VotingRegisterContext _context;

        public UliciRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public ICollection<AllUliciDto> GetAllUlici()
        {
            return _context.Wnuli.Select(u => new AllUliciDto
            {
                Nrec = u.Nkod,
                Wnasm_Nkod = u.WnasmNkod,
                Nkod = u.Nkod,
                Nime = u.Nime
            }).OrderBy(x => x.Nime).ToList();
        }

        public ICollection<AllUliciDto> GetUliciByNaselenoMqsto(string naselenoMqstoId)
        {
            return _context.Wnuli.Where(u => u.WnasmNkod == naselenoMqstoId).Select(u => new AllUliciDto
            {
                Nrec = u.Nkod,
                Wnasm_Nkod = u.WnasmNkod,
                Nkod = u.Nkod,
                Nime = u.Nime
            }).OrderBy(x => x.Nime).ToList();
        }
    }

}
