using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace DataAccess
{
    public partial class SiksPodvijni
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]

        public int Id { get; set; }
        public int IdSik { get; set; }
        public string Toa { get; set; }
        public int VoterNumbere { get; set; }
        public string User { get; set; }
        public DateTime? Koga { get; set; }

        public virtual Siks IdSikNavigation { get; set; }
    }
}
