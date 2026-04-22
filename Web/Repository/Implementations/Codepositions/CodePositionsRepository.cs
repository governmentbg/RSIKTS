namespace Repository.Implementations.Codepositions
{
    using Common.ViewModels.List;
    using DataAccess;
    using DTO.Codepositions;
    using Repository.Interfaces.Codepositions;
    using Repository.Interfaces.Izbori;
    using System;
    using System.Collections.Generic;
    using System.Linq;

    public class CodePositionsRepository : ICodePositionsRepository
    {
        private readonly VotingRegisterContext _context;
        private readonly IIzboriRepository _izboriRepository;

        public CodePositionsRepository(VotingRegisterContext context, IIzboriRepository izboriRepository)
        {
            _izboriRepository = izboriRepository;
            _context = context;
        }

        public ICollection<CodePositionDto> GetAllCodePositions()
        {
            return _context.NListCodepositions.Where(n => n.Status == 1).Select(c => new CodePositionDto
            {
                Id = c.Id,
                Pkode = c.Pkode,
                Nime = c.Nime,
                Nkode = c.Nkode
            }).OrderBy (c=>c.Nkode)
              .ToList();
        }

        public ICollection<CodePositionDto> GetAllCodePositionsByPkode(int pKode)
        {
            return _context.NListCodepositions.Where(c => c.Pkode == pKode && c.Status == 1).Select(c => new CodePositionDto
            {
                Id = c.Id,
                Pkode = c.Pkode,
                Nime = c.Nime,
                Nkode = c.Nkode
            }).OrderBy(c => c.Nkode)
            .ToList();
        }

        public ICollection<CodePositionWithMoneyDto> GetCodePositionsAndOperacii(int tur)
        {
            var codePositionsWithMoney = (
                    from p in _context.NListCodepositions
                    join c in _context.NormiOperacii
                        on new {  p1 = p.Nkode, p2 = true }
                        equals new { p1 = c.Idcodeposition, p2 = c.Tur == tur }
                        into normi_tbl
                    from n in normi_tbl.DefaultIfEmpty()
                    where p.Pkode == 3
                    select new CodePositionWithMoneyDto
                    {
                        Id = p.Id,
                        Nkode = p.Nkode,
                        Pkode = p.Pkode,
                        Nime = p.Nime,
                        Status = (n.Status == null ? 0 : n.Status) > 0 ? true : false,
                        Money = n.Pari == null ? 0 : n.Pari
                    })
                    .OrderBy(s=>s.Nkode)
                    .ToList();

            return codePositionsWithMoney;
        }

        public ICollection<CodePositionWithMoneyDto> GetCodePositionsAndPriznaci(int tur)
        {

           var codePositionsWithMoney = (
                   from p in _context.NListCodepositions
                   join c in _context.NormiPriznaci
                       on new { p1 = p.Nkode, p2 = true }
                       equals new { p1 = c.Idcodeposition, p2 = c.Tur == tur }
                       into normi_tbl
                   from n in normi_tbl.DefaultIfEmpty()
                   where p.Pkode == 2
                   select new CodePositionWithMoneyDto
                   {
                       Id = p.Id,
                       Nkode = p.Nkode,
                       Pkode = p.Pkode,
                       Nime = p.Nime,
                       Status = (n.Status == null ? 0 : n.Status) > 0 ? true : false,
                       Money = n.Pari == null ? 0 : n.Pari
                   })
                   .OrderBy(s => s.Nkode)
                   .ToList();

            return codePositionsWithMoney;
            
        }

        public ICollection<NormiRoliWithMoneyViewModel> GetCodePositionsAndRoliBySilaAndTur(int silaId, int tur)
        {
            var codePositionsWithMoney = (
                         from p in _context.NListCodepositions
                         join c in _context.NormiRoli
                             on new { p0 = p.Pkode, p1 = p.Nkode, p2 = true, p3=true }
                             equals new { p0 = c.VidCodetable, p1 = c.Idcodeposition, p2 = c.Tur == tur, p3=c.Idcodeposition_1 == silaId }
                             into normi_tbl
                         from n in normi_tbl.DefaultIfEmpty()
                         where p.Pkode == 4 && p.Nkode <= 409
                         select new NormiRoliWithMoneyViewModel
                         {
                             Id = p.Id,
                             Nkode = p.Nkode,
                             Pkode = p.Pkode,
                             Nime = p.Nime,
                             Status = (n.Status == null ? 0 : n.Status) > 0 ? true : false,
                             Money = n.Pari == null ? 0 : n.Pari,
                             SilaId = silaId
                         })
                         .OrderBy(s => s.Nkode)
                         .ToList();

            return codePositionsWithMoney;
        }

        public CodePositionWithMoneyDto GetCodePositionWithMoneyByIdAndTur(int normaId, int tur)
        {
            var codePosition = _context.NListCodepositions.FirstOrDefault(c => c.Id == normaId);

            if (codePosition.Pkode == 2)
            {

                var norma = _context.NormiPriznaci.FirstOrDefault(p => codePosition.Nkode == p.Idcodeposition && p.Tur == tur);

                return new CodePositionWithMoneyDto
                {
                    Id = codePosition.Id,
                    Nkode = codePosition.Nkode,
                    Pkode = codePosition.Pkode,
                    Nime = codePosition.Nime,
                    Status = (norma == null ? 0 : norma.Status) > 0 ? true : false,
                    Money = norma == null ? 0 : norma.Pari
                };
            }

            else if (codePosition.Pkode == 3)
            {

                var norma = _context.NormiOperacii.FirstOrDefault(p => codePosition.Nkode == p.Idcodeposition && p.Tur == tur);

                return new CodePositionWithMoneyDto
                {
                    Id = codePosition.Id,
                    Nkode = codePosition.Nkode,
                    Pkode = codePosition.Pkode,
                    Nime = codePosition.Nime,
                    Status = (norma == null ? 0 : norma.Status) > 0 ? true : false,
                    Money = norma == null ? 0 : norma.Pari
                };
            }

            else
            {
                var norma = _context.NormiRoli.FirstOrDefault(p => codePosition.Nkode == p.Idcodeposition);

                return new CodePositionWithMoneyDto
                {
                    Id = codePosition.Id,
                    Nkode = codePosition.Nkode,
                    Pkode = codePosition.Pkode,
                    Nime = codePosition.Nime,
                    Status = (norma == null ? 0 : norma.Status) > 0 ? true : false,
                    Money = norma == null ? 0 : norma.Pari
                };
            }
        }

        public NormiRoliWithMoneyDto GetNormaRoliWithMoneyByIdSilaAndTur(int normaId, int silaId, int tur)
        {
            var codePosition = _context.NListCodepositions.FirstOrDefault(c => c.Id == normaId);

            var norma = _context.NormiRoli.FirstOrDefault(p => codePosition.Nkode == p.Idcodeposition && p.Idcodeposition_1 == silaId && p.Tur == tur);

            return new NormiRoliWithMoneyDto
            {
                Id = codePosition.Id,
                Nkode = codePosition.Nkode,
                Pkode = codePosition.Pkode,
                Nime = codePosition.Nime,
                Status = (norma == null ? 0 : norma.Status) > 0 ? true : false,
                Money = norma == null ? 0 : norma.Pari,
                SilaId = silaId,
                Tur = tur
            };
            
        }

        public void TryEditNorma(CodePositionsWithMoneyViewModel editModel)
        {
            var codePosition = _context.NListCodepositions.FirstOrDefault(c => c.Id == editModel.Id);

          //  codePosition.Status = Convert.ToInt32(editModel.Status);

            if (codePosition.Pkode == 2)
            {

                var norma = _context.NormiPriznaci.FirstOrDefault(n => n.Idcodeposition == editModel.Nkode && n.Tur == editModel.Tur);

                if (norma != null)
                {
                    _context.NormiPriznaci.Remove(norma);
                    _context.SaveChanges();
                }

                var newNorma = new NormiPriznaci
                {
                    Id = _context.NormiPriznaci.LastOrDefault() == null ? 1 : _context.NormiPriznaci.LastOrDefault().Id + 1,
                    Idcodeposition = editModel.Nkode,
                    VidCodetable = editModel.Pkode,
                    Pari = editModel.Money,
                    IzbAllias = _izboriRepository.GetIzborAlias(),
                    Tur = editModel.Tur,
                    Status = Convert.ToInt32(editModel.Status),
                    User = editModel.User,
                    Koga = editModel.Koga
                };



                _context.NormiPriznaci.Add(newNorma);

                _context.SaveChanges();
            }

            else if (codePosition.Pkode == 3)
            {
                var norma = _context.NormiOperacii.FirstOrDefault(n => n.Idcodeposition == editModel.Nkode && n.Tur == editModel.Tur);

                if (norma != null)
                {
                    _context.NormiOperacii.Remove(norma);
                }

                var newNorma = new NormiOperacii
                {
                    Id = _context.NormiOperacii.LastOrDefault() == null ? 1 : _context.NormiOperacii.LastOrDefault().Id + 1,
                    Idcodeposition = editModel.Nkode,
                    VidCodetable = editModel.Pkode.ToString(),
                    Pari = editModel.Money,
                    IzbAllias = _izboriRepository.GetIzborAlias(),
                    Tur = editModel.Tur,
                    Status = Convert.ToInt32(editModel.Status),
                    User = editModel.User,
                    Koga = editModel.Koga
                };



                _context.NormiOperacii.Add(newNorma);

                _context.SaveChanges();
            }
        }

        public void TryEditNormaRoli(NormiRoliWithMoneyViewModel editModel)
        {
            var codePosition = _context.NListCodepositions.FirstOrDefault(c => c.Id == editModel.Id);

         //   codePosition.Status = Convert.ToInt32(editModel.Status);

            var norma = _context.NormiRoli.FirstOrDefault(n => n.Idcodeposition == editModel.Nkode && n.Idcodeposition_1 == editModel.SilaId && n.Tur == editModel.Tur);

            if (norma != null)
            {
                _context.NormiRoli.Remove(norma);
                _context.SaveChanges();
            }

            var newNorma = new NormiRoli
            {
                Id = _context.NormiRoli.LastOrDefault() == null ? 1 : _context.NormiRoli.LastOrDefault().Id + 1,
                Idcodeposition = editModel.Nkode,
                Idcodeposition_1 = editModel.SilaId,
                VidCodetable = 4,
                VidCodetable_1 = 1,
                Pari = editModel.Money,
                IzbAllias = _izboriRepository.GetIzborAlias(),
                Status = Convert.ToInt32(editModel.Status),
                User = editModel.User,
                Tur = editModel.Tur,
                Koga = editModel.Koga
            };

            _context.NormiRoli.Add(newNorma);

            _context.SaveChanges();
        }
    }
}
