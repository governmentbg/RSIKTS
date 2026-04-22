using System.ComponentModel.DataAnnotations;

namespace DataAccess
{
    public class ReshetkaSumGrid
    {
        [Key]
        public string Nime { get; set; }

        public int Cnt401 { get; set; }

        public int Max401 { get; set; }

        public int Cnt402 { get; set; }

        public int Max402 { get; set; }

        public int Cnt403 { get; set; }

        public int Max403 { get; set; }

        public int Cnt404 { get; set; }

        public int Max404 { get; set; }

    }
}
