using Common.ViewModels.IzbiratelniRaioni;
using Repository.Interfaces.IzbiratelenRaioni;
using Services.Interfaces.IzbiratelenRaioni;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Services.Implementations.IzbiratelenRaioni
{
    public class IzbiratelniRaioniServices : IIzbiratelniRaioniServices
    {
        private readonly IIzbiratelniRaioniRepository _izbiratelniRaioniRepository;

        public IzbiratelniRaioniServices(IIzbiratelniRaioniRepository izbiratelniRaioniRepository)
        {
            _izbiratelniRaioniRepository = izbiratelniRaioniRepository;
        }

        public ICollection<IzbiratelenRaionViewModel> GetIzbiratelniRaioni()
        {
            return _izbiratelniRaioniRepository.GetIzbiratelniRaioni().Select(i => new IzbiratelenRaionViewModel
            {
                Nime = i.Nime,
                Nkod = i.Nkod
            }).ToList();
        }
    }
}
