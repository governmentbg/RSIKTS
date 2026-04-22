namespace Repository.Interfaces.RaionniUpravleniq
{
    using DTO.RaionniUpravleniq;
    using System.Collections.Generic;

    public interface IRaionniUpravleniqRepository
    {
        ICollection<RaionoUpravlenieDto> GetAllRaionniUpravleniq();
    }
}
