using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccess
{
    public class SpisykPodvizjniSekcii
    {
        [Key]
        public int Id { get; set; }

        public string NmIzbRajon { get; set; }

        public string NmRajon { get; set; }

        public int SumVoter { get; set; }

        public string SikNumb { get; set; }

        public string Address { get; set; }

        public string ObsRajon { get; set; }

        public int Voters { get; set; }
    }
}
