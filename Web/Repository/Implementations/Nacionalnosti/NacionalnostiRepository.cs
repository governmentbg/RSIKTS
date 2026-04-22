namespace Repository.Implementations.Nacionalnosti
{
    using DataAccess;
    using DTO.Nacionalnosti;
    using Repository.Interfaces.Nacionalnosti;
    using System.Collections.Generic;
    using System.Linq;

    public class NacionalnostiRepository : INacionalnostiRepository
    {
        private readonly VotingRegisterContext _context;

        public NacionalnostiRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public ICollection<NacioanlnostDto> GetAllNactionalnosti()
        {
            var bulgariaNacionalost = _context.Wnnaz.FirstOrDefault(w => w.Nime == "БЪЛГАРИЯ");

            var nacionalnosti = _context.Wnnaz.Select(n => new NacioanlnostDto
            {
                Nkod = n.Nkod,
                Nime = n.Nime
            }).Where(w => w.Nime != "БЪЛГАРИЯ").ToList();

            nacionalnosti.Insert(0, new NacioanlnostDto
            {
                Nkod = bulgariaNacionalost.Nkod,
                Nime = bulgariaNacionalost.Nime
            });

            return nacionalnosti;
        }
    }
}
