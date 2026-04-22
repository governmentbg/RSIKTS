namespace Repository.Implementations.NaseleniMesta
{
    using DataAccess;
    using DTO.NaseleniMesta;
    using Repository.Interfaces.NaseleniMesta;
    using System.Collections.Generic;
    using System.Linq;
    
    public class NaseleniMestaRepository : INaseleniMestaRepository
    {
        readonly private VotingRegisterContext _context;

        public NaseleniMestaRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public ICollection<AllNaseleniMestaDto> GetAllNaseleniMesta()
        {
            return _context.Wnasm.Select(n => new AllNaseleniMestaDto
            {
                Nkod = n.Nkod,
                Nime = n.Nime,
                Kmetstvo = n.Kmetstvo
            }).ToList();
        }
    }
}
