namespace Services.Implementations.Kvoti
{
    using Common.ViewModels.Kvoti;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Repository.Interfaces.Kvoti;
    using Repository.Interfaces.Partiq;
    using Services.Interfaces.Kvoti;
    using System.Collections.Generic;
    using System.Linq;

    public class KvotiServices : IKvotiServices
    {
        private readonly IKvotiRepository _kvotiRepository;
        private readonly IPartiqRepository _partiiRepository;

        public KvotiServices(IKvotiRepository kvotiRepository, IPartiqRepository partiiRepository)
        {
            _partiiRepository = partiiRepository;
            _kvotiRepository = kvotiRepository;
        }

        public ICollection<KvotiViewModel> AllKvoti(string administrativenRaion)
        {
            return _kvotiRepository.AllKvoti(administrativenRaion).Select(k => new KvotiViewModel
            {
                Id = k.Id,
                PoliticheskaSila = k.PoliticheskaSila,
                Total = k.Total,
                Precedatel = k.Precedatel,
                ZamestnikPrecedatel = k.ZamestnikPrecedatel,
                Sekretar = k.Sekretar,
                Chlenove = k.Chlenove
            }).ToList();
        }

        public void EditKvota(KvotiEditViewModel kvota, string administrativenRaion, string userId)
        {
            _kvotiRepository.EditKvota(kvota, administrativenRaion, userId);
        }

        public KvotiEditViewModel GetKvotaById(string id, string administrativenRaion)
        {
            return _kvotiRepository.GetKvotaById(id, administrativenRaion);
        }

        public List<ReshetkaViewModel> GetReshetkaInfo(string administrativenRaion)
        {
            return _kvotiRepository.GetReshetkaInfo(administrativenRaion).Select(r => new ReshetkaViewModel
            {
                Id = r.Id,
                PrecedatelPartiq = r.PrecedatelPartiq,
                ZamestnikPrecedatelPartiq = r.ZamestnikPrecedatelPartiq,
                SekretarPartiq = r.SekretarPartiq,
                Chlen1Partiq = r.Chlen1Partiq,
                Chlen2Partiq = r.Chlen2Partiq,
                Chlen3Partiq = r.Chlen3Partiq,
                Chlen4Partiq = r.Chlen4Partiq,
                Chlen5Partiq = r.Chlen5Partiq,
                Chlen6Partiq = r.Chlen6Partiq,
                SikFullCode = r.SikFullCode
            }).ToList();
        }

        public ReshetkaEditViewModel GetReshetkaEditById(int sikId)
        {
            var reshetkaEdit = _kvotiRepository.GetReshetkaEdit(sikId);

            reshetkaEdit.AllPoliticheskiSili = _partiiRepository.GetAllParti().Select(p => new SelectListItem
            {
                Value = p.Code,
                Text = p.Name
            }).ToList();

            reshetkaEdit.AllPoliticheskiSili.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма"
            });

            return reshetkaEdit;
        }

        public void EditReshetka(ReshetkaEditViewModel model, string administrativenRaion, string user)
        {
            _kvotiRepository.EditReshetka(model, administrativenRaion, user);
        }

        public List<ReshetkaDetailsViewModel> GetReshetkaDetails(int sikId)
        {
            return _kvotiRepository.GetReshetkaDetails(sikId).Select(r => new ReshetkaDetailsViewModel
            {
                Nkod = r.Nkod,
                Nime = r.Nime,
                BroiRukChlenove = r.BroiRukChlenove,
                Objo = r.Objo
            }).ToList();
        }

        public List<ReshetkaSumViewModel> GetReshetkaSum(string administrativenRaion)
        {
            return _kvotiRepository.GetReshetkaSum(administrativenRaion).Select(r => new ReshetkaSumViewModel
            {
                Nime = r.Nime,
                PrecedatelCount = r.PrecedatelCount,
                PrecedatelMax = r.PrecedatelMax,
                ZamestnikPrecedatelCount = r.ZamestnikPrecedatelCount,
                ZamestnikPrecedatelMax = r.ZamestnikPrecedatelMax,
                SekretarCount = r.SekretarCount,
                SekretarMax = r.SekretarMax,
                ChlenCount = r.ChlenCount,
                ChlenMax = r.ChlenMax
            }).ToList();
        }

        public int GetMaxNumber4Sik(string prmRegion)
        {
            return _kvotiRepository.GetMaxNumber4Sik(prmRegion);
        }

        public string GetPartiaById(string silaId)
        {
            var partia = _partiiRepository.GetAllParti().Where(s=>s.Code == silaId).FirstOrDefault().Name;
            return partia;
        }

    }
}
