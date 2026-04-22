namespace Services.Interfaces.Spravki
{
    using Common.Enums.Spravki;
    using Common.ViewModels.Lica;
    using Common.ViewModels.Spravki;
    using System.Collections.Generic;
    using System.IO;

    public interface ISpravkiServices
    {
        ICollection<StatisticViewModel> GetAllStatistics(int tip);
        ICollection<NomeklatureViewModel> GetAllNomenklatures(int tip);
        ICollection<NomenklaturaBasicViewModel> GetNomenklatureBasicDetails(NomenklatureIds nomenklatureEnum, int page, string nameFilter, string administrativenRaion);
        int GetNomenklatureMaxPages(NomenklatureIds nomenklatureEnum, string nameFilter, string administrativenRaion);
        NomenklatureEditFullViewModel GetNomenklatureEdit(NomenklatureIds nomenklatureEnum, string nomenklatureCode, int id);
        void NomenklatureEdit(NomenklatureEditFullViewModel editModel);
        NomenklatureEditFullViewModel GetNomenklatureAdd(NomenklatureIds nomenklatureId);
        void NomenklatureAdd(NomenklatureEditFullViewModel model, string administrativenRaion);
        void NomenklatureDelete(NomenklatureIds nomenklatureEnum, string nomenklatureCode, int id);
        string GetStatisticContents(GenerateReportViewModel model, string userId);
        ICollection<NomenklaturaBasicViewModel> GetAllNomenklatureBasicDetails(NomenklatureIds nomenklature, string administrativenRaion);
        ICollection<SpisukNaSekciiteSpravkaViewModel> GetSpisukNaSekciiteSpravka(IzbRaionWithSikFilter filter, string userId);
        ICollection<BroiSekciiSpravkaViewModel> GetBroiSekciiSpravka(IzbRaionWithSikFilter filter, string userId);
        ICollection<ZaetiPoziciiSpravkaViewModel> GetZaetiPoziciiPublichnaSpravka(IzbRaionWithSikFilter filter, string userId);
        ICollection<ZaetiPoziciiSpravkaViewModel> GetZaetiPoziciiObjoPublichnaSpravka(IzbRaionWithSikFilter filter, string userId);
        ICollection<ReshetkaSpravkaViewModel> GetReshetkaSpravka(PartiaFilterViewModel filter, string administrativenRaion, string userId);
        ICollection<ZamestvajiSpravkaViewModel> GetZamestvajiSpravka(SikSpravkaFilter filter, string administrativenRaion, string userId);
        ICollection<SustoqnieNaRegistraciiteSpravkaViewModel> GetSustoqnieNaRegistraciiteSpravka(RoliSpravkaFilter filter, string administrativenRaion, string userId);
        DashboardSpravkaViewModel GetDashboardSpravka(string administrativenRaion, string userId);
        string GenerateSpisukLicaExcelExport(LicaFilterViewModel filter, string userId);
        string GenerateSpisukLicaExcelExport23(SikSpravkaFilter filter, string administrativenRaion, string userId);
        ICollection<IstoriaSikViewModel> GetSikIstoria(IzbRaionWithSikFilter filter, string user);
        ICollection<SpisykPodvizjniSekciiViewModel> GetSpisykPodvizjniSekcii(IzbRaionWithSikFilter filter, string user);
        ICollection<SpisukSekciiGraniciSpravkaViewModel> GetSpisukSekciiGraniciSpravka(IzbRaionWithSikFilter filter, string userId);
        
        /*v.2*/
        ICollection<LicaForSpravkaRziViewModel> GetSpisukRziSpravka(SpravkaRziFilter filter, string userId);
      
        string GenerateSpisukRziExport(SpravkaRziFilter filter, string userId);

        ICollection<SpravkaSekciiLicaViewModel> GetSpisukSekciiLica(IzbRaionWithSikFilter filter);
        string GenerateSekciiLicaExport(IzbRaionWithSikFilter filter);
        string GenerateSpisykSekcii(IzbRaionWithSikFilter filter, string userId);
        string GenerateSpisykSekcii2(IzbRaionWithSikFilter filter, string userId);

    }
}
