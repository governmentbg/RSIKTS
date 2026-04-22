using Common.ViewModels.Sik;
using DTO.Sik;
using System.Collections.Generic;

namespace Repository.Interfaces.Sik
{
    public interface ISikRepository
    {
        ICollection<SikBasicDto> GetAllSiks(int page, string sikFilter, string administrativenRaion);

        ICollection<SikBasicDto> GetAllSiksIncludingDefault(string administrativenRaion);

        ICollection<SikBasicDto> GetAllSiks();

        int GetMaxSikPages(string sikFilter, string administrativenRaion);

        void TryAddSik(SikAddViewModel addModel);

        SikEditViewModel GetSik(int sikId);

        void TryDelete(int sikId, string userId);

        void TryEditSik(SikEditViewModel editModel);
        ICollection<SikBasicDto> GetSiksByAdministrativenRaion(string nkod);
        bool CheckSikType(int IdSik);
        int isSikVidCalc(int Id);

    }
}
