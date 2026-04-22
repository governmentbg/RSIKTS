namespace Common.ViewModels.User
{
    using Microsoft.AspNetCore.Identity;

    public class SSOUserIdentity : IdentityUser
    {
        public virtual string Administrative_Rajon { get; set; }
        public virtual int? Ot_Partiq { get; set; }
        public virtual string Names { get; set; }
        public virtual bool IsDeleted { get; set; }

    }
}
