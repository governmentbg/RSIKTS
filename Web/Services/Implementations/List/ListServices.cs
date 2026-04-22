namespace Services.Implementations.List
{
    using Common.ViewModels.List;
    using Repository.Interfaces.Codepositions;
    using Repository.Interfaces.List;
    using Services.Interfaces.List;
    using System.Collections.Generic;
    using System.Linq;

    public class ListServices : IListServices
    {
        readonly private IListRepository _listRepository;
        readonly private ICodePositionsRepository _codepositionsRepository;

        public ListServices(IListRepository listRepository, ICodePositionsRepository codepositionsRepository)
        {
            _codepositionsRepository = codepositionsRepository;
            _listRepository = listRepository;
        }

        public ICollection<ListCodepositionsViewModel> GetCodePositions(int pKode)
        {
            return _listRepository.GetCodePositions(pKode).Select(c => new ListCodepositionsViewModel
            {
                Id = c.Id,
                Nime = c.Nime,
                Nkode = c.Nkode,
                Pkode = c.Pkode
            }).OrderBy(c => c.Nkode)
            .ToList();
        }

        public ICollection<CodePositionsWithMoneyViewModel> GetCodePositionsAndOperacii(int tur)
        {
            return _codepositionsRepository.GetCodePositionsAndOperacii(tur).Select(c => new CodePositionsWithMoneyViewModel
            {
                Id = c.Id,
                Nkode = c.Nkode,
                Pkode = c.Pkode,
                Nime = c.Nime,
                Money = c.Money,
                Status = c.Status
            }).OrderBy(c => c.Nkode)
            .ToList();
        }

        public ICollection<CodePositionsWithMoneyViewModel> GetCodePositionsAndPriznaci(int tur)
        {
            return _codepositionsRepository.GetCodePositionsAndPriznaci(tur).Select(c => new CodePositionsWithMoneyViewModel
            {
                Id = c.Id,
                Nkode = c.Nkode,
                Pkode = c.Pkode,
                Nime = c.Nime,
                Money = c.Money,
                Status = c.Status
            }).OrderBy(c => c.Nkode)
            .ToList();
        }

        public ICollection<NormiRoliWithMoneyViewModel> GetCodePositionsAndRoliBySilaAndTur(int silaId, int tur)
        {
            return _codepositionsRepository.GetCodePositionsAndRoliBySilaAndTur(silaId, tur).Select(c => new NormiRoliWithMoneyViewModel
            {
                Id = c.Id,
                Nkode = c.Nkode,
                Pkode = c.Pkode,
                Nime = c.Nime,
                Money = c.Money,
                SilaId = c.SilaId,
                Status = c.Status
            }).OrderBy(c => c.Nkode)
            .ToList();
        }

        public CodePositionsWithMoneyViewModel GetCodePositionWithMoneyByIdAndTur(int normaId, int tur)
        {
            var codePosition =  _codepositionsRepository.GetCodePositionWithMoneyByIdAndTur(normaId , tur);

            return new CodePositionsWithMoneyViewModel
            {
                Id = codePosition.Id,
                Nkode = codePosition.Nkode,
                Nime = codePosition.Nime,
                Money = codePosition.Money,
                Pkode = codePosition.Pkode,
                Status = codePosition.Status,
                Tur = codePosition.Tur
            };
        }

        public NormiRoliWithMoneyViewModel GetNormaRoliWithMoneyByIdSilaAndTur(int normaId, int silaId, int tur)
        {
            var codePosition = _codepositionsRepository.GetNormaRoliWithMoneyByIdSilaAndTur(normaId, silaId, tur);

            return new NormiRoliWithMoneyViewModel
            {
                Id = codePosition.Id,
                Nkode = codePosition.Nkode,
                Nime = codePosition.Nime,
                Money = codePosition.Money,
                Pkode = codePosition.Pkode,
                SilaId = codePosition.SilaId,
                Status = codePosition.Status,
                Tur = codePosition.Tur
            };
        }

        public void TryEditNorma(CodePositionsWithMoneyViewModel editModel)
        {
            _codepositionsRepository.TryEditNorma(editModel);
        }

        public void TryEditNormaRoli(NormiRoliWithMoneyViewModel editModel)
        {
            _codepositionsRepository.TryEditNormaRoli(editModel);
        }
    }
}
