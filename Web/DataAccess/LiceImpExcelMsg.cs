using System.ComponentModel.DataAnnotations;

namespace DataAccess
{
    public class LiceImpExcelMsg
    {
        [Key]
        public string ImpExcelMessage { get; set; }

        public int WrongRec { get; set; }
    }
}

