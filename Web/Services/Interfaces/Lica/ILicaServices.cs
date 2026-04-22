namespace Services.Interfaces.Lica
{
    using Common.ViewModels.Lica;
    using Common.ViewModels.Spravki;
    using System.Collections.Generic;
using System.Threading.Tasks;

    public interface ILicaServices
    {
        ICollection<LiceGridViewModel> GetLicaByPage(int page, string egn, string administrativenRaion, int sik);
        int GetMaxLicaPages(string egn, string administirativenRaion, int sik);
        LicaAddViewModel GetLicaAddViewModel(string administrativenRaion, int sik);
        Task<int> TryAddLicaAsync(LicaAddViewModel addModel, string administirativenRaion);
        LicaEditViewModel GetLicaById(int id, string userid);
        Task<int> TryEditLicaAsync(LicaEditViewModel editModel);
        Task<ImportResultLicaViewModel> ImportLicaAsync(List<LicaImportViewModel> allLica, string administirativenRaion, string excelFile);
        int DeleteLice(int liceId, string user, string toa);
        int GetLicaFromIzobryCount(string administrativenRajon);
        void NachislqvaneForLiceByIndex(string userId, string administrativenRajon, int liceIndex);
        string GetFileForNap(int napFileOptionm, string userId, string administrativenRajon, int izborTur);
        LicaDeinostiComposite GetLicaDeinostiViewModel(string administrativenRaion, string sikId);
        LicaResheniqComposite GetLicaResheniqViewModel(string administrativenRaion, string sikId);
        ICollection<LicaMassUpdateViewModel> GetLicaBySikAndToa(string administrativenRaion, string sikId);
        void MassUpdateLicaDeinost(LicaMassUpdateDeinostiModel model, string userId);
        void MassUpdateLicaReshenie(LicaMassUpdateResheniqModel model, string userId);
        List<LicaForImportGridViewModel> GetWrongImportLicaForUser(string userId);
        ICollection<LiceGridViewModel> GetLicaByFilter(LicaFilterViewModel model, string userId, int tip);
        ICollection<LicaForSpravka211ViewModel> GetLicaForSlujebnaSpravka211(SikSpravkaFilter filter, string administrativenRaion, string userId);
        ICollection<LicaForVedomostSpravkaViewModel> GetLicaForVedomostSpravka(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId);
        ICollection<LicaForSpravka32ViewModel> GetLicaForSpravka32(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId);
        ICollection<LicaForSpravka211ViewModel> GetLicaForPublichnaSpravka211(IzbRaionWithSikFilter filter, string userId);
        byte[] GetFileForInvalidImport(string userId);
        string GenerateSpisukLicaExcelExport212(SikSpravkaFilter filter, string administrativenRaion, string userId);
        ICollection<LicaMassUpdateViewModel> GetLicaBySikToaAndSila(string toa, string sik, int silaId);
        ICollection<LicaForSpravka212ViewModel> GetSystavRezervi(SikSpravkaFilter filter, string administrativenRaion, string userId);

        string GenerateSpisukLicaExcelExport213(SikSpravkaFilter filter, string administrativenRaion, string userId);
        string GenerateSpisukLicaExcelExport311(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId);
        string GenerateSpisukLicaExcelExport312(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId);
        int GetZamestvanRolia(int id, string administrativenRaion);
        string GenerateSpravkaExcelExport32(TurWithSikSpravkaFilter filter, string administrativenRaion, string userId);

//v.2
        bool CheckSikType(int idsik);
        ICollection<LicaMassUpdateViewModel> GetLicaByToaAndSila(string toa, int silaId, string userId);
        bool CheckGraoNumber(string graonumber, int graotype);
    }
}
