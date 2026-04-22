namespace Repository.Implementations
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using Common.Enums;
    using Common.Enums.Obhvati;
    using Common.Enums.User;
    using Common.Static;
    using Common.ViewModels.User;
    using DataAccess;
    using DTO.User;
    using Microsoft.AspNetCore.Identity;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.EntityFrameworkCore;
    using Repository.Interfaces.Partiq;
    using Repository.Interfaces.Raion;
    using Repository.Interfaces.User;
    using DTO.Raion;

    public class UserRepository : IUserRepository
    {
        private readonly IPartiqRepository _partiqRepository;
        private readonly IRaionRepository _raionRepository;
        private readonly UserManager<SSOUserIdentity> _userManager;
        private readonly VotingRegisterContext _context;

        public UserRepository(IPartiqRepository partiqRepository, IRaionRepository raionRepository, VotingRegisterContext context, UserManager<SSOUserIdentity> userManager)
        {
            _partiqRepository = partiqRepository;
            _raionRepository = raionRepository;
            _context = context;
            _userManager = userManager;
        }

        public ICollection<AllUsersDTO> GetAllUsers()
        {
            return _context.Aspnetusers.Select(e => new AllUsersDTO
            {
                Id = e.Id,
                Username = e.UserName,
                Roles = e.Aspnetuserroles.Select(r => r.Role.Name).ToList(),
                IsDeleted = e.IsDeleted,
                Names = e.Names
            }).OrderBy(s => s.Username).ToList();
        }

        public ICollection<IdentityError> TryRegisterUser(SSOUserRegisterViewModel userModel)
        {

            var newUser = new SSOUserIdentity
            {
                Email = userModel.Email,
                UserName = userModel.UserName,
                Ot_Partiq = userModel.Role == (int)Roles.Partiq ? userModel.Partiq : (int?)null,
                Administrative_Rajon = userModel.Obhvat == (int)Obhvati.ForRegion ? userModel.AdministrativenRaion : null,
                Names = userModel.Names,
                PhoneNumber = userModel.PhoneNumber,
                IsDeleted = false
            };

            var userCreateResult = _userManager.CreateAsync(newUser, userModel.Password).Result;

            if (userCreateResult.Succeeded)
            {
                if (newUser.Administrative_Rajon == null)
                {
                    _context.SysUsermain.Add(new SysUsermain
                    {
                        Id = _context.SysUsermain.LastOrDefault() == null ? 1 : _context.SysUsermain.Last().Id + 1,
                        User = newUser.Id,
                        Name = "TOA",
                        Value = _context.Wntoa.First().Nkod
                    });

                    _context.SaveChanges();
                }

                var addUserToRole = _userManager.AddToRoleAsync(newUser, ((Roles)userModel.Role).GetDescription()).Result;

                if (addUserToRole.Succeeded)
                {
                    _context.SaveChanges();
                    return new List<IdentityError>();
                }

                return addUserToRole.Errors.ToList();
            }

            return userCreateResult.Errors.ToList();
        }

        public SSOUserIdentity GetIdentityUserByEmail(string email)
        {
            return _context.SSOUserIdentities.FirstOrDefault(u => u.Email == email);
        }

        public SSOUserIdentity GetIdentityUserById(string id)
        {
            return _context.SSOUserIdentities.FirstOrDefault(u => u.Id == id) ?? new SSOUserIdentity { UserName = "Unknown"};
        }

        public SSOUserEditDTO GetEditUserById(string id)
        {
            var user = _context.Aspnetusers.Include(u => u.Aspnetuserroles).ThenInclude(r => r.Role).FirstOrDefault(u => u.Id == id);

            if(user == null)
            {
                return new SSOUserEditDTO()
                {
                    UserName = "Unkown"
                };
            }

            var userViewModel = new SSOUserEditDTO
            {
                Id = user.Id,
                Email = user.Email,
                UserName = user.UserName,
                Names = user.Names,
                Role = (int)(user.Aspnetuserroles.FirstOrDefault().Role.Name.GetValueFromDescription<Roles>()),
                AdministrativenRaion = user.AdministrativeRajon,
                Partiq = user.OtPartiq,
                Obhvat = user.AdministrativeRajon == null ? 0 : 1,
                PhoneNumber = user.PhoneNumber,
                AllParti = _partiqRepository.GetAllParti().Select(p => new SelectListItem
                {
                    Value = p.Id.ToString(),
                    Text = p.Name
                }).ToList(),
                AllRaioni = _raionRepository.GetAllRaioni(null).Select(r => new SelectListItem
                {
                    Value = r.Id.ToString(),
                    Text = r.Name
                }).ToList(),
                IsDeleted = user.IsDeleted,
            };

            return userViewModel;
        }

        public ICollection<IdentityError> TryEditUser(SSOUserEditDTO userEditDTO)
        {
            //var userIdentity = _context.SSOUserIdentity.FirstOrDefault(u => u.Id == userEditDTO.Id);
            var user = _context.Aspnetusers.Include(u => u.Aspnetuserroles).ThenInclude(r => r.Role).FirstOrDefault(u => u.Id == userEditDTO.Id);
            var userIdentity = _userManager.FindByIdAsync(userEditDTO.Id).Result;

            if (!_context.SSOUserIdentities.Any(u => (u.Email == userEditDTO.Email && u.Id != userEditDTO.Id) || (u.UserName == userEditDTO.UserName && u.Id != userEditDTO.Id)))
            {
                if (userIdentity.Administrative_Rajon != null && userEditDTO.Obhvat != (int)Obhvati.ForRegion)
                {
                    _context.SysUsermain.Add(new SysUsermain
                    {
                        Id = _context.SysUsermain.LastOrDefault() == null ? 1 : _context.SysUsermain.Last().Id + 1,
                        User = userIdentity.Id,
                        Name = "TOA",
                        Value = _context.Wntoa.First().Nkod
                    });

                    _context.SaveChanges();
                }
                else if(userIdentity.Administrative_Rajon == null && userEditDTO.Obhvat == (int)Obhvati.ForRegion)
                {
                    var userToa = _context.SysUsermain.FirstOrDefault(s => s.User == userIdentity.Id && s.Name == "TOA");
                    _context.SysUsermain.Remove(userToa);
                    _context.SaveChanges();
                }

                userIdentity.Email = userEditDTO.Email;
                userIdentity.UserName = userEditDTO.UserName;
                userIdentity.Names = userEditDTO.Names;
                userIdentity.Ot_Partiq = userEditDTO.Role == (int)Roles.Partiq ? userEditDTO.Partiq : (int?)null;
                userIdentity.Administrative_Rajon = userEditDTO.Obhvat == (int)Obhvati.ForRegion ? userEditDTO.AdministrativenRaion : null;
                userIdentity.PhoneNumber = userEditDTO.PhoneNumber;
                userIdentity.IsDeleted = userEditDTO.IsDeleted;

                var removeUserFromRoleResult = _userManager.RemoveFromRoleAsync(userIdentity, user.Aspnetuserroles.FirstOrDefault().Role.Name).Result;
                var addUserToRoleResult = _userManager.AddToRoleAsync(userIdentity, ((Roles)userEditDTO.Role).GetDescription()).Result;

                var passwordChangeResult = new IdentityResult();

                if (userEditDTO.Password != null)
                {
                    string resetToken = _userManager.GeneratePasswordResetTokenAsync(userIdentity).Result;
                    passwordChangeResult = _userManager.ResetPasswordAsync(userIdentity, resetToken, userEditDTO.Password).Result;
                }

                var updateUserResult = _userManager.UpdateAsync(userIdentity).Result;

                var errors = new List<IdentityError>(
                    removeUserFromRoleResult.Errors
                    .Concat(addUserToRoleResult.Errors)
                    .Concat(updateUserResult.Errors)
                    .Concat(passwordChangeResult.Errors)
                );

                if(errors.Count == 0)
                {
                    _context.SaveChanges();
                }

                return errors;
            }

            return new List<IdentityError>
            {
                new IdentityError()
                {
                    Description = "Non unique username or email"
                }
            };
        }

        public ICollection<AllUsersDTO> GetUsersByPageAndRole(int page, string role, string username)
        {
            page = page - 1;

            if(role == null && username == null)
            {
                return _context.Aspnetusers
                    .Select(e => new AllUsersDTO
                    {
                        Id = e.Id,
                        Username = e.UserName,
                        Roles = e.Aspnetuserroles.Select(r => r.Role.Name).ToList(),
                        IsDeleted = e.IsDeleted,
                        Names = e.Names
                    })
                    .OrderBy(s => s.Username)
                    .Skip(page * PaginationInfo.PageSize)
                    .Take(PaginationInfo.PageSize).ToList();
            }
            else if(role != null && username == null)
            {
                return _context.Aspnetusers
                    .Where(e => e.Aspnetuserroles.FirstOrDefault().Role.Name == role)
                    .Select(e => new AllUsersDTO
                    {
                        Id = e.Id,
                        Username = e.UserName,
                        Roles = e.Aspnetuserroles.Select(r => r.Role.Name).ToList(),
                        IsDeleted = e.IsDeleted,
                        Names = e.Names
                    })
                    .OrderBy(s => s.Username)
                    .Skip(page * PaginationInfo.PageSize)
                    .Take(PaginationInfo.PageSize).ToList();
            }
            else if(role == null && username != null)
            {
                return _context.Aspnetusers
                    .Where(e => e.UserName.Contains(username))
                    .Select(e => new AllUsersDTO
                    {
                        Id = e.Id,
                        Username = e.UserName,
                        Roles = e.Aspnetuserroles.Select(r => r.Role.Name).ToList(),
                        IsDeleted = e.IsDeleted,
                        Names = e.Names
                    })
                    .OrderBy(s => s.Username)
                    .Skip(page * PaginationInfo.PageSize)
                    .Take(PaginationInfo.PageSize).ToList();
            }
            else
            {
                return _context.Aspnetusers
                    .Where(e => e.UserName.Contains(username) && e.Aspnetuserroles.FirstOrDefault().Role.Name == role)
                    .Select(e => new AllUsersDTO
                    {
                        Id = e.Id,
                        Username = e.UserName,
                        Roles = e.Aspnetuserroles.Select(r => r.Role.Name).ToList(),
                        IsDeleted = e.IsDeleted,
                        Names = e.Names
                    })
                    .OrderBy(s => s.Username)
                    .Skip(page * PaginationInfo.PageSize)
                    .Take(PaginationInfo.PageSize).ToList();
            }
            
        }

        public int GetMaxUserPages(string userRoleFilter, string usernameFilter)
        {
            if(userRoleFilter == null && usernameFilter == null)
            {
                return (int)Math.Ceiling(Convert.ToDouble(_context.Aspnetusers.Count()) / PaginationInfo.PageSize);
            }
            else if(userRoleFilter != null && usernameFilter == null)
            {
                return (int)Math.Ceiling(Convert.ToDouble(_context.Aspnetusers
                    .Where(u => u.Aspnetuserroles.FirstOrDefault().Role.Name == userRoleFilter).Count()) / PaginationInfo.PageSize);
            }
            else if(userRoleFilter == null && usernameFilter != null)
            {
                return (int)Math.Ceiling(Convert.ToDouble(_context.Aspnetusers
                    .Where(u => u.UserName.Contains(usernameFilter)).Count()) / PaginationInfo.PageSize);
            }
            else
            {
                return (int)Math.Ceiling(Convert.ToDouble(_context.Aspnetusers
                    .Where(u => u.Aspnetuserroles.FirstOrDefault().Role.Name == userRoleFilter && u.UserName.Contains(usernameFilter)).Count()) / PaginationInfo.PageSize);
            }
            
        }

        public UserWithRegionDTO GetUserWithRegions(string userId)
        {
            var userRaion = GetUserRegion(userId);

            return new UserWithRegionDTO
            {
                allRaioni = new List<RaionDTO>() { new RaionDTO {
                    Id = userRaion.Id,
                    Name = userRaion.Name
                }}
            };
        }

        public RaionDTO GetUserRegion(string userId)
        {
            
            var userToa = _context.SysUsermain.FirstOrDefault(s => s.User == userId && s.Name == "TOA");

            if (userToa != null)
            {
                var regionEntityFromSysMain = _context.Wntoa.FirstOrDefault(t => t.Nkod == userToa.Value);

                return new RaionDTO
                {
                    Id = regionEntityFromSysMain.Nkod,
                    Name = regionEntityFromSysMain.Nime
                };
            }

            var regionEntity = _context.Wntoa.FirstOrDefault(t => t.Nkod == "01");
            var user = GetIdentityUserById(userId);

            if(user == null)
            {
                return new RaionDTO
                {
                    Id = "0",
                    Name = "Undefined"
                };
            }

            if (user.Administrative_Rajon != null) { 
                regionEntity = _context.Wntoa.FirstOrDefault(t => t.Nkod == user.Administrative_Rajon);
            } 

            return new RaionDTO
            {
                Id = regionEntity.Nkod,
                Name = regionEntity.Nime
            };
        }

        public void UpdateUserAdministrativenRaion(string userId, string administrativenRaion)
        {
            var userToa = _context.SysUsermain.FirstOrDefault(s => s.User == userId && s.Name == "TOA");
            userToa.Value = administrativenRaion;
            _context.SaveChanges();
        }
    }
}
