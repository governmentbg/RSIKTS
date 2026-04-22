namespace Common.ViewModels.Spravki
{
    using System.ComponentModel.DataAnnotations;
    public class NomenklatureEditFullViewModel : NomenklatureEditBasicViewModel
    {

        public bool Has_ID_Shablon { get; set; }

        public bool Has_ID_Party { get; set; }

        public bool Has_Izb_Alias { get; set; }

        public bool Has_Status_Sh { get; set; }

        public bool Has_Short_Name { get; set; }

        public bool Has_Stoinost { get; set; }

        public bool Has_Temp { get; set; }

        public bool Has_Legal_Code { get; set; }

        public bool Has_Status_Partii { get; set; }

        public bool Has_Status_ndocs { get; set; }

        public bool Has_Status_List { get; set; }

        public bool Has_Pkode { get; set; }

        public bool Has_Leva_tur1 { get; set; }

        public bool Has_LevaRIK { get; set; }

        public bool Has_LevaN800 { get; set; }

        public bool Has_Leva_tur2 { get; set; }

        public bool Has_Leva_machinno { get; set; }

        public bool Has_Status { get; set; }

        public bool Has_Kod_Nas { get; set; }

        public bool Has_Kod_Ulica { get; set; }
        //

        private int iD_Shablon { get; set; }

        private int iD_Party { get; set; }

        private decimal stoinost { get; set; }

        private int pKode { get; set; }

        private string izb_Alias { get; set; }

        private byte? status_Sh { get; set; }

        private int? status_List { get; set; }

        private string short_Name { get; set; }

        private int? temp { get; set; }

        private string legal_Code { get; set; }

        private int? status_Partii { get; set; }

        private byte? status_ndocs { get; set; }

        private decimal? leva_tur1 { get; set; }

        private decimal? levaRIK { get; set; }

        private decimal? levaN800 { get; set; }
         
        private decimal? leva_tur2 { get; set; }

        private decimal? leva_machinno { get; set; }

        private bool status { get; set; }

        private string kod_nas { get; set; }

        private string kod_ulica { get; set; }

        //
        public int ID_Shablon { get { return iD_Shablon; } set { iD_Shablon = value; Has_ID_Shablon = true; } }

        public int ID_Party { get { return iD_Party; } set { iD_Party = value; Has_ID_Party = true; } }

        public int Pkode { get { return pKode; } set { pKode = value; Has_Pkode = true; } }

        public string Izb_Alias { get { return izb_Alias; } set { izb_Alias = value; Has_Izb_Alias = true; } }

        [Display(Name = "Статус")]
        public int? Status_List { get { return status_List; } set { status_List = value; Has_Status_List = true; } }

        [Display(Name = "Статус")]
        public byte? Status_Sh { get { return status_Sh; } set { status_Sh = value; Has_Status_Sh = true; } }

        [Display(Name = "Кратко име")]
        [RequiredIf("Has_Short_Name",true, ErrorMessage = "Полето е задължително")]
        public string Short_Name { get { return short_Name; } set { short_Name = value; Has_Short_Name = true; } }

        public int? Temp { get { return temp; } set { temp = value; Has_Temp = true; } }

        [Display(Name = "Легален код")]
        public string Legal_Code { get { return legal_Code; } set { legal_Code = value; Has_Legal_Code = true; } }

        [Display(Name = "Статус")]
        public int? Status_Partii { get { return status_Partii; } set { status_Partii = value; Has_Status_Partii = true; } }

        [Display(Name = "Статус")]
        public byte? Status_ndocs { get { return status_ndocs; } set { status_ndocs = value; Has_Status_ndocs = true; } }

        [Display(Name = "Евро тур 1")]
        public decimal? Leva_tur1 { get { return leva_tur1; } set { leva_tur1 = value; Has_Leva_tur1 = true; } }

        [Display(Name = "Евро РИК")]
        public decimal? LevaRIK { get { return levaRIK; } set { levaRIK = value; Has_LevaRIK = true; } }

        [Display(Name = "Евро N800")]
        public decimal? LevaN800 { get { return levaN800; } set { levaN800 = value; Has_LevaN800 = true; } }

        [Display(Name = "Евро тур 2")]
        public decimal? Leva_tur2 { get { return leva_tur2; } set { leva_tur2 = value; Has_Leva_tur2 = true; } }

        [Display(Name = "Евро машинно")]
        public decimal? Leva_machinno { get { return leva_machinno; } set { leva_machinno = value; Has_Leva_machinno = true; } }

        [Display(Name = "Стойност")]
        public decimal Stoinost { get { return stoinost; } set { stoinost = value; Has_Stoinost = true; } }

        public bool Status { get { return status; } set { status = value; Has_Status = true; } }

        [Display(Name = "Код населено място")]
        [RequiredIf("Has_Kod_Nas", true, ErrorMessage = "Полето е задължително")]
        public string Kod_Nas { get { return kod_nas; } set { kod_nas = value; Has_Kod_Nas = true; } }

        [Display(Name = "Код улица")]
        [RequiredIf("Has_Kod_Ulica", true, ErrorMessage = "Полето е задължително")]
        public string Kod_Ulica { get { return kod_ulica; } set { kod_ulica = value; Has_Kod_Ulica = true; } }
    }
}
