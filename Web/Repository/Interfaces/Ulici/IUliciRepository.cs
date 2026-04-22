namespace Repository.Interfaces.Ulici
{
    using DTO.Ulici;
    using System.Collections.Generic;

    public interface IUliciRepository
    {
        ICollection<AllUliciDto> GetAllUlici();

        ICollection<AllUliciDto> GetUliciByNaselenoMqsto(string naselenoMqstoId);
    }
}
