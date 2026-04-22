DROP TABLE `n_lica_import`;

CREATE TABLE `n_lica_import` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `egn` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `im1` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `im2` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `im3` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `SIK` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Rolja` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Obra` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Spec` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tel` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL,
  `opisanie` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `pas1` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14113 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DELETE FROM `n_statistics` WHERE ID = 15;

INSERT INTO `n_statistics` (`id`,`shortdescription`,`longdescription`,`Tip`,`proc`)
  VALUES (15,'Обхват на подвижни секции','Обхват на подвижни секции, брой избиратели',1,'spravka_1_4');

DELETE FROM `n_statistics` WHERE ID = 91;

INSERT INTO `n_statistics` (`id`,`shortdescription`,`longdescription`,`Tip`,`proc`)
  VALUES (91,'История на промените на СИК','История на промените - създаване, закриване, промяна на параметри',1,'spravka_9_2');

UPDATE `n_statistics` SET TIP = 3 WHERE ID between 34 and 36;

DELETE FROM n_list_codepositions 
  WHERE PKODE=3 AND NKODE > 303;

UPDATE `n_nomenclatures` SET ID = 22 WHERE ID=6;

INSERT INTO `n_nomenclatures` (`id`, `description`, `table`, `status`, `Tip`) 
  VALUES (6, 'Административен район', 'n_toa_main', 1, 1);

UPDATE `n_nomenclatures` SET TIP = 2 WHERE ID between 19 AND 22;
  
INSERT INTO  n_list_codepositions (`PKODE`,`IZB_ALLIAS`,`NKODE`,`NIME`,`Status`,`CALC`)
  VALUES(3,'PR2021',330,'Корекция–баланс',1,null);

TRUNCATE `n_log`;

DROP TABLE `n_log_lica`;

CREATE TABLE `n_log_lica` (
  `Id_LOG` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Koga` datetime(6) NOT NULL,
  `ACTION` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `Kod_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Ime_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `AAA` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id_LOG`)
) ENGINE=InnoDB AUTO_INCREMENT=46544 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE `n_log_deinosti`;

CREATE TABLE `n_log_deinosti` (
  `Id_LOG` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Koga` datetime(6) NOT NULL,
  `ACTION` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `Kod_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Ime_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `AAA` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id_LOG`)
) ENGINE=InnoDB AUTO_INCREMENT=46544 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE `n_log_dokumenti`;

CREATE TABLE `n_log_dokumenti` (
  `Id_LOG` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Koga` datetime(6) NOT NULL,
  `ACTION` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `Kod_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Ime_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `AAA` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id_LOG`)
) ENGINE=InnoDB AUTO_INCREMENT=46544 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE `n_log_sik_istoria`;

CREATE TABLE `n_log_sik_istoria` (
  `Id_LOG` int(11) NOT NULL AUTO_INCREMENT,
  `User` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Koga` datetime(6) NOT NULL,
  `TOA` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `TOA_TEKST` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `SIK` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Kod_Obrabotka` varchar(250) COLLATE utf8_unicode_ci NOT NULL,  
  `Kod_Tekst` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `Pole_Bilo` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Pole_Stava` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id_LOG`)
) ENGINE=InnoDB AUTO_INCREMENT=46544 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


ALTER TABLE n_list_codepositions DROP COLUMN CALC;

ALTER TABLE n_list_codepositions ADD COLUMN CALC tinyint(1) null;

ALTER TABLE siks DROP COLUMN broimembers;

ALTER TABLE siks ADD COLUMN broimembers tinyint default 0;

DROP TABLE `siks_podvijni`;

CREATE TABLE `siks_podvijni` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Id_Sik` int(11) NOT NULL,
  `TOA` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `Voter_number` int(10) NOT NULL DEFAULT 0,
  `USER` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Koga` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_SIKS_PODVIJNI_SIKS` (`Id_Sik`),
  CONSTRAINT `FK_SIKS_PODVIJNI_SIKS` FOREIGN KEY (`Id_Sik`) REFERENCES `siks` (`Id_sek`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DELETE FROM n_list_codepositions WHERE PKODE=1 AND NKODE=100;

INSERT INTO n_list_codepositions (`PKODE`,`IZB_ALLIAS`,`NKODE`,`NIME`,`Status`,`CALC`)
  SELECT  1,IZB_ALLIAS,100,'Нулева секция',1,0
    FROM n_list_codepositions 
    WHERE PKODE=1 AND NKODE=101;

UPDATE n_list_codepositions
  SET CALC = 1
  WHERE PKODE = 1
    AND NKODE IN (101,102,103);

UPDATE n_list_codepositions
  SET CALC = 0
  WHERE PKODE = 1
    AND NKODE = 104;
    

UPDATE n_list_codepositions
  SET CALC = 0
  WHERE calc is null;
    
DROP TABLE `n_lica_dopylnenie_OTTUR1`;

CREATE TABLE `n_lica_dopylnenie_OTTUR1` (
  `ID` int(7) NOT NULL,
  `Id_Lice` int(7) DEFAULT NULL,
  `VidCodetable` int(11) DEFAULT NULL,
  `Idcodeposition` int(11) DEFAULT NULL,
  `Status` int(1) DEFAULT '1',
  `User` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Koga` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE `n_lica_izbori_zamestvane_ottur1`;

CREATE TABLE `n_lica_izbori_zamestvane_ottur1` (
  `ID` int(11) NOT NULL,
  `ID_Lice_novo` int(11) NOT NULL,
  `Id_Lice_staro` int(11) DEFAULT NULL,
  `id_sila` int(11) DEFAULT '0',
  `USER` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KOGA` datetime(6) DEFAULT NULL,
  `id_rolja` int(11) DEFAULT '0',
  `id_sek` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


ALTER TABLE siks DROP COLUMN numbvoters;

ALTER TABLE siks ADD COLUMN numbvoters int default 0;


ALTER TABLE siks DROP COLUMN borders;

ALTER TABLE siks ADD COLUMN borders text;

DELETE FROM `n_statistics` WHERE ID = 16;

INSERT INTO `n_statistics` (`id`,`shortdescription`,`longdescription`,`Tip`,`proc`)
  VALUES (16,'Секции – граници и брой избиратели','Списък с номерата на избирателните секции и административните адреси попадащи в тях',1,'spravka_1_5');

     
DELETE FROM  n_toa_main
  WHERE EXISTS(SELECT 1 
                 FROM (SELECT MIN(nrec) nrec, TOA
                        FROM n_toa_main
                        WHERE IZB_ALIAS = 'MI2019'
                          AND TUR = 2
                        GROUP BY TOA  
                        having count(nrec) >1) x  
                  WHERE x.toa = n_toa_main.toa 
                    and x.nrec = n_toa_main.nrec);
           
 DELETE FROM  n_top_parameters
    WHERE KOD in ('51', '52', '53', '54', '55');
  
 INSERT INTO n_top_parameters (IZB_ALIAS, KOD, Description, Znachenie, Status_parameters)
    VALUES
      ( 'MI2019','51', 'Брой нормодни (Тур 2)',3,1),
      ( 'MI2019','52', 'Тур 1 Начална дата','10',1),
      ( 'MI2019','53', 'Тур 1 Крайна дата','13',1),
      ( 'MI2019','54', 'Тур 2 Начална дата','17',1),
      ( 'MI2019','55', 'Тур 2 Крайна дата','20',1);
 
  DROP TABLE `n_lica_import`;
 
  CREATE TABLE `n_lica_import` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `egn` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
    `im1` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
    `im2` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
    `im3` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
    `SIK` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
    `Rolja` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
    `Obra` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
    `Spec` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
    `Tel` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
    `status` int(11) NOT NULL,
    `opisanie` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
    `user` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
    PRIMARY KEY (`id`)
  ) ENGINE=InnoDB AUTO_INCREMENT=14113 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
 
 

  ALTER TABLE n_toa_main
    MODIFY R1 varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL;
  