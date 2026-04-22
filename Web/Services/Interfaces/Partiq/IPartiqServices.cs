namespace Services.Interfaces.Partiq
{
    using Common.ViewModels.Partiq;
    using System.Collections.Generic;

    public interface IPartiqServices
    {
        ICollection<PartiqBasicViewModel> GetAllParti();
    }
}
