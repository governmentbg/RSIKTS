namespace Repository.Interfaces.Nacionalnosti
{
    using DTO.Nacionalnosti;
    using System.Collections.Generic;

    public interface INacionalnostiRepository
    {
        ICollection<NacioanlnostDto> GetAllNactionalnosti();
    }
}
