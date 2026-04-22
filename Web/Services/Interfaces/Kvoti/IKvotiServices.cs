namespace Services.Interfaces.Kvoti
{
    using Common.ViewModels.Kvoti;
    using System.Collections.Generic;

    public interface IKvotiServices
    {
        ICollection<KvotiViewModel> AllKvoti(string administrativenRaion);

        KvotiEditViewModel GetKvotaById(string id, string administrativenRaion);

        void EditKvota(KvotiEditViewModel kvota, string administrativenRaion, string userId);

        List<ReshetkaViewModel> GetReshetkaInfo(string administrativenRaion);

        ReshetkaEditViewModel GetReshetkaEditById(int sikId);

        void EditReshetka(ReshetkaEditViewModel model, string administrativenRaion, string user);

        List<ReshetkaDetailsViewModel> GetReshetkaDetails(int sikId);

        List<ReshetkaSumViewModel> GetReshetkaSum(string administrativenRaion);

        int GetMaxNumber4Sik(string prmRegion);

        string GetPartiaById(string silaId);
    }
}
