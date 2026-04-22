using System;
using System.Collections.Generic;
using System.Text;

namespace DTO.Spravki
{
    public class BroiSekciiSpravkaDto
    {
        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }

        public int Total { get; set; }

        public int Basic { get; set; }

        public int Mobail { get; set; }

        public int Official { get; set; }

        public int Another { get; set; }
    }
}
