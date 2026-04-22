
DELETE FROM `n_statistics` WHERE ID = 17;

INSERT INTO `n_statistics` (`id`,`shortdescription`,`longdescription`,`Tip`,`proc`)
  VALUES (17,'Списък на секциите (2)','С пълен номер, име и адрес',1,'spravka_1_2');


ALTER TABLE n_log_sik_istoria
    MODIFY Pole_Bilo text COLLATE utf8_unicode_ci DEFAULT NULL;  

ALTER TABLE n_log_sik_istoria
    MODIFY Pole_Stava text COLLATE utf8_unicode_ci DEFAULT NULL;      