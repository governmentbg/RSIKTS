using Common.ViewModels.List;
using DTO.Codepositions;
using System;
using System.Collections.Generic;
using System.Text;

namespace Repository.Interfaces.Codepositions
{
    public interface ICodePositionsRepository
    {
        ICollection<CodePositionDto> GetAllCodePositions();

        ICollection<CodePositionDto> GetAllCodePositionsByPkode(int pKode);

        ICollection<CodePositionWithMoneyDto> GetCodePositionsAndPriznaci(int tur);

        ICollection<CodePositionWithMoneyDto> GetCodePositionsAndOperacii(int tur);

        ICollection<NormiRoliWithMoneyViewModel> GetCodePositionsAndRoliBySilaAndTur(int silaId, int tur);

        CodePositionWithMoneyDto GetCodePositionWithMoneyByIdAndTur(int normaId, int tur);

        void TryEditNorma(CodePositionsWithMoneyViewModel editModel);

        NormiRoliWithMoneyDto GetNormaRoliWithMoneyByIdSilaAndTur(int normaId, int silaId, int tur);
        void TryEditNormaRoli(NormiRoliWithMoneyViewModel editModel);
    }
}
