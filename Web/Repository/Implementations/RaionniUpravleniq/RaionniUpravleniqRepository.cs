namespace Repository.Implementations.RaionniUpravleniq
{
    using DataAccess;
    using DTO.RaionniUpravleniq;
    using Repository.Interfaces.RaionniUpravleniq;
    using System.Collections.Generic;
    using System.Linq;

    public class RaionniUpravleniqRepository : IRaionniUpravleniqRepository
    {
        private readonly VotingRegisterContext _context;

        public RaionniUpravleniqRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public ICollection<RaionoUpravlenieDto> GetAllRaionniUpravleniq()
        {
            return _context.Wnnru.Select(r => new RaionoUpravlenieDto
            {
                Nkod = r.Nkod,
                Nime = r.Nime
            }).ToList();
        }
    }
}
