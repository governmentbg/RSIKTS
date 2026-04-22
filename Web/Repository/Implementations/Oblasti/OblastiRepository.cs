using DataAccess;
using DTO.Oblasti;
using Repository.Interfaces.Oblasti;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Repository.Implementations.Oblasti
{
    public class OblastiRepository : IOblastiRepository
    {
        readonly private VotingRegisterContext _context;

        public OblastiRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public ICollection<AllOblastiDto> GetAllOblasti()
        {
            return _context.Wnobl.Select(o => new AllOblastiDto
            {
                Nkod = o.Nkod,
                Nime = o.Nime
            }).ToList();
        }

        public AllOblastiDto GetOblast(string Nkod)
        {
            var oblast = _context.Wnobl.FirstOrDefault(n => n.Nkod == Nkod);

            return new AllOblastiDto
            {
                Nkod = oblast.Nkod,
                Nime = oblast.Nime
            };
        }
    }
}
