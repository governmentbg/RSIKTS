using Common.ViewModels.Obrabotki;
using DTO.Izbori;
using System;
using System.Collections.Generic;

namespace Repository.Interfaces.Izbori
{
    public interface IIzboriRepository
    {
        string GetIzborAlias();

        string GetIzborDescription();

        DateTime GetIzborDate();

        DateTime GetIzborEndDate();

        int GetIzborTUR();

        int GetIzborMaxTUR();

        int GetIzborMaxTURByNkod(string nkod);

        string getDbType();

        ICollection<IzborTipDto> GetTipIzbori();

        void StartNewIzbor(string userId, AdminOptionsFilter filter);

        void DeleteDatabase(string userId);

        void NewIzborTur(string userId);

        string GetIzborDescriptionWithoutTur();

        string GetTurBeginDate(int tur);
        string GetTurEndDate(int tur);

        string GetCode(string pCode);

    }
}
