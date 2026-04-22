using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Common.Enums.Spravki
{
    public enum Statistics
    {
        BroiSekcii = 11,
        [Display(Name = "")]
        ControlSpisukNaSekciite = 12,
        SpisukNaSekciite = 13,
        SpisukSystavSekciite = 14,

        [Display(Name = "Подвижни секции")]
        SpisukPodvizjniSekcii = 15,

        [Display(Name = "Граници на секции")]
        SpisukSekciiGranici = 16,

        [Display(Name = "Граници на секции")]
        SpisukNaSekciite2 = 17,

        [Display(Name = "Секции – граници и брой избиратели")]
        SpisukSekciiGranici2 = 18,

        [Display(Name = "Секции и лица по длъжности и дейности")]
        SpisukSekciiLica = 19,

        RegisturLicaSlujebna = 21,

        [Display(Name = "Списък на резерви")]
        SpisukRezervi = 26,

        [Display(Name = "Регистър лица по райони")]
        RegisturLicaPublichna = 23,

        [Display(Name = "Помощен списък лица")]
        SpisukLica = 24,

        [Display(Name = "Замествания")]
        Zamestvaniq = 25,

        [Display(Name = "Справка за РЗИ")]
        SpravkaRZI = 27,

        [Display(Name = "Касов ордер")]
        MORS = 33,
        
        [Display(Name = "Декларация")]
        MSBD = 34,
        [Display(Name = "Удостоверения")]
        MUDO = 35,
        
        [Display(Name = "Служебна бележка")]
        MSB = 36,

        ZaetiPozicii = 60,
        ZaetiPoziciiObjo = 61,
        Rehsetka = 63,
        
        SustoqnieNaRegistraciite = 90,

        [Display(Name = "История на промените")]
        IstoriaSik = 91

    }
}
