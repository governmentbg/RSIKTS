namespace Web.Areas.Admin.Controllers
{
    using Common.ViewModels.User;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;
    using Services.Interfaces.User;
    using Common.Extensions;
    using Microsoft.AspNetCore.Identity;
    using Services.Interfaces.Izbori;
    using System.Linq;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Common.ViewModels.Obrabotki;

    [Area("Admin")]
    [Authorize(Roles = "Администратор")]

    public class HomeController : Controller
    {
        private readonly IUserServices _userServices;
        private readonly IIzboriServices _izboriServices;
        private readonly UserManager<SSOUserIdentity> _userManager;

        public HomeController(IUserServices userServices, IIzboriServices izboriServices, UserManager<SSOUserIdentity> userManager)
        {
            _izboriServices = izboriServices;
            _userServices = userServices;
            _userManager = userManager;
        }

        [Authorize(Roles = "Администратор")]
        public IActionResult IndexAdditionalSets()
        {
            return View("IndexAdditionalSets");
        }

        [Authorize(Roles = "Администратор")]
        public IActionResult Index()
        {
            var compositeModel = new AllUsersComposite
            {
                CurrentPage = 1,
                UserRoleFilter = null,
                MaxPages = _userServices.GetMaxUserPages(null, null)
            };

            compositeModel.AllUsers = _userServices.GetUsersByPageAndRole(compositeModel.CurrentPage, compositeModel.UserRoleFilter, compositeModel.UsernameFilter);
            compositeModel.MaxPages = _userServices.GetMaxUserPages(compositeModel.UserRoleFilter, compositeModel.UsernameFilter);

            return View(compositeModel);
        }

        [Authorize(Roles = "Администратор")]
        public JsonResult EditUser(string id)
        {

            var user = _userServices.GetEditUserById(id);

            var userEditAsHtmlString = this.RenderViewAsync("Edit", user, true).Result;

            return Json(new
            {
                UserEditHtml = userEditAsHtmlString
            });
        }

        [Authorize(Roles = "Администратор")]
        [HttpPost]
        public IActionResult EditUser(SSOUserEditViewModel userEditViewModel)
        {
            var originalUserViewModel = _userServices.GetEditUserById(userEditViewModel.Id);
            var resultOfEdit = _userServices.TryEditUser(userEditViewModel);

            if(resultOfEdit.Count == 0)
            {
                var compositeModel = new AllUsersComposite
                {
                    CurrentPage = 1,
                    UserRoleFilter = null,
                    MaxPages = _userServices.GetMaxUserPages(null, null)
                };

                compositeModel.AllUsers = _userServices.GetUsersByPageAndRole(compositeModel.CurrentPage, compositeModel.UserRoleFilter, compositeModel.UsernameFilter);
                compositeModel.MaxPages = _userServices.GetMaxUserPages(compositeModel.UserRoleFilter, compositeModel.UsernameFilter);

                return View("Index", compositeModel);
            }

            foreach (var error in resultOfEdit)
            {
                ModelState.AddModelError(string.Empty, error.Description);
            }

            return View("Edit", originalUserViewModel);
        }

        [Authorize(Roles = "Администратор")]
        public void DeleteUser(string userId)
        {
            var deletedUserStatus = _userManager.DeleteAsync(_userServices.GetIdentityUserById(userId)).Result;
        }

        public IActionResult Menu()
        {
            var izboriTipove = _izboriServices.GetTipIzbori().Select(i => new SelectListItem
            {
                Value = i.Nkod,
                Text = i.Nime
            }).ToList();

            var model = new AdminOptionsFilter
            {
                AllTipove = izboriTipove
            };

            return View("Menu", model);
        }

        [Authorize(Roles = "Администратор")]
        public JsonResult GetUsersByPageAndRole(AllUsersComposite paginationModel) 
        {
            paginationModel.MaxPages = _userServices.GetMaxUserPages(paginationModel.UserRoleFilter, paginationModel.UsernameFilter);

            if(paginationModel.MaxPages < paginationModel.CurrentPage)
            {
                paginationModel.CurrentPage = 1;
            }

            paginationModel.AllUsers = _userServices.GetUsersByPageAndRole(paginationModel.CurrentPage, paginationModel.UserRoleFilter, paginationModel.UsernameFilter);

            var UsersTableAsHtmlString = this.RenderViewAsync("../PartialViews/AdminUsersTablePartial", paginationModel.AllUsers, true).Result;
            var PaginationAsHtmlString = this.RenderViewAsync("../PartialViews/AdminUserPaginationPartial", paginationModel, true).Result;
            var UserFiltersAsHtmlString = this.RenderViewAsync("../PartialViews/AdminUserFiltersPartial", paginationModel, true).Result;
            return Json(new
            {
                UsersTableHTML = UsersTableAsHtmlString,
                PaginationHTML = PaginationAsHtmlString,
                UserFiltersHTML = UserFiltersAsHtmlString
            });
        }
/*
        [Authorize]
        public JsonResult UpdateUserAdministrativenRaion(string administrativenRaion)
        {
            _userServices.UpdateUserAdministrativenRaion(_userManager.GetUserId(User), administrativenRaion);
            return Json(new { success = true });
        }
*/
        public int GetMaxIzborTur(string izborNkod)
        {
            return _izboriServices.GetIzborMaxTURByNkod(izborNkod);
        }
    }
}