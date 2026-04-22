namespace DTO.User
{
    using System.Collections.Generic;

    public class AllUsersDTO
    {
        public string Id { get; set; }
        public string Names { get; set; }

        public string Username { get; set; }
        public bool IsDeleted { get; set; }

        public ICollection<string> Roles { get; set; }
    }
}
