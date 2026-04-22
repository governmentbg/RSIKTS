namespace Repository.Implementations.Izbori
{
    using Common.ViewModels.Obrabotki;
    using DataAccess;
    using DTO.Izbori;
    using Microsoft.EntityFrameworkCore;
    using Repository.Interfaces.Izbori;
    using System;
    using System.Collections.Generic;
    using System.Linq;

    public class IzboriRepository : IIzboriRepository
    {
        private readonly VotingRegisterContext _context;

        public IzboriRepository(VotingRegisterContext context)
        {
            _context = context;
        }

        public string GetIzborAlias()
        {
            return _context.NTopMain.FirstOrDefault(m => m.StatusParameters == 1).IzbAlias;
        }

        public string GetIzborDescriptionWithoutTur()
        {
            string desc = _context.NTopMain.FirstOrDefault(m => m.StatusParameters == 1).Description;
            string dbtype = getDbType();
            string dbtour = "";

            return desc +
                    (!string.IsNullOrEmpty(dbtour) ? " - " + dbtour : "") +
                    (!string.IsNullOrEmpty(dbtype) ? " (" + dbtype + ")" : "");
        }

        public string GetIzborDescription()
        {
            string desc = _context.NTopMain.FirstOrDefault(m => m.StatusParameters == 1).Description;
            string dbtype = getDbType();
            string dbtour = "";

            if (GetIzborMaxTUR() == 2)
            {
                dbtour = "Тур " + GetIzborTUR();
            }

            return desc +
                    (!string.IsNullOrEmpty(dbtour) ? " - " + dbtour : "") +
                    (!string.IsNullOrEmpty(dbtype) ? " (" + dbtype + ")" : "");
        }

        public DateTime GetIzborDate()
        {
            return _context.NTopMain.FirstOrDefault(m => m.StatusParameters == 1).Date1tur ?? new DateTime();
        }

        public DateTime GetIzborEndDate()
        {
            return _context.NTopMain.FirstOrDefault(m => m.StatusParameters == 1).Date2tur ?? new DateTime();
        }

        public int GetIzborTUR()
        {
            return Convert.ToInt32(_context.SysMains.FirstOrDefault(m => m.Name == "TUR").Value);
        }

        public string getDbType()
        {
            return _context.SysMains.FirstOrDefault(m => m.Name == "DB").Value;
        }

        public ICollection<IzborTipDto> GetTipIzbori()
        {
            return _context.WnTipIzbori.Select(i => new IzborTipDto
            {
                Id = i.Id,
                Nime = i.Nime,
                Nkod = i.Nkod,
                Tur = i.Tur,
                Status = i.Status
            }).ToList();
        }

        public int GetIzborMaxTUR()
        {
            var data = _context.IdReturnSet.FromSql("CALL getMaxTur4Izbori()").FirstOrDefault();
            return data.Id;
        }

        public void StartNewIzbor(string userId, AdminOptionsFilter filter)
        {
            _context.Database.ExecuteSqlCommand("CALL createNewElection(@p0,@p1,@p2,@p3,@p4)", userId, filter.Tip, filter.Naimenovanie, filter.DateTur1, filter.DateTur2);
        }

        public void DeleteDatabase(string userId)
        {
            _context.Database.ExecuteSqlCommand("CALL createNewTurOrElection(@p0,@p1,@p2)", userId, GetIzborAlias(), -1);
        }

        public void NewIzborTur(string userId)
        {
            _context.Database.ExecuteSqlCommand("CALL createNewTurOrElection(@p0,@p1,@p2)", userId, GetIzborAlias(), GetIzborTUR());
        }

        public int GetIzborMaxTURByNkod(string nkod)
        {
            return _context.WnTipIzbori.FirstOrDefault(i => i.Nkod == nkod).Tur;
        }

        public string GetTurBeginDate(int tur)
        {
            string cdate;
            if (tur == 1)
                cdate = _context.NTopParameters
                                .Where(s => s.Kod == "52")
                                .FirstOrDefault(m => m.StatusParameters == 1).Znachenie;
            else
                cdate = _context.NTopParameters
                                .Where(s => s.Kod == "54")
                                .FirstOrDefault(m => m.StatusParameters == 1).Znachenie;

            return cdate;
        }

        public string GetTurEndDate(int tur)
        {
            string cdate;
            if (tur == 1)
                cdate = _context.NTopParameters
                                .Where(s => s.Kod == "53")
                                .FirstOrDefault(m => m.StatusParameters == 1).Znachenie;
            else
                cdate = _context.NTopParameters
                                .Where(s => s.Kod == "55")
                                .FirstOrDefault(m => m.StatusParameters == 1).Znachenie;

            return cdate;
        }


        public string GetCode(string pCode)
        {
            string cval = _context.NTopParameters
                                .Where(s => s.Kod == pCode)
                                .FirstOrDefault(m => m.StatusParameters == 1).Znachenie;
            return cval;
        }
    }
}
