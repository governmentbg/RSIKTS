using Common.ViewModels.Izbori;
using Common.ViewModels.Obrabotki;
using System;
using System.Collections.Generic;
using System.Text;

namespace Services.Interfaces.Izbori
{
    public interface IIzboriServices
    {
        string GetIzborAlias();

        DateTime GetIzborDate();

        DateTime GetIzborEndDate();

        string GetIzborDescription();

        string getIzborTur();

        void StartNewIzbor(string userId, AdminOptionsFilter filter);

        ICollection<IzborTipViewModel> GetTipIzbori();

        int GetIzborMaxTUR();

        int GetIzborMaxTURByNkod(string nkod);

        void DeleteDatabase(string userId);

        void NewIzborTur(string userId);

        int getIzborCurrentTur();

        string GetIzborDescriptionWithoutTur();

        string GetTurBeginDate(int tur);
        string GetTurEndDate(int tur);

        string GetCode(string pCode);
    }
}
