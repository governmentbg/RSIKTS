namespace Repository.Implementations.Objini
{
    using DataAccess;
    using DTO.Objini;
    using Repository.Interfaces.Objini;
    using System.Collections.Generic;
    using System.Linq;

    public class ObjiniRepository : IObjiniRepository
    {
        readonly private VotingRegisterContext _context;

        public ObjiniRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public ICollection<AllObjiniDto> GetAllObjini()
        {
            return _context.Wnobs.Select(o => new AllObjiniDto
            {
                Nkod = o.Nkod,
                Nime = o.Nime,
                Ekatte = o.Ekatte
            }).ToList();
        }

        public AllObjiniDto GetObjina(string Nkod)
        {
            var objina = _context.Wnobs.FirstOrDefault(w => w.Nkod == Nkod);

            return new AllObjiniDto
            {
                Nkod = objina.Nkod,
                Nime = objina.Nime,
                Ekatte = objina.Ekatte
            };
        }
    }
}
