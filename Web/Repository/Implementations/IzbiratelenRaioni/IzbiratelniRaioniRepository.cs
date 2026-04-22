using DataAccess;
using DTO.IzbiratelniRaioni;
using Repository.Interfaces.IzbiratelenRaioni;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Repository.Implementations.IzbiratelenRaioni
{
    public class IzbiratelniRaioniRepository : IIzbiratelniRaioniRepository
    {
        private readonly VotingRegisterContext _context;

        public IzbiratelniRaioniRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public ICollection<IzbiratelenRaionDto> GetIzbiratelniRaioni()
        {
            return _context.WnIzbRaion.Where(i => i.Status == 1).Select(i => new IzbiratelenRaionDto
            {
                Nime = i.Nime,
                Nkod = i.Nkod
            }).ToList();
        }
    }
}
