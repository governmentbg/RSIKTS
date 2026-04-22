namespace Services.Interfaces.User
{
    using Common.ViewModels.Raion;
    using Common.ViewModels.User;
    using Microsoft.AspNetCore.Identity;
    using System;
    using System.Collections.Generic;
    using System.Security.Claims;

    public interface IUserServices
    {
        ICollection<AllUsersViewModel> GetAllUsers();

        ICollection<IdentityError> TryRegisterUser(SSOUserRegisterViewModel userModel);

        SSOUserIdentity GetIdentityUserByEmail(string email);

        SSOUserIdentity GetIdentityUserById(string id);

        SSOUserEditViewModel GetEditUserById(string id);

        ICollection<IdentityError> TryEditUser(SSOUserEditViewModel userEditDTO);

        ICollection<AllUsersViewModel> GetUsersByPageAndRole(int page, string role, string username);

        int GetMaxUserPages(string userRoleFilter, string usernameFilter);

        UserWithRegionViewModel GetUserWithRegions(string userId);

        RaionViewModel GetUserRegion(string userId);
        void UpdateUserAdministrativenRaion(string userId, string administrativenRaion);
    }
}
