namespace Services.Interfaces.Raion
{
    using Common.ViewModels.Raion;
    using System.Collections.Generic;

    public interface IRaionServices
    {
        ICollection<RaionViewModel> GetAllRaioni(string administrativenRaion);

        ICollection<RaionMainViewModel> GetMainRaioniByUserAndPage(string userId, int page, string toaId);

        int GetMaxRaioniMainPagesByUser(string userId, int page, string toaId);

        void DeleteRaionMainById(int raionMainId);

        void AddRaionMain(RaionAddViewModel newRaion, string userId);

        RaionAddViewModel GetRaionAddViewModel(string administrativenRaion);

        RaionAddViewModel GetRaionMain(string administrativenRaion);

        void EditRaionMain(RaionAddViewModel editRaion, string userId);
        ICollection<AdministrativenRaionViewModel> GetAdmninistrativniRaioniByIzbRaion(string nkod);

        int GetIzbRaionMinBroiSikByNime(string nime);

        int GetIzbRaionMaxBroiSikByNime(string nime);

        int GetIzbRaionMinBroiSikByNkod(string nkod);

        int GetIzbRaionMaxBroiSikByNkod(string nkod);

        int GetAdministrativenRaionChlenove(string nkod);

        string GetAdministrativenRaionIzbRaionNime(int nrec);

        int RegionHasBulstat(string nkod);

        string GetIzbRaion(string toa);
    }
}
