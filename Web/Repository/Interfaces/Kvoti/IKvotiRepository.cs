using Common.ViewModels.Kvoti;
using DTO.Kvoti;
using System.Collections.Generic;

namespace Repository.Interfaces.Kvoti
{
    public interface IKvotiRepository
    {
        ICollection<KvotiDto> AllKvoti(string administrativenRaion);

        KvotiEditViewModel GetKvotaById(string id, string administrativenRaion);

        void EditKvota(KvotiEditViewModel kvota, string administrativenRaion, string userId);

        List<ReshetkaDto> GetReshetkaInfo(string administrativenRaion);

        ReshetkaEditViewModel GetReshetkaEdit(int sikId);

        void EditReshetka(ReshetkaEditViewModel model, string administrativenRaion, string user);

        List<ReshetkaDetailsDto> GetReshetkaDetails(int sikId);

        List<ReshetkaSumDto> GetReshetkaSum(string administrativenRaion);

        int GetMaxNumber4Sik(string prmRegion);
    }
}
