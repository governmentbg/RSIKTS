using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.Kvoti
{
    public class KvotiDto
    {
        public string Id { get; set; }

        public int Precedatel { get; set; }

        public int ZamestnikPrecedatel { get; set; }

        public int Sekretar { get; set; }

        public int Chlenove { get; set; }

        public int Total { get; set; }

        public string PoliticheskaSila { get; set; }

        public string PoliticheskaSilaId { get; set; }

        public int SikMembers { get; set; }

        public int SikHeads { get; set; }
    }
}
