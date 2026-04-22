DROP PROCEDURE IF EXISTS spravka_MUDO;

DELIMITER //

CREATE PROCEDURE spravka_MUDO(
  prmIdLice   int
  ,prmTur     int
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)

BEGIN
  DECLARE lica_fullname, lica_egn, lica_izbori_re, lica_izbori_rolia  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE siks_fullcode, siks_nas, siks_kmet, siks_toa  varchar(100) default  '' collate utf8_unicode_ci;
  DECLARE n_top_main_description,n_toa_main_bul  varchar(100) default '' collate utf8_unicode_ci; 
  DECLARE n_top_main_datetur datetime;
  DECLARE v_toa  varchar(2) default  '' collate utf8_unicode_ci; 
  DECLARE v_idsek, v_udocnom, v_id, v_code_rolia int;

  SET NAMES 'utf8';

  SELECT VALUE
     INTO @v_izbalias
     FROM sys_main
     WHERE ID = 1;
 
  SELECT koga
      INTO @v_koga              
      FROM n_lica
      WHERE ID = prmIdLice;
                             
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
         ,s.id_sek
         ,i.id
         ,i.Code_rolia
    INTO  lica_fullname, lica_egn, lica_izbori_re, lica_izbori_rolia
          ,siks_fullcode, siks_nas, siks_kmet, siks_toa
          ,v_toa, v_idsek, v_id, v_code_rolia                      
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
    
                  
    IF  v_code_rolia >= 404 THEN
      SELECT (v_code_rolia-400-1)+order_
          INTO v_udocnom
          FROM (SELECT ID, @rownum := @rownum + 1 AS order_
                  FROM n_lica_izbori, (SELECT @rownum :=0) t 
                  WHERE id_sik = v_idsek
                    AND izb_alias = @v_izbalias
                    AND TUR = prmTur
                    AND Code_rolia = v_code_rolia
                  ORDER BY id) x
          WHERE ID = v_id;            
    ELSE  
        SET v_udocnom := (v_code_rolia-400);
    END IF;
    
  /*  ne se polzva, generirane na posledovatelen nomer v ramkite na sekcijata   
    SELECT Value
      INTO v_udocnom
      FROM sys_toamain
      WHERE Izb_alias = @v_izbalias
        AND TOA = v_toa
        AND IDSEK = v_idsek;
    
    IF IFNULL(v_udocnom,0) = 0 THEN
        SET v_udocnom = 1;
        INSERT INTO sys_toamain (`Izb_alias`,`Tur`,`Toa`,`IdSek`,`Name`,`Value`) 
              VALUES (@v_izbalias,prmTur, v_toa, v_idsek, 'Приложение №', v_udocnom);
    ELSE
        SET v_udocnom = v_udocnom+1;

        UPDATE sys_toamain
          SET Value = v_udocnom
          WHERE Izb_alias = @v_izbalias
            AND TOA = v_toa
            AND IDSEK = v_idsek;        
    END IF;
  */

  CALL createLog(prmUSER,3
                ,CONCAT('Удостоверение №',siks_fullcode,'-',TRIM(CAST(v_udocnom as CHAR(10))),'/',DATE_FORMAT(NOW(), '%d.%m.%Y г.'))
                ,lica_fullname
                ,v_toa,'');

  SELECT (SELECT NIME 
            FROM wnizbraion 
            WHERE NKOD = fnGetIzborenRajon(@v_izbalias,v_toa)
              AND IZB_ALIAS =@v_izbalias ) as izr_rajon
         ,CONCAT(siks_fullcode,'-',TRIM(CAST(v_udocnom as CHAR(10))),'/',DATE_FORMAT(NOW(), '%d.%m.%Y г.')) as udocnom
         ,IFNULL(lica_izbori_re,'') as lica_izbori_re
         ,lica_fullname as lica_fullname
         ,lica_egn as lica_egn
         ,lica_izbori_rolia as lica_izbori_rolia
         ,siks_fullcode as siks_fullcode
         ,IFNULL(siks_nas,' ') as siks_nas
         ,IFNULL(siks_kmet,' ') as siks_kmet
         ,IFNULL(siks_toa,' ') as siks_toa
         ,n_top_main_description as n_top_main_description
         ,DATE_FORMAT(n_top_main_datetur, '%d/%m/%Y') as n_top_main_datetur;
END;
//

DELIMITER ;