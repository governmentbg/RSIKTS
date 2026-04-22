namespace Repository.Implementations.Partiq
{
    using System.Collections.Generic;
    using System.Linq;
    using DataAccess;
    using DTO.Partiq;
    using Repository.Interfaces.Partiq;

    public class PartiqRepository : IPartiqRepository
    {
        private readonly VotingRegisterContext _context;

        public PartiqRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public ICollection<PartiqBasicDTO> GetAllParti()
        {
            return _context.Wnsila.Where(n => n.StatusPartii == 1).Select(s => new PartiqBasicDTO
            {
                Id = s.IdParty,
                Code = s.Nkod,
                Name = s.Nime
            }).ToList();
        }
    }
}
