namespace Common.ViewModels.User
{
    using Common.ViewModels.Shared;
    using System.Collections.Generic;
    public class AllUsersComposite : PaginationViewModel
    {
        public AllUsersComposite()
        {
            AllUsers = new List<AllUsersViewModel>();
        }

        //[JsonProperty(PropertyName = "UserRoleFilter")]
        public string UserRoleFilter { get; set; }

        public string UsernameFilter { get; set; }

        public ICollection<AllUsersViewModel> AllUsers { get; set; }
    }
}
