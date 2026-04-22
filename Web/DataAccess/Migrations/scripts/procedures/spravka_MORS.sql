DROP PROCEDURE IF EXISTS spravka_MORS;

DELIMITER //

CREATE PROCEDURE spravka_MORS(
  prmIdLice   int
  ,prmTur     int
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)

BEGIN
  DECLARE lica_fullname, lica_egn  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE siks_fullcode  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE n_top_main_description,n_toa_main_bul  varchar(100) default '' collate utf8_unicode_ci; 
  DECLARE n_top_main_datetur datetime;
  DECLARE v_toa  varchar(2) default  '' collate utf8_unicode_ci; 
  DECLARE v_id int;
  
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);
 
 IF prmTur > 0 THEN
    SET @v_tur = prmTur;
 END IF;
 
 SELECT CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),''))  
         ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) 
         ,s.AA_BB_CC
         ,s.TOA
         ,i.id
    INTO lica_fullname, lica_egn,siks_fullcode,v_toa, v_id                      
    FROM n_lica_izbori i 
          inner join n_lica l on l.id = i.id_lice
          inner join siks s on s.id_sek = i.id_sik
    WHERE i.ID_lice = prmIdLice
      AND i.izb_alias = @v_izbalias
      AND i.TUR =   @v_tur;
      
  SELECT Description, if(prmTur = 2, DATE2TUR, DATE1TUR)
    INTO n_top_main_description, n_top_main_datetur
    FROM n_top_main
    WHERE IZB_ALIAS = @v_izbalias
      AND Status_parameters = 1;
            
  SELECT BUL
    INTO n_toa_main_bul
    FROM n_toa_main
    WHERE IZB_ALIAS = @v_izbalias
      AND TOA = v_toa 
      AND TUR =  @v_tur
    LIMIT 0,1 ;

  SELECT SUM(pari)
    INTO @suma
  FROM  n_lice_pari_zaplashtane
  WHERE ID_Lice = v_id;
  

  CALL createLog(prmUSER,3,'Касов ордер',lica_fullname,v_toa,'');

  SELECT wntoa.nime as izr_rajon
         ,n_toa_main_bul as n_toa_main_bul
         ,lica_fullname as lica_fullname
         ,lica_egn as lica_egn
         ,n_top_main_description as n_top_main_description
         ,DATE_FORMAT(n_top_main_datetur, '%d/%m/%Y') as n_top_main_datetur
         ,siks_fullcode as siks_fullcode
         ,ifnull(ROUND(@suma,2),0) as suma
         ,fnSlovom(IFNULL(ROUND(@suma,2),0)) as slovom
    FROM wntoa
    WHERE NKOD = v_toa;          
END;
//

DELIMITER ;