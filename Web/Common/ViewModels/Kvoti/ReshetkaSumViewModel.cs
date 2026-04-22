using System;
using System.Collections.Generic;
using System.Text;

namespace Common.ViewModels.Kvoti
{
    public class ReshetkaSumViewModel
    {
        public string Nime { get; set; }

        public int PrecedatelCount { get; set; }

        public int PrecedatelMax { get; set; }

        public int ZamestnikPrecedatelCount { get; set; }

        public int ZamestnikPrecedatelMax { get; set; }

        public int SekretarCount { get; set; }

        public int SekretarMax { get; set; }

        public int ChlenCount { get; set; }

        public int ChlenMax { get; set; }
    }
}
