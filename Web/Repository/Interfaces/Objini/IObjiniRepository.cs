namespace Repository.Interfaces.Objini
{
    using DTO.Objini;
    using System.Collections.Generic;

    public interface IObjiniRepository
    {
        ICollection<AllObjiniDto> GetAllObjini();

        AllObjiniDto GetObjina(string nkod);
    }
}
