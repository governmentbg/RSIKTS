namespace Repository.Interfaces.Partiq
{
    using DTO.Partiq;
    using System.Collections.Generic;

    public interface IPartiqRepository
    {
        ICollection<PartiqBasicDTO> GetAllParti();
    }
}
