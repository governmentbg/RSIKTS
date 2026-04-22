namespace Services.Implementations.Sik
{
    using Common.ViewModels.Raion;
    using Common.ViewModels.Sik;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Repository.Interfaces.Izbori;
    using Repository.Interfaces.Kvartali;
    using Repository.Interfaces.List;
    using Repository.Interfaces.NaseleniMesta;
    using Repository.Interfaces.Objini;
    using Repository.Interfaces.Oblasti;
    using Repository.Interfaces.Raion;
    using Repository.Interfaces.Sik;
    using Repository.Interfaces.Ulici;
    using Services.Interfaces.Sik;
    using System.Collections.Generic;
    using System.Linq;

    public class SikServices : ISikServices
    {
        readonly private ISikRepository _sikRepository;
        readonly private IRaionRepository _raionRepository;
        private readonly IUliciRepository _uliciRepository;
        private readonly IKvartaliRepository _kvartaliRepository;
        private readonly IOblastiRepository _oblastiRepository;
        private readonly IObjiniRepository _objiniRepository;
        private readonly INaseleniMestaRepository _naseleniMestaRepository;
        private readonly IListRepository _listRepository;
        private readonly IIzboriRepository _izboriRepository;


        public SikServices(ISikRepository sikRepository,
            IRaionRepository raionRepository,
            IUliciRepository uliciRepository, 
            IKvartaliRepository kvartaliRepository, 
            IOblastiRepository oblastiRepository, 
            IObjiniRepository objiniRepository, 
            INaseleniMestaRepository naseleniMestaRepository,
            IListRepository listRepository,
            IIzboriRepository izboriRepository
            )
        {
            _listRepository = listRepository;
            _raionRepository = raionRepository;
            _sikRepository = sikRepository;
            _uliciRepository = uliciRepository;
            _objiniRepository = objiniRepository;
            _oblastiRepository = oblastiRepository;
            _kvartaliRepository = kvartaliRepository;
            _naseleniMestaRepository = naseleniMestaRepository;
            _izboriRepository = izboriRepository;
        }

        public ICollection<SikBasicViewModel> GetAllSiks(int page, string sikFilter, string administrativenRaion)
        {
            return _sikRepository.GetAllSiks(page, sikFilter, administrativenRaion).Select(s => new SikBasicViewModel
            {
                IdSek = s.IdSek,
                Id = s.Id,
                Address = s.Address,
                Status = s.Status,
                Vid = s.Vid,
                Descript = s.Descript
            }).OrderBy(x=>x.Id).ToList();
        }

        public int GetMaxSikPages(string sikFilter, string administrativenRaion)
        {
            return _sikRepository.GetMaxSikPages(sikFilter, administrativenRaion);
        }

        public void TryDelete(int sikId, string userId)
        {
            _sikRepository.TryDelete(sikId, userId);
        }

        public void TryEditSik(SikEditViewModel editModel)
        {
            _sikRepository.TryEditSik(editModel);
        }

        public SikAddViewModel GetSikAddModel(string administrativenRaion, string naselenoMqstoKod)
        {
            var sikAddModel = new SikAddViewModel
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

                AllAdministrativniRaioni = _raionRepository.GetAllRaioni(administrativenRaion).Select(p => new SelectListItem
                {
                    Value = p.Id,
                    Text = p.Name
                }).ToList(),

                AllKvartali = _kvartaliRepository.GetAllKvartali().Select(p => new SelectListItem
                {
                    Value = p.Nkod,
                    Text = p.Nime
                }).ToList(),

                AllPriznaci = _listRepository.GetCodePositions(2).Select(c => new SelectListItem
                {
                    Value = c.Nkode.ToString(),
                    Text = c.Nime
                }).ToList(),

                AllVidove = _listRepository.GetCodePositions(1).Select(c => new SelectListItem
                {
                    Value = c.Nkode.ToString(),
                    Text = c.Nime
                }).ToList(),

                AllToaForPodvijnaSekciq = _raionRepository
                    .GetAdmninistrativniRaioniWithIzbirateliByIzbRaion(administrativenRaion)
                    .Select(p => new RaionForSikPodvijnaSekciqViewModel
                        {
                            Toa = p.Toa,
                            Ime = p.Ime,
                            Izbirateli = p.Izbirateli
                        })
                  .ToList(),
            };

            sikAddModel.AllNaseleniMesta.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });

            sikAddModel.AllVidove.ElementAt(0).Selected = true;

            sikAddModel.AllUlici = _uliciRepository.GetUliciByNaselenoMqsto(naselenoMqstoKod ?? sikAddModel.AllNaseleniMesta.ElementAt(0).Value).Select(p => new SelectListItem
            {
                Value = p.Nrec.ToString(),
                Text = p.Nime
            }).OrderBy(x=>x.Text).ToList();

            sikAddModel.AllUlici.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });

            sikAddModel.AllKvartali.Insert(0, new SelectListItem
            {
                Value = "0",
                Text = "Няма",
                Selected = true
            });

            return sikAddModel;
        }

        public SikEditViewModel GetSik(int sikId)
        {
            var sikEdit = _sikRepository.GetSik(sikId);

            var basickSikModel = GetSikAddModel(null, sikEdit.Kodnsm);

            sikEdit.AllOblasti = basickSikModel.AllOblasti;
            sikEdit.AllObjini = basickSikModel.AllObjini;
            sikEdit.AllAdministrativniRaioni = basickSikModel.AllAdministrativniRaioni;
            sikEdit.AllNaseleniMesta = basickSikModel.AllNaseleniMesta;
            sikEdit.AllUlici = basickSikModel.AllUlici;
            sikEdit.AllKvartali = basickSikModel.AllKvartali;
            sikEdit.AllVidove = basickSikModel.AllVidove;
            sikEdit.AllPriznaci = basickSikModel.AllPriznaci;
 
            sikEdit.AllNaseleniMesta[0].Selected = false;
            sikEdit.AllUlici[0].Selected = false;
            if (sikEdit.ULKOD != null)
                sikEdit.AllUlici.FirstOrDefault(u => u.Value == sikEdit.ULKOD).Selected = true;

            sikEdit.AllKvartali[0].Selected = false;

            return sikEdit;
        }

        public void TryAddSik(SikAddViewModel addModel)
        {
            _sikRepository.TryAddSik(addModel);
        }


        public ICollection<SikBasicViewModel> GetAllSiks()
        {
            return _sikRepository.GetAllSiks()
                                .Select(s => new SikBasicViewModel
                                        {
                                            IdSek = s.IdSek,
                                            Id = s.Id,
                                            Address = s.Address,
                                            Status = s.Status,
                                            Vid = s.Vid
                                        })
                                .OrderBy(x => x.Id)
                                .ToList();
        }


        public ICollection<SikBasicViewModel> GetSiksByAdministrativenRaion(string nkod)
        {
            return _sikRepository.GetSiksByAdministrativenRaion(nkod)
                                .Select(s => new SikBasicViewModel
                                    {
                                        IdSek = s.IdSek,
                                        Id = s.Id,
                                        Address = s.Address,
                                        Status = s.Status
                                    })
                                .OrderBy(x => x.Id)
                                .ToList();
        }

        public int isSikVidCalc(int Id)
        {
            return _sikRepository.isSikVidCalc(Id);
        }
    }
}
