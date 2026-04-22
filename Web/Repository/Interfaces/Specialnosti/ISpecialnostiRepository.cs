namespace Repository.Interfaces.Specialnosti
{
    using DTO.Specialnosti;
    using System.Collections.Generic;

    public interface ISpecialnostiRepository
    {
        ICollection<SpecialnostDto> GetAllSpecialnosti();
    }
}
