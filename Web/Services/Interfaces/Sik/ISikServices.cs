namespace Services.Interfaces.Sik
{
    using Common.ViewModels.Sik;
    using System.Collections.Generic;
    public interface ISikServices
    {
        ICollection<SikBasicViewModel> GetAllSiks(int currentPage, string sikFilter, string administrativenRaion);

        int GetMaxSikPages(string sikFilter, string administrativenRaion);

        SikAddViewModel GetSikAddModel(string administrativenRaion, string naselenoMqstoKod);

        void TryAddSik(SikAddViewModel addModel);

        void TryDelete(int sikId, string userId);

        SikEditViewModel GetSik(int sikId);

        void TryEditSik(SikEditViewModel editModel);

        ICollection<SikBasicViewModel> GetAllSiks();

        ICollection<SikBasicViewModel> GetSiksByAdministrativenRaion(string nkod);
        int isSikVidCalc(int Id);
    }
}
