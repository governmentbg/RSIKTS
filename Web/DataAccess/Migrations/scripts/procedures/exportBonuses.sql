DROP PROCEDURE IF EXISTS exportBonuses;

DELIMITER //

CREATE PROCEDURE exportBonuses(
   prmUSER          varchar(128) 
   ,prmIdLiceIzb    int
   ,prmTip          int
   ,izborTur        int
   ,prmDummy        varchar(30)
)
BEGIN
  DECLARE v_tur int;
  DECLARE v_toa varchar(2);
  DECLARE v_izb_alias varchar(6);
     
  SET NAMES 'utf8';
  SET v_tur = izborTur;
  
  SELECT MAX(IF(id=1,VALUE,''))
  --      ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO v_izb_alias
    -- , v_tur
    FROM sys_main
    WHERE ID in (1,2);
    
 SELECT SUM(pari)
    INTO @v_c35
    FROM n_lice_pari_zaplashtane
    WHERE n_lice_pari_zaplashtane.ID_Lice = prmIdLiceIzb;
                   
  IF EXISTS (SELECT 1 
               FROM n_lica_izbori l 
                      inner join siks s on l.id_sik = s.id_sek
                      inner join siks_vidove v on v.id_sik = s.id_sek                      
                      inner join n_list_codepositions n ON n.PKODE = v.Vid_codetable and n.NKODE = v.Idcodeposition and n.CALC=1
               WHERE l.ID         = prmIdLiceIzb 
                 AND l.Code_rolia   < 410
                 AND IFNULL(l.hasmaxincome,0) = 0
--                 AND v.Idcodeposition < 104
               ) 
      AND @v_c35 > 0         
  THEN
  
    SELECT TOA
      INTO @v_toa
      FROM n_lica_izbori  
      WHERE Id = prmIdLiceIzb;

    IF v_tur = 2 THEN
      SELECT DATE2TUR
        INTO @v_datetur
        FROM n_top_main
        WHERE status_parameters = 1;    
    ELSE
      SELECT DATE1TUR
        INTO @v_datetur
        FROM n_top_main
        WHERE status_parameters = 1;    
    END IF;
 
    SELECT BUL collate utf8_unicode_ci
      INTO @v_bulstat
      FROM n_toa_main 
      WHERE IZB_ALIAS = v_izb_alias
        AND TOA = @v_toa
        AND TUR = v_tur
      LIMIT 1;
      
    IF v_tur = 2 THEN
        SELECT Znachenie collate utf8_unicode_ci
          INTO @v_c21
          FROM n_top_parameters
          WHERE n_top_parameters.IZB_ALIAS= v_izb_alias
            AND n_top_parameters.KOD = '51'
            AND n_top_parameters.Status_parameters =1;

        SELECT CONVERT(DAY(STR_TO_DATE(`Znachenie`, '%d/%c/%Y')),CHAR) collate utf8_unicode_ci
          INTO @v_c9
          FROM n_top_parameters
          WHERE n_top_parameters.IZB_ALIAS= v_izb_alias
            AND n_top_parameters.KOD = '54'
            AND n_top_parameters.Status_parameters =1;

        SELECT CONVERT(DAY(STR_TO_DATE(`Znachenie`, '%d/%c/%Y')),CHAR) collate utf8_unicode_ci
          INTO @v_c10
          FROM n_top_parameters
          WHERE n_top_parameters.IZB_ALIAS= v_izb_alias
            AND n_top_parameters.KOD = '55'
            AND n_top_parameters.Status_parameters =1;
    
    ELSE
        SELECT Znachenie collate utf8_unicode_ci
          INTO @v_c21
          FROM n_top_parameters
          WHERE n_top_parameters.IZB_ALIAS= v_izb_alias
            AND n_top_parameters.KOD = '50'
            AND n_top_parameters.Status_parameters =1;

        SELECT CONVERT(DAY(STR_TO_DATE(`Znachenie`, '%d/%c/%Y')),CHAR) collate utf8_unicode_ci
          INTO @v_c9
          FROM n_top_parameters
          WHERE n_top_parameters.IZB_ALIAS= v_izb_alias
            AND n_top_parameters.KOD = '52'
            AND n_top_parameters.Status_parameters =1;

        SELECT CONVERT(DAY(STR_TO_DATE(`Znachenie`, '%d/%c/%Y')),CHAR) collate utf8_unicode_ci
          INTO @v_c10
          FROM n_top_parameters
          WHERE n_top_parameters.IZB_ALIAS= v_izb_alias
            AND n_top_parameters.KOD = '53'
            AND n_top_parameters.Status_parameters =1;    
    END IF;
    
    SELECT IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l.egn),prmDummy) as CHAR(50)),'')
      INTO @v_egn
      FROM n_lica_izbori i inner join n_lica l on i.ID_Lice = l.id
      WHERE i.ID = prmIdLiceIzb
      LIMIT 1;

    if fnGetLiceBirthYear( @v_egn) > 1959 THEN   
        SELECT Coef_stoinost
          INTO @v_c36
          FROM n_top_dancoef
          WHERE n_top_dancoef.IZB_ALLIAS = v_izb_alias
            AND nred = '02';
    ELSE
        SELECT Coef_stoinost
          INTO @v_c36
          FROM n_top_dancoef
          WHERE n_top_dancoef.IZB_ALLIAS = v_izb_alias
            AND nred = '01';
    END IF;
    
    SELECT Coef_stoinost
      INTO @v_c38
      FROM n_top_dancoef
      WHERE n_top_dancoef.IZB_ALLIAS = v_izb_alias
        AND nred = '04';      
      
   SELECT Coef_stoinost
      INTO @v_c40
      FROM n_top_dancoef
      WHERE n_top_dancoef.IZB_ALLIAS = v_izb_alias
        AND nred = '06';      

   if fnGetLiceBirthYear( @v_egn) > 1959 THEN   
       SELECT Coef_stoinost
          INTO @v_c43
          FROM n_top_dancoef
          WHERE n_top_dancoef.IZB_ALLIAS = v_izb_alias
            AND nred = '03'; 
    ELSE
       SET  @v_c43 = 0;
    END IF;
    
    SET @delimiter = ',' collate utf8_unicode_ci;
    
              
    
    SELECT CONCAT(
               CAST(c1 as CHAR(2)),@delimiter
              ,CAST(c2 as CHAR(4)),@delimiter
              ,c3,@delimiter
              ,c4,@delimiter
              ,CAST(c5 as CHAR(1)),@delimiter
              ,c6,@delimiter
              ,c7,@delimiter
              ,c8,@delimiter
              ,c9,@delimiter
              ,c10,@delimiter
              ,c11,@delimiter
              ,c12,@delimiter
              ,c13,@delimiter
              ,c14,@delimiter
              ,c15,@delimiter
              ,c16,@delimiter
              ,c17,@delimiter
              ,c18,@delimiter
 --             ,c19,@delimiter
              ,c20,@delimiter
              ,CAST(c21 as CHAR(4)),@delimiter
              ,c22,@delimiter
              ,c23,@delimiter
              ,c24,@delimiter
              ,c25,@delimiter
              ,c26,@delimiter
              ,c27,@delimiter
              ,c28,@delimiter
              ,c29,@delimiter
              ,c30,@delimiter
              ,c31,@delimiter
              ,c32,@delimiter
              ,c33,@delimiter
              ,c34,@delimiter
              ,CAST(c35 as CHAR),@delimiter
              ,CAST(c36 as CHAR),@delimiter
              ,c37,@delimiter
              ,CAST(c38 as CHAR),@delimiter
              ,c39,@delimiter
              ,CAST(c40 as CHAR),@delimiter
              ,c41,@delimiter
              ,c42,@delimiter
              ,CAST(c43 as CHAR),@delimiter
              ,c44,@delimiter
              ,c45,@delimiter
              ,c46,@delimiter
              ,c47,@delimiter
              ,c48,@delimiter
              ,c49,@delimiter
              ,c50,@delimiter
              ,CAST(c51 as CHAR),@delimiter
              ,c52,@delimiter
              ,c53,@delimiter
              ,c54
      )  collate utf8_unicode_ci as line
      FROM (SELECT MONTH(@v_datetur) as c1
                  ,YEAR(@v_datetur)  as c2
                  ,CONCAT('"',IFNULL(@v_bulstat,''),'"')  as c3
                  ,CONCAT('"',@v_egn,'"') as c4
                  ,l.VID_ID as c5 
                  ,CONCAT('"',IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l.im3),prmDummy) as CHAR(50)),''),'"') as c6
                  ,CONCAT('"',CONCAT(LEFT(CAST(AES_DECRYPT(FROM_BASE64(l.im1),prmDummy) as CHAR(50)),1)
                                   ,IFNULL(LEFT(CAST(AES_DECRYPT(FROM_BASE64(l.im2),prmDummy) as CHAR(50)),1),''))
                                    ,'"') collate utf8_unicode_ci as c7        
                  ,'71' as c8
                  ,LEFT(IFNULL(@v_c9,'0'),2) as c9
                  ,LEFT(IFNULL(@v_c10,'0'),2) as c10
                  ,'0' as c11
                  ,'0' as c12
                  ,'0' as c13
                  ,'0' as c14
                  ,'0' as c15
                  ,'0' as c16
                  ,'0' as c17
                  ,'0' as c18
                  ,'1' as c19
                  ,'"0300"' as c20
                  ,IFNULL(FORMAT(@v_c21,0),0) as c21 
                  ,'0' as c22
                  ,'0' as c23
                  ,'0' as c24
                  ,'0' as c25
                  ,'0' as c26
                  ,'0' as c27
                  ,'0' as c28
                  ,'0' as c29
                  ,'""' as c30
                  ,'0' as c31
                  ,'"0000"' as c32
                  ,'0' as c33
                  ,'0' as c34
                  ,IFNULL(FORMAT(@v_c35,2),0) as c35
                  ,IFNULL(FORMAT(@v_c36*100,2),0) as c36
                  ,'0' as c37
                  ,IFNULL(FORMAT(@v_c38*100,2),0) as c38
                  ,'0' as c39
                  ,IFNULL(FORMAT(@v_c40*100,2),0) as c40
                  ,'0' as c41
                  ,'0' as c42
                  ,IF(@v_c43=0,'',IFNULL(FORMAT(@v_c43*100,2),0)) as c43
                  ,'0' as c44
                  ,'0' as c45
                  ,'0' as c46
                  ,'0' as c47
                  ,'0' as c48
                  ,'0' as c49
                  ,'0' as c50
                  ,IFNULL(FORMAT(@v_c35,2),0) as c51
                  ,'0' as c52
                  ,prmTip as c53
                  ,'"NRAD12008"' as c54
              FROM n_lica_izbori i inner join n_lica l on i.ID_Lice = l.ID
              WHERE i.Id = prmIdLiceIzb) x;
  ELSE
     SELECT ''  collate utf8_unicode_ci as LINE;
  END IF;
END;
//

DELIMITER ;	