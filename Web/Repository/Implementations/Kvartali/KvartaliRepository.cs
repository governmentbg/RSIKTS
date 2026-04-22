namespace Repository.Implementations.Kvartali
{
    using DataAccess;
    using DTO.Kvartali;
    using Repository.Interfaces.Kvartali;
    using System.Collections.Generic;
    using System.Linq;

    public class KvartaliRepository : IKvartaliRepository
    {
        readonly private VotingRegisterContext _context;

        public KvartaliRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public ICollection<AllKvartaliDto> GetAllKvartali()
        {
            return _context.WnjkKv.Select(k => new AllKvartaliDto
            {
                Nkod = k.Nkod,
                Nime = k.Nime
            }).OrderBy(x=>x.Nime).ToList();
        }
    }
}
