DROP PROCEDURE IF EXISTS spravka_MSBDECL;

DELIMITER //

CREATE PROCEDURE spravka_MSBDECL(
  prmIdLice   int
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)

BEGIN
  DECLARE lica_fullname, lica_izbori_rolia, lica_egn  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE siks_fullcode  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE v_toa  varchar(2) default  '' collate utf8_unicode_ci; 

  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);
          
  SELECT s.AA_BB_CC 
         ,c.NIME 
         ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),''))  
         ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) 
         ,s.TOA
    INTO  siks_fullcode,lica_izbori_rolia, lica_fullname, lica_egn, v_toa                      
    FROM n_lica l 
          inner join n_lica_izbori i on l.id = i.id_lice
          inner join siks s on i.id_sik = s.id_sek
          inner join n_list_codepositions c on c.NKODE = i.Code_rolia and c.PKODE=4
    WHERE l.ID = prmIdLice
     and i.TUR = @v_tur;
    
  SELECT coef_stoinost
    INTO @par_dc_20
    FROM n_top_dancoef
    WHERE IZB_ALLIAS = @v_izbalias
      AND nred = '20';
    
  CALL createLog(prmUSER,3,'Декларация за осигурителен доход',lica_fullname,v_toa,'');

  SELECT siks_fullcode as siks_fullcode
         ,lica_izbori_rolia as lica_izbori_rolia                 
         ,lica_fullname as lica_fullname
         ,lica_egn as lica_egn
         ,ROUND(@par_dc_20,2) as par_dc_20;

END;
//

DELIMITER ;