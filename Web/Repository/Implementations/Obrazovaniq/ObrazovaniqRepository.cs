using DataAccess;
using DTO.Obrazovanie;
using Repository.Interfaces.Obrazovaniq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Repository.Implementations.Obrazovaniq
{
    public class ObrazovaniqRepository : IObrazovaniqRepository
    {
        private readonly VotingRegisterContext _context;

        public ObrazovaniqRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public ICollection<ObrazovanieDto> GetAllObrazovaniq()
        {
            return _context.Wnszem.Select(o => new ObrazovanieDto
            {
                Nkod = o.Nkod,
                Nime = o.Nime
            }).ToList();
        }
    }
}
