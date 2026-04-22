namespace Repository.Interfaces.Lica
{
    using Common.ViewModels.Lica;
    using Common.ViewModels.Spravki;
    using DTO.Lica;
    using System.Collections.Generic;
    using System.Threading.Tasks;

    public interface ILicaRepository
    {
        ICollection<LiceGridDTO> GetLicaByPage(int page, string egn, string administrativenRaion, int sik);
        int GetMaxLicaPages(string egn, string administirativenRaion, int sik);
        Task<int> TryAddLicaAsync(LicaAddViewModel addModel, string administirativenRaion);
        LicaEditViewModel GetLicaById(int id);
        Task <int> TryEditLicaAsync(LicaEditViewModel editModel);
        Task <ImportResultLicaDTO> ImportLicaAsync(List<LicaImportViewModel> allLica, string administirativenRaion, string excelFile);
        int DeleteLice(int liceId, string user, string toa);
        int GetLicaFromIzobryCount(string administrativenRajon);
        void NachislqvaneForLiceByIndex(string userId ,string administrativenRajon, int liceIndex);
        string GetFileForNap(int napFileOptionm, string userId, string administrativenRajon, int izborTur);
        ICollection<LicaDeinostiDTO> GetLicaBySik(string administrativenRaion, string sikId);
        void MassUpdateLicaDeinost(LicaMassUpdateDeinostiModel model, string userId);
        void MassUpdateLicaReshenie(LicaMassUpdateResheniqModel model, string userId);
        List<LicaForImportGridDto> GetWrongImportLicaForUser(string userId);
        ICollection<LiceGridDTO> GetLicaByFilter(LicaFilterViewModel model, string userId, int tip);
        ICollection<LicaForSpravka211Dto> GetLicaForSlujebnaSpravka211(SikSpravkaFilter filter, string administrativenRaion, string userId);
        ICollection<LicaForVedomostSpravkaDto> GetLicaForVedomostSpravka(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId);
        ICollection<LicaForSpravka32ViewModel> GetLicaForSpravka32(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId);
        ICollection<LicaForSpravka211Dto> GetLicaForPublichnaSpravka211(IzbRaionWithSikFilter filter, string userId);
        ICollection<LicaDeinostiDTO> GetLicaBySikToaAndSila(string toa, string sik, int silaId);
        ICollection<LicaForSpravka212Dto> GetSystavRezervi(SikSpravkaFilter filter, string administrativenRaion, string userId);
        int GetZamestvanRolia(int id, string administrativenRaion);

        //v.2
        ICollection<LicaDeinostiDTO> GetLicaByToaAndSila(string toa, int silaId, string userId);
        int CheckGraoNumber(string graonumber, int graotype);

    }
}
