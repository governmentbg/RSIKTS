using Common.ViewModels.Codepositions;
using System;
using System.Collections.Generic;
using System.Text;

namespace Services.Interfaces.Codepositions
{
    public interface ICodePositionServices
    {
        ICollection<CodePositionViewModel> GetAllCodePositionsByPkode(int pKode);
    }
}
