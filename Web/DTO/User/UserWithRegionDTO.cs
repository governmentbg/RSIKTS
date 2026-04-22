namespace DTO.User
{
    using DTO.Raion;
    using System.Collections.Generic;

    public class UserWithRegionDTO
    {
        public UserWithRegionDTO()
        {
            allRaioni = new List<RaionDTO>();
        }

        public ICollection<RaionDTO> allRaioni;
    }
}
