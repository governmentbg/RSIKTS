namespace Services.Implementations.Izbori
{
    using Common.ViewModels.Izbori;
    using Common.ViewModels.Obrabotki;
    using DTO.Izbori;
    using Repository.Interfaces.Izbori;
    using Services.Interfaces.Izbori;
    using System;
    using System.Collections.Generic;
    using System.Linq;

    public class IzboriServices : IIzboriServices
    {
        private readonly IIzboriRepository _izboriRepository;

        public IzboriServices(IIzboriRepository izboriRepository)
        {
            _izboriRepository = izboriRepository;
        }

        public string GetIzborAlias()
        {
            return _izboriRepository.GetIzborAlias();
        }

        public DateTime GetIzborDate()
        {
            return _izboriRepository.GetIzborDate();
        }

        public DateTime GetIzborEndDate()
        {
            return _izboriRepository.GetIzborEndDate();
        }

        public string GetIzborDescription()
        {
            return _izboriRepository.GetIzborDescription();
        }

        public string GetIzborDescriptionWithoutTur()
        {
            return _izboriRepository.GetIzborDescriptionWithoutTur();
        }

        public ICollection<IzborTipViewModel> GetTipIzbori()
        {
            return _izboriRepository.GetTipIzbori().Select(i => new IzborTipViewModel
            {
                Id = i.Id,
                Nime = i.Nime,
                Nkod = i.Nkod,
                Tur = i.Tur,
                Status = i.Status
            }).ToList();
        }

        public string getIzborTur()
        {
            string retval = "";

            if (_izboriRepository.GetIzborMaxTUR() == 2)
            {
                retval = "Тур " + _izboriRepository.GetIzborTUR();
            }

            return retval;
        }

        public void StartNewIzbor(string userId, AdminOptionsFilter filter)
        {
            _izboriRepository.StartNewIzbor(userId, filter);
        }

        public int GetIzborMaxTUR()
        {
            return _izboriRepository.GetIzborMaxTUR();
        }

        public int GetIzborMaxTURByNkod(string nkod)
        {
            return _izboriRepository.GetIzborMaxTURByNkod(nkod);
        }

        public void DeleteDatabase(string userId)
        {
            _izboriRepository.DeleteDatabase(userId);
        }

        public void NewIzborTur(string userId)
        {
            _izboriRepository.NewIzborTur(userId);
        }

        public int getIzborCurrentTur()
        {
            int retval = 1;

            if (_izboriRepository.GetIzborMaxTUR() == 2)
            {
                retval =  _izboriRepository.GetIzborTUR();
            }

            return retval;
        }

        public string GetTurBeginDate(int tur)
        {
            return _izboriRepository.GetTurBeginDate(tur);
        }
        public string GetTurEndDate(int tur)
        {
            return _izboriRepository.GetTurEndDate(tur);

        }

        public string GetCode(string pCode)
        {           
            return _izboriRepository.GetCode(pCode);
        }

    }
}
