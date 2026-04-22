namespace Services.Implementations.User
{
    using System.Collections.Generic;
    using System.Linq;
    using Common.ViewModels.User;
    using Microsoft.AspNetCore.Identity;
    using Repository.Interfaces.User;
    using Services.Interfaces.User;
    using DTO.User;
    using Common.ViewModels.Raion;

    public class UserServices : IUserServices
    {
        private readonly IUserRepository _usersRepository;

        public UserServices(IUserRepository userRepository)
        {
            _usersRepository = userRepository;
        }

        public ICollection<AllUsersViewModel> GetAllUsers()
        {
            return _usersRepository.GetAllUsers().Select(u => new AllUsersViewModel
            {
                Id = u.Id,
                Username = u.Username,
                Roles = u.Roles,
                IsDeleted = u.IsDeleted,
                Names = u.Names
            }).ToList();
        }

        public ICollection<IdentityError> TryRegisterUser(SSOUserRegisterViewModel userModel)
        {
            return _usersRepository.TryRegisterUser(userModel);
        }

        public SSOUserIdentity GetIdentityUserByEmail(string email)
        {
            return _usersRepository.GetIdentityUserByEmail(email);
        }

        public SSOUserIdentity GetIdentityUserById(string id)
        {
            return _usersRepository.GetIdentityUserById(id);
        }

        public SSOUserEditViewModel GetEditUserById(string id)
        {
            var user = _usersRepository.GetEditUserById(id);

            var userViewModel = new SSOUserEditViewModel
            {
                Id = user.Id,
                Email = user.Email,
                UserName = user.UserName,
                Names = user.Names,
                Role = user.Role,
                AdministrativenRaion = user.AdministrativenRaion,
                Partiq = user.Partiq,
                Obhvat = user.Obhvat,
                AllParti = user.AllParti,
                AllRaioni = user.AllRaioni,
                PhoneNumber = user.PhoneNumber,
                IsDeleted = user.IsDeleted,
            };

            return userViewModel;
        }

        public ICollection<IdentityError> TryEditUser(SSOUserEditViewModel userEditViewModel)
        {
            return _usersRepository.TryEditUser(new SSOUserEditDTO
            {
                Id = userEditViewModel.Id,
                Email = userEditViewModel.Email,
                Names = userEditViewModel.Names,
                UserName = userEditViewModel.UserName,
                Role = userEditViewModel.Role,
                Partiq = userEditViewModel.Partiq,
                Obhvat = userEditViewModel.Obhvat,
                AdministrativenRaion = userEditViewModel.AdministrativenRaion,
                Password = userEditViewModel.Password,
                PhoneNumber = userEditViewModel.PhoneNumber,
                IsDeleted = userEditViewModel.IsDeleted,
            });
        }

        public ICollection<AllUsersViewModel> GetUsersByPageAndRole(int page, string role, string username)
        {
            return _usersRepository.GetUsersByPageAndRole(page, role, username)
                    .Select(u => new AllUsersViewModel
                    {
                        Id = u.Id,
                        Username = u.Username,
                        Roles = u.Roles,
                        IsDeleted = u.IsDeleted,
                        Names = u.Names
                    }).ToList();
        }

        public int GetMaxUserPages(string userRoleFilter, string usernameFilter)
        {
            return _usersRepository.GetMaxUserPages(userRoleFilter, usernameFilter);
        }

        public UserWithRegionViewModel GetUserWithRegions(string userId)
        {
            return new UserWithRegionViewModel
            {
                allRaioni = _usersRepository.GetUserWithRegions(userId).allRaioni.Select(r => new RaionViewModel
                {
                    Id = r.Id,
                    Name = r.Name
                }).ToList()
            };
        }

        public RaionViewModel GetUserRegion(string userId)
        {
            var raionDto = _usersRepository.GetUserRegion(userId);

            return new RaionViewModel
            {
                Id = raionDto.Id,
                Name = raionDto.Name
            };
        }

        public void UpdateUserAdministrativenRaion(string userId, string administrativenRaion)
        {
            _usersRepository.UpdateUserAdministrativenRaion(userId, administrativenRaion);
        }
    }
}
