namespace Services.Interfaces.List
{
    using Common.ViewModels.List;
    using System.Collections.Generic;

    public interface IListServices
    {
        ICollection<ListCodepositionsViewModel> GetCodePositions(int pKode);

        ICollection<CodePositionsWithMoneyViewModel> GetCodePositionsAndPriznaci(int tur);

        ICollection<CodePositionsWithMoneyViewModel> GetCodePositionsAndOperacii(int tur);

        ICollection<NormiRoliWithMoneyViewModel> GetCodePositionsAndRoliBySilaAndTur(int silaId, int tur);

        CodePositionsWithMoneyViewModel GetCodePositionWithMoneyByIdAndTur(int normaId, int tur);

        NormiRoliWithMoneyViewModel GetNormaRoliWithMoneyByIdSilaAndTur(int normaId, int silaId, int tur);

        void TryEditNorma(CodePositionsWithMoneyViewModel editModel);

        void TryEditNormaRoli(NormiRoliWithMoneyViewModel editModel);
    }
}
