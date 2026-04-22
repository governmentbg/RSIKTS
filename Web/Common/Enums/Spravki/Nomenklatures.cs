using System.ComponentModel.DataAnnotations;

namespace Common.Enums.Spravki
{
    public enum NomenklatureIds
    {
        [Display(Name = "Населени Места")]
        NaseleniMesta = 1,
        [Display(Name = "Улици")]
        Ulici = 2,
        [Display(Name = "Области")]
        Oblasti = 3,
        [Display(Name = "Общини")]
        Objini = 4,
        [Display(Name = "Райони")]
        Raioni = 5,
        [Display(Name = "Административен район")]
        Toa = 6,
        [Display(Name = "Кметства")]
        Kmetstva = 7,
        [Display(Name = "Жилищен комплекс")]
        JilijenKompleks = 8,
        [Display(Name = "Районно управление")]
        RaionnoUpravlenie = 9,
        [Display(Name = "Националности")]
        Nacionalnosti = 10,
        [Display(Name = "Образование")]
        Obrazovanie = 11,
        [Display(Name = "Специалност")]
        Specialnost = 12,
        [Display(Name = "Решения")]
        Dokumenti = 13,
        [Display(Name = "Политически сили")]
        PoliticheskiSili = 14,
        [Display(Name = "Видове секции")]
        VidoveSekcii = 15,
        [Display(Name = "Признаци на секции")]
        VidovePrazniciNaSekcii = 16,
        [Display(Name = "Видове дейности")]
        VidoveOperacii = 17,
        [Display(Name = "Роли")]
        Roli = 18,
        [Display(Name = "Данъчни параметри")]
        DanuchniParametri = 21,
    }
}