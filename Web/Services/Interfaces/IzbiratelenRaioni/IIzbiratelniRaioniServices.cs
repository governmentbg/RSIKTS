using Common.ViewModels.IzbiratelniRaioni;
using System;
using System.Collections.Generic;
using System.Text;

namespace Services.Interfaces.IzbiratelenRaioni
{
    public interface IIzbiratelniRaioniServices
    {
        ICollection<IzbiratelenRaionViewModel> GetIzbiratelniRaioni();
    }
}
