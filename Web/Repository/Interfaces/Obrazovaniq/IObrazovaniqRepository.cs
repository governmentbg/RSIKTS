namespace Repository.Interfaces.Obrazovaniq
{
    using DTO.Obrazovanie;
    using System.Collections.Generic;

    public interface IObrazovaniqRepository
    {
        ICollection<ObrazovanieDto> GetAllObrazovaniq();
    }
}
