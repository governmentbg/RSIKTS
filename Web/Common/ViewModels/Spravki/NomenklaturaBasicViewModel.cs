namespace Common.ViewModels.Spravki
{
    using Common.Enums.Spravki;
    using Common.ViewModels.Shared;

    public class NomenklaturaBasicViewModel
    {
        public bool Has_ID_Shablon { get; set; }
        public bool Has_ID_Party { get; set; }    
        public bool Has_Kod_Nas { get; set; }
        public bool Has_Kod_Ulica { get; set; }
        public bool Has_Stoinost { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        private int iD_Shablon { get; set; }
        private int iD_Party { get; set; }
        public int ID_Shablon { get { return iD_Shablon; } set { iD_Shablon = value; Has_ID_Shablon = true; } }
        public int ID_Party { get { return iD_Party; } set { iD_Party = value; Has_ID_Party = true; } }
        private bool status { get; set; }
        public bool Status { get { return status; } set { status = value; Has_Status = true; } }
        public bool Has_Status { get; set; }

        private decimal stoinost { get; set; }
        public decimal Stoinost { get { return stoinost; } set { stoinost = value; Has_Stoinost = true; } }

        private string kod_nas { get; set; }
        public string Kod_Nas { get { return kod_nas; } set { kod_nas = value; Has_Kod_Nas = true; } }

        private string kod_ulica { get; set; }
        public string Kod_Ulica { get { return kod_ulica; } set { kod_ulica = value; Has_Kod_Ulica = true; } }

    }
}
