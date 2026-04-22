namespace Repository.Implementations.Parameters
{
    using Common.ViewModels.Parameters;
    using DataAccess;
    using DTO.Parameters;
    using Repository.Interfaces.Parameters;
    using System;
    using System.Collections.Generic;
    using System.Linq;

    public class ParametersRepository : IParametersRepository
    {
        private readonly VotingRegisterContext _context;

        public ParametersRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public void EditParameter(ParametersViewModel parameter)
        {
            var parameterEntity = _context.NTopParameters.FirstOrDefault(p => p.Kod == parameter.Kod);

            parameterEntity.Znachenie = parameter.Znachenie;
            parameterEntity.StatusParameters = Convert.ToInt32(parameter.Status);
            parameterEntity.Description = parameter.Opisanie;

            _context.SaveChanges();
        }

        public ICollection<ParametersDto> GetAllParametersByIzbor(string IzbAlias)
        {
            return _context.NTopParameters.Where(p => p.IzbAlias == IzbAlias).Select(p => new ParametersDto
            {
                Kod = p.Kod,
                Opisanie = p.Description,
                Znachenie = p.Znachenie,
                Status = Convert.ToBoolean(p.StatusParameters ?? 0)
            }).ToList();
        }

        public ParametersDto GetParameterByKod(string kod)
        {
            return _context.NTopParameters.Select(p => new ParametersDto
            {
                Kod = p.Kod,
                Opisanie = p.Description,
                Znachenie = p.Znachenie,
                Status = Convert.ToBoolean(p.StatusParameters ?? 0)
            }).FirstOrDefault(p => p.Kod == kod);
        }

        public ICollection<IzbRajonParametersDto> GetIzbRajonParameters(string IzbAlias)
        {
            return _context.WnIzbRaion
                            .Where(p => p.Izb_Alias == IzbAlias && p.Status == 1)
                            .Select(p => new IzbRajonParametersDto
                                            {
                                                NKod = p.Nkod,
                                                NIme = p.Nime,
                                                MinMembers = p.Min_Broi_Sik,
                                                MaxMembers = p.Max_Broi_Sik,
                                                Status =p.Status
                                            }).ToList();

        }

        public IzbRajonParametersDto GetIzbRajonParametersByKod(string kod)
        {
            return _context.WnIzbRaion.Select(p => new IzbRajonParametersDto
            {
                NKod = p.Nkod,
                NIme = p.Nime,
                MinMembers = p.Min_Broi_Sik,
                MaxMembers = p.Max_Broi_Sik,
                Status = p.Status
            }).FirstOrDefault(p => p.NKod == kod);
        }


        public void EditIzbRajonParameter(IzbRajonParamViewModel parameter)
        {
            var parameterEntity = _context.WnIzbRaion.FirstOrDefault(p => p.Nkod == parameter.Nkod);

            parameterEntity.Min_Broi_Sik = parameter.MinMembers;
            parameterEntity.Max_Broi_Sik = parameter.MaxMembers;

            _context.SaveChanges();
        }

        //v.2
        public ICollection<NomenclaturesDto> GetNomenclatures()
        {
            return _context.NNomenclatures
                .Where (p => p.Tip < 2)
                .Select(p => new NomenclaturesDto
                    {
                        Id = p.Id,
                        Description = p.Description,
                        Tip = p.Tip,
                        Status = (int)p.Status
                    }).ToList();
        }

        public NomenclaturesDto GetNomenclatureByKod(int Kod)
        {
            return _context.NNomenclatures.Select(p => new NomenclaturesDto
            {
                Id = p.Id,
                Description = p.Description,
                Tip = p.Tip,
                Status = (int)p.Status
            }).FirstOrDefault(p => p.Id == Kod);
        }

    
        public void EditNomenclature(NomenclaturesViewModel parameter)
        {
            var parameterEntity = _context.NNomenclatures.FirstOrDefault(p => p.Id == parameter.Id);

            parameterEntity.Tip = parameter.Tip;
            parameterEntity.Status = (short)Convert.ToInt32(parameter.Status);
            parameterEntity.Description = parameter.Description;

            _context.SaveChanges();
        }

        public NTopMainDto GetNTopMain()
        {
            return _context.NTopMain.Select(p => new NTopMainDto
            {
                Id = p.Id,
                Description = p.Description,
                Date1Tur = (DateTime)(p.Date1tur),
                Date2Tur = (DateTime)(p.Date2tur)
            }).FirstOrDefault();
        }

        public void EditNTopMain(IzbDateViewModel parameter)
        {
            var parameterEntity = _context.NTopMain.FirstOrDefault();

            parameterEntity.Description = parameter.Naimenovanie;
            parameterEntity.Date1tur = parameter.DateTur1;
            parameterEntity.Date2tur = parameter.DateTur2;

            _context.SaveChanges();
        }
    }
}
