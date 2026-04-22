namespace Services.Implementations.Raion
{
    using Common.ViewModels.Raion;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Repository.Interfaces.Kvartali;
    using Repository.Interfaces.NaseleniMesta;
    using Repository.Interfaces.Objini;
    using Repository.Interfaces.Oblasti;
    using Repository.Interfaces.Raion;
    using Repository.Interfaces.Ulici;
    using Services.Interfaces.Raion;
    using System.Collections.Generic;
    using System.Linq;

    public class RaionServices : IRaionServices
    {
        private readonly IRaionRepository _raionRepository;
        private readonly IUliciRepository _uliciRepository;
        private readonly IKvartaliRepository _kvartaliRepository;
        private readonly IOblastiRepository _oblastiRepository;
        private readonly IObjiniRepository _objiniRepository;
        private readonly INaseleniMestaRepository _naseleniMestaRepository;


        public RaionServices(IRaionRepository raionRepository, 
            IUliciRepository uliciRepository, 
            IKvartaliRepository kvartaliRepository, 
            IOblastiRepository oblastiRepository,
            IObjiniRepository objiniRepository, 
            INaseleniMestaRepository naseleniMestaRepository)
        {
            _raionRepository = raionRepository;
            _uliciRepository = uliciRepository;
            _objiniRepository = objiniRepository;
            _oblastiRepository = oblastiRepository;
            _kvartaliRepository = kvartaliRepository;
            _naseleniMestaRepository = naseleniMestaRepository;

        }

        public ICollection<RaionViewModel> GetAllRaioni(string administrativenRaion = null)
        {
            return _raionRepository.GetAllRaioni(administrativenRaion).Select(r => new RaionViewModel
            {
                Id = r.Id,
                Name = r.Name
            }).ToList();
        }

        public int GetMaxRaioniMainPagesByUser(string userId, int page, string toaId)
        {
            return _raionRepository.GetMaxRaioniMainPagesByUser(userId, page, toaId);
        }

        public ICollection<RaionMainViewModel> GetMainRaioniByUserAndPage(string userId, int page, string toaId)
        {
            return _raionRepository.GetMainRaioniByUserAndPage(userId, page, toaId).Select(r => new RaionMainViewModel
            {
                Nrec = r.Nrec,
                ToaId = r.ToaId,
                Name = r.Name
            }).ToList();
        }

        public void DeleteRaionMainById(int raionMainId)
        {
            _raionRepository.DeleteRaionMainById(raionMainId);
        }

        public RaionAddViewModel GetRaionAddViewModel(string administrativenRaion)
        {
            var raionAddModel = new RaionAddViewModel
            {
                AllObjini = _objiniRepository.GetAllObjini().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),

                AllOblasti = _oblastiRepository.GetAllOblasti().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),

                AllNaseleniMesta = _naseleniMestaRepository.GetAllNaseleniMesta().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),

                AllAdministrativniRaioni = GetAllRaioni(administrativenRaion).Select(p => new SelectListItem
                {
                    Value = p.Id,
                    Text = p.Name
                }).ToList(),

                AllKvartali = _kvartaliRepository.GetAllKvartali().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),           
            };

            raionAddModel.AllNaseleniMesta.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });

            raionAddModel.AllUlici = _uliciRepository.GetUliciByNaselenoMqsto(raionAddModel.AllNaseleniMesta.ElementAt(0).Value).Select(p => new SelectListItem
            {
                Value = p.Nrec.ToString(),
                Text = p.Nime
            }).ToList();

            raionAddModel.AllUlici.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });

            raionAddModel.AllKvartali.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });

            return raionAddModel;
        }

        public RaionAddViewModel GetRaionMain(string administrativenRaion)
        {
            var raionMain = _raionRepository.GetRaionMain(administrativenRaion);

            raionMain.AllAdministrativniRaioni = GetAllRaioni(administrativenRaion).Select(p => new SelectListItem
            {
                Value = p.Id,
                Text = p.Name
            }).ToList();

            var oblast = _oblastiRepository.GetOblast(raionMain.Oblast);

            raionMain.AllOblasti = new List<SelectListItem>()
            {
                new SelectListItem
                {
                    Text = oblast.Nime,
                    Value = oblast.Nkod
                }
            };

            var objina = _objiniRepository.GetObjina(raionMain.Objina);

            raionMain.AllObjini = new List<SelectListItem>()
            {
                new SelectListItem
                {
                    Text = objina.Nime,
                    Value = objina.Nkod
                }
            };

            raionMain.AllNaseleniMesta = _naseleniMestaRepository.GetAllNaseleniMesta().Select(p => new SelectListItem
            {
                Value = p.Nkod,
                Text = p.Nime
            }).ToList();

            raionMain.AllKvartali = _kvartaliRepository.GetAllKvartali().Select(p => new SelectListItem
            {
                Value = p.Nkod,
                Text = p.Nime
            }).ToList();

            raionMain.AllUlici = _uliciRepository.GetUliciByNaselenoMqsto(raionMain.NaselenoMqsto).Select(p => new SelectListItem
            {
                Value = p.Nrec.ToString(),
                Text = p.Nime
            }).ToList();

            raionMain.AllNaseleniMesta.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
            });

            raionMain.AllUlici.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
            });

            raionMain.AllKvartali = _kvartaliRepository.GetAllKvartali().Select(p => new SelectListItem
            {
                Value = p.Nkod,
                Text = p.Nime
            }).ToList();

            raionMain.AllKvartali.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
            });

            return raionMain;
        }

        public void AddRaionMain(RaionAddViewModel newRaion, string userId)
        {
            _raionRepository.AddRaionMain(newRaion, userId);
        }

        public void EditRaionMain(RaionAddViewModel editRaion, string userId)
        {
            _raionRepository.EditRaionMain(editRaion, userId);
        }

        public ICollection<AdministrativenRaionViewModel> GetAdmninistrativniRaioniByIzbRaion(string nkod)
        {
            return _raionRepository.GetAdmninistrativniRaioniByIzbRaion(nkod).Select(a => new AdministrativenRaionViewModel
            {
                Nkod = a.Nkod,
                Nime = a.Nime
            }).ToList();
        }

        public int RegionHasBulstat(string nkod) => _raionRepository.RegionHasBulstat(nkod);

        public int GetIzbRaionMinBroiSikByNime(string nime) => _raionRepository.GetIzbRaionMinBroiSikByNime(nime);

        public int GetIzbRaionMaxBroiSikByNime(string nime) => _raionRepository.GetIzbRaionMaxBroiSikByNime(nime);

        public string GetAdministrativenRaionIzbRaionNime(int nrec) => _raionRepository.GetAdministrativenRaionIzbRaionNime(nrec);

        public int GetIzbRaionMinBroiSikByNkod(string nkod) => _raionRepository.GetIzbRaionMinBroiSikByNkod(nkod);

        public int GetIzbRaionMaxBroiSikByNkod(string nkod) => _raionRepository.GetIzbRaionMaxBroiSikByNkod(nkod);

        public int GetAdministrativenRaionChlenove(string nkod) => _raionRepository.GetAdministrativenRaionChlenove(nkod);

        public string GetIzbRaion(string toa) => _raionRepository.GetIzbRaion(toa);
    }
}
