using Common.ViewModels.Codepositions;
using Repository.Interfaces.Codepositions;
using Services.Interfaces.Codepositions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Services.Implementations.Codepositions
{
    public class CodePositionServices : ICodePositionServices
    {
        private readonly ICodePositionsRepository _codePositionsRepository;

        public CodePositionServices(ICodePositionsRepository codePositionsRepository)
        {
            _codePositionsRepository = codePositionsRepository;
        }

        public ICollection<CodePositionViewModel> GetAllCodePositionsByPkode(int pKode)
        {
            return _codePositionsRepository.GetAllCodePositionsByPkode(pKode).Select(c => new CodePositionViewModel
            {
                Id = c.Id,
                Nime = c.Nime,
                Nkode = c.Nkode,
                Pkode = c.Pkode
            }).OrderBy(c => c.Nkode)
            .ToList();
        }
    }
}
