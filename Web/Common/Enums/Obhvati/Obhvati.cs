namespace Common.Enums.Obhvati
{
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;

    public enum Obhvati
    {
        [Description("Global")]
        [Display(Name = "Глобален")]
        Global = 0,
        [Description("ForRegion")]
        [Display(Name = "За регион")]
        ForRegion = 1
    }
}
