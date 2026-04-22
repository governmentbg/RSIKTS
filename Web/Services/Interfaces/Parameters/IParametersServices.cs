namespace Services.Interfaces.Parameters
{
    using Common.ViewModels.Parameters;
    using System.Collections.Generic;

    public interface IParametersServices
    {
        ICollection<ParametersViewModel> GetAllParametersByIzbor(string IzbAlias);

        ParametersViewModel GetParameterByKod(string Kod);

        void EditParameter(ParametersViewModel parameter);

        ICollection<IzbRajonParamViewModel> GetIzbRajonParameters(string IzbAlias);

        IzbRajonParamViewModel GetIzbRajonParametersByKod(string kod);

        void EditIzbRajonParameter(IzbRajonParamViewModel parameter);

        ICollection<NomenclaturesViewModel> GetNomenclatures();
//v.2
        NomenclaturesViewModel GetNomenclatureByKod(int Kod);
        void EditNomenclature(NomenclaturesViewModel parameter);

        IzbDateViewModel GetNTopMain();

        void EditNTopMain(IzbDateViewModel parameter);
    }
}
