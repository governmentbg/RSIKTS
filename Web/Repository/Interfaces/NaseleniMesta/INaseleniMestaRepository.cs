namespace Repository.Interfaces.NaseleniMesta
{
    using DTO.NaseleniMesta;
    using System.Collections.Generic;

    public interface INaseleniMestaRepository
    {
        ICollection<AllNaseleniMestaDto> GetAllNaseleniMesta();

    }
}
