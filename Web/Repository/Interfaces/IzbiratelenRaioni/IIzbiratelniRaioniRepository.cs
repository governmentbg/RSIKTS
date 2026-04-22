using DTO.IzbiratelniRaioni;
using System;
using System.Collections.Generic;
using System.Text;

namespace Repository.Interfaces.IzbiratelenRaioni
{
    public interface IIzbiratelniRaioniRepository
    {
        ICollection<IzbiratelenRaionDto> GetIzbiratelniRaioni();
    }
}
