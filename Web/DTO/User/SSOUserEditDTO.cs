using Microsoft.AspNetCore.Mvc.Rendering;

namespace DTO.User
{
    using System.Collections.Generic;
    public class SSOUserEditDTO
    {
        public SSOUserEditDTO()
        {
            AllParti = new List<SelectListItem>();
            AllRaioni = new List<SelectListItem>();
        }

        public string Id { get; set; }

        public string Email { get; set; }

        public string Names { get; set; }

        public string UserName { get; set; }

        public int Role { get; set; }

        public int? Partiq { get; set; }

        public int Obhvat { get; set; }

        public string Password { get; set; }

        public string AdministrativenRaion { get; set; }

        public IEnumerable<SelectListItem> AllParti { get; set; }

        public IEnumerable<SelectListItem> AllRaioni { get; set; }

        public string PhoneNumber { get; set; }
        public bool IsDeleted { get; set; }

    }
}
