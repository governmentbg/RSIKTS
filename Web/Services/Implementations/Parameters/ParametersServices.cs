namespace Services.Implementations.Parameters
{
    using Common.ViewModels.Parameters;
    using Repository.Interfaces.Parameters;
    using Services.Interfaces.Parameters;
    using System.Collections.Generic;
    using System.Linq;

    public class ParametersServices : IParametersServices
    {
        private readonly IParametersRepository _parametersRepository;

        public ParametersServices(IParametersRepository parametersRepository)
        {
            _parametersRepository = parametersRepository;
        }

        public void EditParameter(ParametersViewModel parameter)
        {
            _parametersRepository.EditParameter(parameter);  
        }

        public ICollection<ParametersViewModel> GetAllParametersByIzbor(string IzbAlias)
        {
            return _parametersRepository.GetAllParametersByIzbor(IzbAlias).Select(p => new ParametersViewModel {
                Kod = p.Kod,
                Opisanie = p.Opisanie,
                Znachenie = p.Znachenie,
                Status = p.Status
            }).ToList();
        }

        public ParametersViewModel GetParameterByKod(string kod)
        {
            var parameterDto = _parametersRepository.GetParameterByKod(kod);

            return new ParametersViewModel
            {
                Kod = parameterDto.Kod,
                Opisanie = parameterDto.Opisanie,
                Znachenie = parameterDto.Znachenie,
                Status = parameterDto.Status
            };
        }

        
        public ICollection<IzbRajonParamViewModel> GetIzbRajonParameters(string IzbAlias)
        {
            return _parametersRepository.GetIzbRajonParameters(IzbAlias).Select(p => new IzbRajonParamViewModel
            {
                Nkod = p.NKod,
                NIme = p.NIme,
                MinMembers = p.MinMembers,
                MaxMembers = p.MaxMembers,
                Status = p.Status
            }).ToList();
        }


        public IzbRajonParamViewModel GetIzbRajonParametersByKod(string kod)
        {
            var parameterDto = _parametersRepository.GetIzbRajonParametersByKod(kod);

            return new IzbRajonParamViewModel
            {
                Nkod = parameterDto.NKod,
                NIme = parameterDto.NIme,
                MinMembers = parameterDto.MinMembers,
                MaxMembers = parameterDto.MaxMembers,
                Status = parameterDto.Status
            };
        }

        public void EditIzbRajonParameter(IzbRajonParamViewModel parameter)
        {
            _parametersRepository.EditIzbRajonParameter(parameter);
        }

        public ICollection<NomenclaturesViewModel> GetNomenclatures()
        {
            return _parametersRepository.GetNomenclatures()
                        .Select(p => new NomenclaturesViewModel
                        {
                            Id = p.Id,
                            Description = p.Description,
                            Tip = p.Tip,
                            Status = (p.Status==1)
                        }).ToList();

        }
        public NomenclaturesViewModel GetNomenclatureByKod(int Kod)
        {
            var nomenclature = _parametersRepository.GetNomenclatureByKod(Kod);

            return new NomenclaturesViewModel
            {
                Id = nomenclature.Id,
                Description = nomenclature.Description,
                Tip = nomenclature.Tip,
                Status = nomenclature.Status ==1
            };
        }

        public void EditNomenclature(NomenclaturesViewModel parameter)
        {
            _parametersRepository.EditNomenclature(parameter);
        }

        
        public IzbDateViewModel GetNTopMain()
        {
            var nomenclature = _parametersRepository.GetNTopMain();

            return new IzbDateViewModel
            {
                Id = nomenclature.Id,
                Naimenovanie = nomenclature.Description,
                DateTur1 = nomenclature.Date1Tur,
                DateTur2 = nomenclature.Date2Tur
            };
        }
        public void EditNTopMain(IzbDateViewModel parameter)
        {
            _parametersRepository.EditNTopMain(parameter);
        }

    }
}
