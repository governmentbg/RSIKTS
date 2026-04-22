namespace Repository.Interfaces.User
{
    using Common.ViewModels.User;
    using DTO.Raion;
    using DTO.User;
    using Microsoft.AspNetCore.Identity;
    using System.Collections.Generic;


    public interface IUserRepository
    {
        ICollection<AllUsersDTO> GetAllUsers();

        ICollection<IdentityError> TryRegisterUser(SSOUserRegisterViewModel userModel);

        SSOUserIdentity GetIdentityUserByEmail(string email);

        SSOUserEditDTO GetEditUserById(string id);

        ICollection<IdentityError> TryEditUser(SSOUserEditDTO userEditDTO);

        ICollection<AllUsersDTO> GetUsersByPageAndRole(int page, string role, string username);

        int GetMaxUserPages(string userRoleFilter, string usernameFilter);

        UserWithRegionDTO GetUserWithRegions(string userId);

        SSOUserIdentity GetIdentityUserById(string id);

        RaionDTO GetUserRegion(string userId);
        void UpdateUserAdministrativenRaion(string userId, string administrativenRaion);
    }
}
