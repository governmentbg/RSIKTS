namespace Services.Implementations.Partiq
{
    using System.Collections.Generic;
    using System.Linq;
    using Common.ViewModels.Partiq;
    using Repository.Interfaces.Partiq;
    using Services.Interfaces.Partiq;

    public class PartiqServices : IPartiqServices
    {
        private readonly IPartiqRepository _partiqRepository;

        public PartiqServices(IPartiqRepository partiqRepository)
        {
            _partiqRepository = partiqRepository;
        }

        public ICollection<PartiqBasicViewModel> GetAllParti()
        {
            return _partiqRepository.GetAllParti().Select(p => new PartiqBasicViewModel
            {
                Id = p.Id,
                Name = p.Name
            }).ToList();
        }
    }
}
