namespace Web.Areas.Identity.Controllers
{
    using Common.ViewModels.User;
    using Microsoft.AspNetCore.Identity;
    using Microsoft.AspNetCore.Mvc;
    using Services.Interfaces.Partiq;
    using Services.Interfaces.User;
    using System.Linq;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Services.Interfaces.Raion;
    using Microsoft.AspNetCore.Authorization;

    [Area("Identity")]
    [Authorize(Roles = "Администратор")]
    public class HomeController : Controller
    {
        private readonly IUserServices _userServices;
        private readonly IPartiqServices _partiqServices;
        private readonly IRaionServices _raionServices;

        public HomeController(IUserServices userServices, IPartiqServices partiqServices, IRaionServices raionServices)
        {
            _raionServices = raionServices;
            _partiqServices = partiqServices;
            _userServices = userServices;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Register()
        {
            var registerModel = new SSOUserRegisterViewModel
            {
                AllParti = _partiqServices.GetAllParti().Select(p => new SelectListItem
                {
                    Value = p.Id.ToString(),
                    Text = p.Name
                }).ToList(),

                AllRaioni = _raionServices.GetAllRaioni(null).Select(r => new SelectListItem
                {
                    Value = r.Id,
                    Text = r.Name
                }).ToList()
            };

            return View(registerModel);
        }

        [HttpPost]
        public IActionResult Register(SSOUserRegisterViewModel userModel)
        {
            var resultOfRegister = _userServices.TryRegisterUser(userModel);

            if (resultOfRegister.Count == 0)
            {
                return RedirectToAction("Index", "Home", new { area = "Admin" });
            }
            else
            {
                foreach (var error in resultOfRegister)
                {
                    ModelState.AddModelError(string.Empty, error.Description);
                }

                var registerModel = new SSOUserRegisterViewModel
                {
                    AllParti = _partiqServices.GetAllParti().Select(p => new SelectListItem
                    {
                        Value = p.Id.ToString(),
                        Text = p.Name
                    }).ToList(),

                    AllRaioni = _raionServices.GetAllRaioni(null).Select(r => new SelectListItem
                    {
                        Value = r.Id,
                        Text = r.Name
                    }).ToList()
                };

                return View("Register", registerModel);
            }
        }

    }
}