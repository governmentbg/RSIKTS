namespace Repository.Interfaces.Parameters
{
    using Common.ViewModels.Parameters;
    using DTO.Parameters;
    using System.Collections.Generic;

    public interface IParametersRepository
    {
        ICollection<ParametersDto> GetAllParametersByIzbor(string IzbAlias);

        ParametersDto GetParameterByKod(string kod);
        void EditParameter(ParametersViewModel parameter);
        ICollection<IzbRajonParametersDto> GetIzbRajonParameters(string IzbAlias);

        IzbRajonParametersDto GetIzbRajonParametersByKod(string kod);

        void EditIzbRajonParameter(IzbRajonParamViewModel parameter);

        ICollection<NomenclaturesDto> GetNomenclatures();

        //v.2
        NomenclaturesDto GetNomenclatureByKod(int Kod);
        void EditNomenclature(NomenclaturesViewModel parameter);

        NTopMainDto GetNTopMain();
        void EditNTopMain(IzbDateViewModel parameter);
    }
}
