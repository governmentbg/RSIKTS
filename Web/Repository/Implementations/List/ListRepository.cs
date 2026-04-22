namespace Repository.Implementations.List
{
    using DataAccess;
    using DTO;
    using Repository.Interfaces.List;
    using System.Collections.Generic;
    using System.Linq;

    public class ListRepository : IListRepository
    {
        readonly private VotingRegisterContext _context;

        public ListRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public ICollection<ListCodePositionDto> GetCodePositions(int pKode)
        {
            return _context.NListCodepositions.Where(c => c.Pkode == pKode && c.Status==1).Select(c => new ListCodePositionDto
            {
                Id = c.Id,
                Pkode = c.Pkode,
                Nkode = c.Nkode,
                Nime = c.Nime
            }).OrderBy(c=>c.Nkode)
              .ToList();
        }
    }
}
