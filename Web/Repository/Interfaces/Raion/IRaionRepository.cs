namespace Repository.Interfaces.Raion
{
    using Common.ViewModels.Raion;
    using DTO.Raion;
    using System.Collections.Generic;

    public interface IRaionRepository
    {
        ICollection<RaionDTO> GetAllRaioni(string administrativenRaion);

        ICollection<RaionMainDTO> GetMainRaioniByUserAndPage(string userId, int page, string toaId);

        int GetMaxRaioniMainPagesByUser(string userId, int page, string toaId);

        void DeleteRaionMainById(int raionMainId);

        void AddRaionMain(RaionAddViewModel newRaion, string userId);

        RaionAddViewModel GetRaionMain(string administrativenRaion);

        void EditRaionMain(RaionAddViewModel editRaion, string userId);

        ICollection<AdministrativenRaionDto> GetAdmninistrativniRaioniByIzbRaion(string nkod);

        int RegionHasBulstat(string nkod);

        int GetIzbRaionMaxBroiSikByNime(string nime);

        int GetIzbRaionMinBroiSikByNime(string nime);

        int GetIzbRaionMinBroiSikByNkod(string nkod);

        int GetIzbRaionMaxBroiSikByNkod(string nkod);

        string GetAdministrativenRaionIzbRaionNime(int nrec);

        int GetAdministrativenRaionChlenove(string nkod);

        ICollection<AdministrativenRaionWithIzbirateliDto> GetAdmninistrativniRaioniWithIzbirateliByIzbRaion(string nkod);

        string GetIzbRaion(string toa);
    }
}
