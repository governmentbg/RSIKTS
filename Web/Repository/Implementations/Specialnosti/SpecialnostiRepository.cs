using DataAccess;
using DTO.Specialnosti;
using Repository.Interfaces.Specialnosti;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Repository.Implementations.Specialnosti
{
    public class SpecialnostiRepository : ISpecialnostiRepository
    {
        private readonly VotingRegisterContext _context;

        public SpecialnostiRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public ICollection<SpecialnostDto> GetAllSpecialnosti()
        {
            return _context.Wnspec.Select(s => new SpecialnostDto
            {
                Nkod = s.Nkod,
                Nime = s.Nime
            }).ToList();
        }
    }
}
