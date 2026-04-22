namespace Repository.Interfaces.Spravki
{
    using Common.Enums.Spravki;
    using Common.ViewModels.Spravki;
    using DataAccess;
    using DTO.Spravki;
    using System.Collections.Generic;
    using System.IO;

    public interface ISpravkiRepository
    {
        ICollection<StatisticDTO> GetAllStatistics(int tip);
        ICollection<NomenklatureDTO> GetAllNomenklatures(int tip);
        ICollection<NomenklaturaBasicViewModel> GetNomenklatureBasicDetails(NomenklatureIds nomenklatureEnum, int page, string nameFilter, string administrativenRaion);
        int GetNumenklatureMaxPages(NomenklatureIds nomenklatureEnum, string nameFilter, string administrativenRaion);
        NomenklatureEditFullViewModel GetNomenklatureEdit(NomenklatureIds nomenklatureEnum, string nomenklatureCode, int id);
        void NomenklatureEdit(NomenklatureEditFullViewModel editModel);
        NomenklatureEditFullViewModel GetNomenklatureAdd(NomenklatureIds nomenklatureEnum);
        void NomenklatureAdd(NomenklatureEditFullViewModel model, string administrativenRaion);
        void NomenklatureDelete(NomenklatureIds nomenklatureEnum, string nomenklatureCode, int id);
        ICollection<NomenklaturaBasicViewModel> GetAllNomeklatureBasicDetails(NomenklatureIds nomenklatureEnum, string administrativenRaion);
        string GetMudoStatisticContents(GenerateReportViewModel model, string userId);
        string GetMsbdStatisticContents(GenerateReportViewModel model, string userId);
        string GetMsbStatisticContents(GenerateReportViewModel model, string userId);
        string GetMorsStatisticContents(GenerateReportViewModel model, string userId);
        ICollection<SpisukNaSekciiteSpravkaDto> GetSpisukNaSekciiteSpravka(IzbRaionWithSikFilter filter, string userId);
        ICollection<BroiSekciiSpravkaDto> GetBroiSekciiSpravka(IzbRaionWithSikFilter filter, string userId);
        ICollection<ZaetiPoziciiSpravkaDto> GetZaetiPoziciiPublichnaSpravka(IzbRaionWithSikFilter filter, string userId);
        ICollection<ZaetiPoziciiSpravkaDto> GetZaetiPoziciiObjoPublichnaSpravka(IzbRaionWithSikFilter filter, string userId);
        ICollection<ReshetkaSpravkaDto> GetReshetkaSpravka(PartiaFilterViewModel filter, string administrativenRaion, string userId);
        ICollection<ZamestvajiSpravkaDto> GetZamestvajiSpravka(SikSpravkaFilter filter, string administrativenRaion, string userId);
        ICollection<SustoqnieNaRegistraciiteSpravkaDto> GetSustoqnieNaRegistraciiteSpravka(RoliSpravkaFilter filter, string administrativenRaion, string userId);
        DashboardSpravkaDto GetDashboardSpravka(string administrativenRaion, string userId);
        ICollection<IstoriaSikViewModel> GetSikIstoria(IzbRaionWithSikFilter filter, string user);
        ICollection<SpisykPodvizjniSekciiViewModel> GetSpisykPodvizjniSekcii(IzbRaionWithSikFilter filter, string user);
        ICollection<SpisukSekciiGraniciSpravkaDto> GetSpisukSekciiGraniciSpravka(IzbRaionWithSikFilter filter, string userId);
        ICollection<SpisukSpravkaRziDto> GetSpisukRziSpravka(SpravkaRziFilter filter, string userId);

        ICollection<SpravkaSekciiLicaDto> GetSpisukSekciiLica(IzbRaionWithSikFilter filter);
    }
}
