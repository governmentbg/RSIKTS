namespace Web
{
    using Microsoft.AspNetCore.Builder;
    using Microsoft.AspNetCore.Identity;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.DependencyInjection;
    using DataAccess;
    using Services.Interfaces.User;
    using Services.Implementations.User;
    using Repository.Interfaces.User;
    using Repository.Implementations;
    using System;
    using System.Threading.Tasks;
    using Common.ViewModels.User;
    using Repository.Interfaces.Partiq;
    using Repository.Implementations.Partiq;
    using Repository.Implementations.Ulici;
    using Services.Interfaces.Partiq;
    using Services.Implementations.Partiq;
    using Services.Interfaces.Raion;
    using Repository.Interfaces.Raion;
    using Services.Implementations.Raion;
    using Repository.Implementations.Raion;
    using Services.Interfaces.Spravki;
    using Repository.Interfaces.Spravki;
    using Services.Implementations.Spravki;
    using Repository.Implementations.Spravki;
    using Services.Interfaces.Lica;
    using Repository.Implementations.Lica;
    using Services.Implementations.Lica;
    using Repository.Interfaces.Lica;
    using Repository.Interfaces.Ulici;
    using Repository.Interfaces.Objini;
    using Repository.Implementations.Objini;
    using Repository.Implementations.Oblasti;
    using Repository.Interfaces.Oblasti;
    using Repository.Interfaces.NaseleniMesta;
    using Repository.Implementations.NaseleniMesta;
    using Repository.Interfaces.Kvartali;
    using Repository.Implementations.Kvartali;
    using Services.Implementations.Ulici;
    using Services.Interfaces.Ulici;
    using Repository.Interfaces.Sik;
    using Repository.Implementations.Sik;
    using Services.Implementations.Sik;
    using Services.Interfaces.Sik;
    using Repository.Interfaces.List;
    using Services.Interfaces.List;
    using Services.Implementations.List;
    using Repository.Implementations.List;
    using Repository.Interfaces.Nacionalnosti;
    using Repository.Implementations.Nacionalnosti;
    using Repository.Interfaces.RaionniUpravleniq;
    using Repository.Implementations.RaionniUpravleniq;
    using Repository.Interfaces.Specialnosti;
    using Repository.Implementations.Specialnosti;
    using Repository.Implementations.Obrazovaniq;
    using Repository.Interfaces.Obrazovaniq;
    using Repository.Interfaces.Codepositions;
    using Repository.Implementations.Codepositions;
    using Repository.Implementations.Parameters;
    using Services.Implementations.Parameters;
    using Services.Interfaces.Parameters;
    using Repository.Interfaces.Parameters;
    using Repository.Implementations.Izbori;
    using Repository.Interfaces.Izbori;
    using Services.Implementations.Izbori;
    using Services.Interfaces.Izbori;
    using Repository.Interfaces.Kvoti;
    using Repository.Implementations.Kvoti;
    using Services.Implementations.Kvoti;
    using Services.Interfaces.Kvoti;
    using Services.Interfaces.Codepositions;
    using Services.Implementations.Codepositions;
    using Services.Interfaces.IzbiratelenRaioni;
    using Services.Implementations.IzbiratelenRaioni;
    using Repository.Interfaces.IzbiratelenRaioni;
    using Repository.Implementations.IzbiratelenRaioni;
    using Repository.Implementations.Nachislqvaniq;
    using Repository.Interfaces.Nachislqvaniq;
    using Services.Interfaces.Nachislqvaniq;
    using Services.Implementations.Nachislqvaniq;

    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            //services.Configure<CookiePolicyOptions>(options =>
            //{
            //    // This lambda determines whether user consent for non-essential cookies is needed for a given request.
            //    options.CheckConsentNeeded = context => true;
            //    options.MinimumSameSitePolicy = SameSiteMode.None;
            //});

            services.AddDbContext<VotingRegisterContext>(options =>
                options.UseMySql(
                    Configuration.GetConnectionString("DefaultConnection")), ServiceLifetime.Scoped);



            services.AddIdentity<SSOUserIdentity, IdentityRole>(options =>
            {
                options.User.RequireUniqueEmail = true;
                options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);
                options.Password.RequireNonAlphanumeric = false;
                options.Password.RequireUppercase = false;

            })
            .AddDefaultTokenProviders()
            .AddDefaultUI()
            .AddRoles<IdentityRole>()
            .AddRoleManager<RoleManager<IdentityRole>>()
            .AddEntityFrameworkStores<VotingRegisterContext>();

            services.AddScoped<UserManager<SSOUserIdentity>>(); // Ensure UserManager is registered

            services.ConfigureApplicationCookie(options =>
            {
                options.LoginPath = $"/Identity/Account/Login";
                options.LogoutPath = $"/Identity/Account/Logout";
                options.AccessDeniedPath = $"/Identity/Account/AccessDenied";
            });

            services.AddAuthorization();
            services.AddAuthentication();

            services.AddMvc(options => {
                    options.EnableEndpointRouting = false;
                })
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_2)
                .AddRazorPagesOptions(options =>
                {
                    options.AllowAreas = true;
                    options.Conventions.AuthorizeAreaFolder("Identity", "/Account/Manage");
                    options.Conventions.AuthorizeAreaPage("Identity", "/Account/Logout");
                }
                
            );


            services.AddTransient<IUserServices, UserServices>();
            services.AddTransient<IUserRepository, UserRepository>();
            services.AddTransient<IRaionServices, RaionServices>();
            services.AddTransient<IRaionRepository, RaionRepository>();
            services.AddTransient<IPartiqServices, PartiqServices>();
            services.AddTransient<IPartiqRepository, PartiqRepository>();
            services.AddTransient<ISpravkiServices, SpravkiServices>();
            services.AddTransient<ISpravkiRepository, SpravkiRepository>();
            services.AddTransient<ILicaServices, LicaServices>();
            services.AddTransient<ILicaRepository, LicaRepository>();
            services.AddTransient<IUliciRepository, UliciRepository>();
            services.AddTransient<IObjiniRepository, ObjiniRepository>();
            services.AddTransient<IOblastiRepository, OblastiRepository>();
            services.AddTransient<INaseleniMestaRepository, NaseleniMestaRepository>();
            services.AddTransient<IKvartaliRepository, KvartaliRepository>();
            services.AddTransient<IUliciServices, UliciServices>();
            services.AddScoped<ISikRepository, SikRepository>();
            services.AddScoped<ISikServices, SikServices>();
            services.AddTransient<IListRepository, ListRepository>();
            services.AddTransient<IListServices, ListServices>();
            services.AddTransient<INacionalnostiRepository, NacionalnostiRepository>();
            services.AddTransient<IRaionniUpravleniqRepository, RaionniUpravleniqRepository>();
            services.AddTransient<ISpecialnostiRepository, SpecialnostiRepository>();
            services.AddTransient<IObrazovaniqRepository, ObrazovaniqRepository>();
            services.AddTransient<ICodePositionsRepository, CodePositionsRepository>();
            services.AddTransient<ICodePositionServices, CodePositionServices>();
            services.AddTransient<IParametersRepository, ParametersRepository>();
            services.AddTransient<IParametersServices, ParametersServices>();
            services.AddTransient<IIzboriRepository, IzboriRepository>();
            services.AddTransient<IIzboriServices, IzboriServices>();
            services.AddTransient<IKvotiRepository, KvotiRepository>();
            services.AddTransient<IKvotiServices, KvotiServices>();
            services.AddTransient<IIzbiratelniRaioniRepository, IzbiratelniRaioniRepository>();
            services.AddTransient<IIzbiratelniRaioniServices, IzbiratelniRaioniServices>();
            services.AddTransient<INachislqvaniqRepository, NachislqvaniqRepository>();
            services.AddTransient<INachislqvaniqServices, NachislqvaniqServices>();

        }

        private async Task CreateRoles(IServiceProvider serviceProvider)
        {
            //adding custom roles
            var RoleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();

            string[] roleNames = { "Администратор", "Оператор", "ОИК/РИК" };
            IdentityResult roleResult;
            foreach (var roleName in roleNames)
            {
                //creating the roles and seeding them to the database
                var roleExist = await RoleManager.RoleExistsAsync(roleName);
                if (!roleExist)
                {
                    roleResult = await RoleManager.CreateAsync(new IdentityRole(roleName));
                }
            }        
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, IServiceProvider serviceProvider)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseDatabaseErrorPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseAuthentication();

            app.UseMvc(routes =>
            {
                routes.MapAreaRoute(
                    name: "MyAreaSpravki",
                    areaName: "Spravki",
                    template: "Spravki/{controller=Home}/{action=Index}/{id?}");

                routes.MapAreaRoute(
                    name: "MyAreaLica",
                    areaName: "Lica",
                    template: "Lica/{controller=Home}/{action=Index}/{id?}");

                routes.MapAreaRoute(
                    name: "MyAreaSik",
                    areaName: "Sik",
                    template: "Sik/{controller=Home}/{action=Index}/{id?}");

                routes.MapAreaRoute(
                    name: "MyAreaAdmin",
                    areaName: "Admin",
                    template: "Admin/{controller=Home}/{action=Index}/{id?}");

                routes.MapAreaRoute(
                    name: "MyAreaIdentity",
                    areaName: "Identity",
                    template: "Identity/{controller=Home}/{action=Index}/{id?}");

                routes.MapAreaRoute(
                    name: "MyAreaObrabotki",
                    areaName: "Obrabotki",
                    template: "Obrabotki/{controller=Home}/{action=Index}/{id?}");

                routes.MapAreaRoute(
                    name: "MyAreaRegistri",
                    areaName: "Registri",
                    template: "Registri/{controller=Home}/{action=Index}/{id?}");

                routes.MapAreaRoute(
                    name: "MyAreaRaioni",
                    areaName: "Raioni",
                    template: "Raioni/{controller=Home}/{action=Index}/{id?}");

                routes.MapAreaRoute(
                    name: "MyAreaUlici",
                    areaName: "Ulici",
                    template: "Ulici/{controller=Home}/{action=Index}/{id?}");

                routes.MapAreaRoute(
                    name: "MyAreaNormi",
                    areaName: "Normi",
                    template: "Normi/{controller=Home}/{action=Index}/{id?}");

                routes.MapAreaRoute(
                    name: "MyAreaParameters",
                    areaName: "Parameters",
                    template: "Parameters/{controller=Home}/{action=Index}/{id?}");

                routes.MapAreaRoute(
                    name: "MyAreaKvoti",
                    areaName: "Kvoti",
                    template: "Kvoti/{controller=Home}/{action=Index}/{id?}");

                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");
            });

            CreateRoles(serviceProvider).Wait();
        }
    }
}
