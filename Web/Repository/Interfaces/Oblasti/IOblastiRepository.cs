namespace Repository.Interfaces.Oblasti
{
    using DTO.Oblasti;
    using System.Collections.Generic;

    public interface IOblastiRepository
    {
        ICollection<AllOblastiDto> GetAllOblasti();

        AllOblastiDto GetOblast(string nkod);
    }
}
