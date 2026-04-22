namespace Repository.Interfaces.Kvartali
{
    using DTO.Kvartali;
    using System.Collections.Generic;

    public interface IKvartaliRepository
    {
        ICollection<AllKvartaliDto> GetAllKvartali();
    }
}
