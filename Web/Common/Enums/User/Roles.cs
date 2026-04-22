namespace Common.Enums.User
{
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;

    public enum Roles
    {
        [Description("Администратор")]
        [Display(Name = "Администратор")]
        Admin,

        [Description("Оператор")]
        [Display(Name = "Оператор")]
        Global,

        [Description("ОИК/РИК")]
        [Display(Name = "ОИК/РИК")]
        Partiq,
    }   
}

        



