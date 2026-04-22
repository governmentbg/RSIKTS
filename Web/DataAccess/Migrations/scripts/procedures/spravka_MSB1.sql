DROP PROCEDURE IF EXISTS spravka_MSB1;

DELIMITER //

CREATE PROCEDURE spravka_MSB1(
  prmIdLice   int
  ,prmTur     int
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)

BEGIN
  DECLARE lica_fullname, lica_egn, lica_izbori_re, lica_izbori_rolia varchar(100) default  ''  collate utf8_unicode_ci;
  DECLARE siks_fullcode, siks_nas, siks_kmet, siks_toa  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE n_top_main_description, n_toa_main_epod, v_toa  varchar(100) default  ''; 
  DECLARE n_top_main_datetur datetime;

  SET NAMES 'utf8';

  SELECT VALUE
     INTO @v_izbalias
     FROM sys_main
     WHERE ID = 1;
       
  SELECT CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),''))  
         ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) 
         ,w0.NIME
         ,c.NIME 
         ,s.AA_BB_CC
         ,w1.nime
         ,w2.nime
         ,w3.NIME
         ,s.TOA
    INTO  lica_fullname, lica_egn, lica_izbori_re, lica_izbori_rolia
          ,siks_fullcode, siks_nas, siks_kmet, siks_toa,v_toa                      
    FROM n_lica_izbori i 
          inner join n_lica l on l.id = i.id_lice
          inner join siks s on s.id_sek = i.id_sik
          inner join n_list_codepositions c on c.NKODE = i.Code_rolia and c.PKODE=4
          left join wndocs w0 on w0.nkod = i.re
          left join wnasm w1 on w1.nkod = s.NAS
          left join wnkmetstva w2 on w1.Kmetstvo = w2.nkod 
          left join wntoa w3 on w3.nkod = s.TOA
    WHERE i.ID_lice = prmIdLice
      AND i.izb_alias = @v_izbalias
      AND i.TUR = prmTur;
    
  SELECT Description, if(prmTur = 2, DATE2TUR, DATE1TUR)
    INTO n_top_main_description, n_top_main_datetur
    FROM n_top_main
    WHERE IZB_ALIAS = @v_izbalias
      AND Status_parameters = 1;
            
  SELECT EPOD
    INTO @n_toa_main_epod
    FROM n_toa_main
    WHERE IZB_ALIAS = @v_izbalias
      AND TOA = v_toa 
      AND TUR = prmTur;

  CALL createLog(prmUSER,3,'Служебна бележка',lica_fullname,v_toa,'');

  SELECT wntoa.NIME as izr_rajon
         ,lica_fullname as lica_fullname
         ,lica_egn as lica_egn
         ,IFNULL(lica_izbori_re,' ') as lica_izbori_re
         ,lica_izbori_rolia as lica_izbori_rolia
         ,siks_fullcode as siks_fullcode
         ,IFNULL(siks_nas,' ') as siks_nas
         ,IFNULL(siks_kmet,' ') as siks_kmet
         ,IFNULL(siks_toa,' ') as siks_toa
         ,n_top_main_description  collate utf8_unicode_ci as n_top_main_description
         ,DATE_FORMAT(n_top_main_datetur, '%d/%m/%Y')  collate utf8_unicode_ci as n_top_main_datetur
         ,IFNULL(n_toa_main_epod,' ')  collate utf8_unicode_ci as n_toa_main_epod
    FROM wntoa
    WHERE NKOD = v_toa; 
END;
//

DELIMITER ;