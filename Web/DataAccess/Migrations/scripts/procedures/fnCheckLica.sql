DROP FUNCTION IF EXISTS fnCheckLica;

DELIMITER //

CREATE FUNCTION fnCheckLica (
    prnFrom       int             -- 1 from register, 0 - from import
    ,prmIzbAlias  varchar(6)
    ,prmToa       varchar(2)
    ,prmTur       int 
    ,prmID        int
    ,prmVIDID     int
    ,prmEgn       varchar(10)
    ,prmIdSila    int
    ,prmSIK       varchar(3)
    ,prmKODROL    varchar(3)
    ,prmKODSPEC   varchar(3)
    ,prmKODOBR    varchar(3)
    ,prmDummy     varchar(30)
    ,prmIdReplace  int
) RETURNS varchar(250)

BEGIN
  DECLARE retval,v_opisanie varchar(250) default ''  collate utf8_unicode_ci;
  DECLARE v_VIDID int default -1;
  
  SET retval     := '00';
  SET v_opisanie := '';
   
  -- proverka dlyzjnost    
  IF LENGTH(IFNULL(prmKODROL,''))=0 THEN
      SET retval     := '11';
      SET v_opisanie :=CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Липсва длъжност');
  END IF;

/*
  -- proverka specialnost
  IF LENGTH(IFNULL(prmKODSPEC,''))=0 THEN
      SET retval     := '01';
      SET v_opisanie :=CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Липсва Специалност');
  END IF;
  
  -- proverka obrazovanie
  IF LENGTH(IFNULL(prmKODOBR,''))=0 THEN
      SET retval     := '01';
      SET v_opisanie :=CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Липсва Образование');
  END IF;
*/

  IF LENGTH(IFNULL(prmEgn,'')) = 0 THEN
      SET retval      := '11';
      SET v_opisanie  := CONCAT('Липсва ',IF(prmVIDID=2,' ЛНЧ','ЕГН'));        
  ELSE
    -- proverka za korektno EGN
    if prnFrom = 0 THEN
        IF checkNumber(0, prmEgn) = 0 THEN
            SET v_VIDID := 0;
        ELSE
          -- proverka za korektno LNCH
          IF checkNumber(2, prmEgn) = 0 THEN
              SET v_VIDID := 2;
          END IF;
        END IF;  
    ELSE
       IF checkNumber(prmVIDID, prmEgn) = 0 THEN
          SET v_VIDID = prmVIDID;
       END IF;   
    END IF;
    
    IF v_VIDID = -1 THEN
       SET retval     := '11';
       SET v_opisanie := CONCAT('Грешно ',IF(prmVIDID=2,' ЛНЧ','ЕГН'));
    END IF;
  END IF;
  
  -- proverka SIL
  IF LENGTH(IFNULL(prmSIK,''))=0 THEN
      SET retval     := '11';
      SET v_opisanie :=CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Липсва СИК');
  ELSE
    IF NOT EXISTS(SELECT 1 
                    FROM SIKS 
                    WHERE IZB_ALIAS = prmIzbAlias
                     AND TOA = prmToa
                     AND TUR = prmTur
                     AND SIK = prmSIK
                     AND (Status_Sekcia=1 OR prmSIK='000')) 
    THEN
        SET retval     := '11';
        SET v_opisanie := CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Грешнa СИК');        
    END IF;      
  END IF;

  -- proverka Politicheska sila
  IF (IFNULL(prmIdSila, 0) = 0) THEN
      SET retval     := '11';
      SET v_opisanie :=CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Липсва Политическа сила');
  ELSE
    IF NOT EXISTS(SELECT 1 
                    FROM wnsila 
                    WHERE id_party = prmIdSila) THEN
        SET retval     := '11';
        SET v_opisanie :=CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Грешнa Политическа сила');        
    END IF;      
  END IF;
  
  IF IFNULL(prmKODROL,0) in (401,402,403) THEN  
    SELECT Id_sek, sik 
      INTO @v_idsik, @v_sik
      FROM siks
      WHERE sik = prmSIK
        AND IZB_ALIAS  = prmIzbAlias
        AND Toa = prmToa
        AND TUR = prmTUR
        AND Status_Sekcia=1 ;
  
    -- proverka za zaeta rykowodna dlyzjnost
    IF IFNULL(prmIdReplace,0) = 0 AND  @v_sik != '000' THEN
      IF EXISTS(SELECT 1 
                      FROM n_lica_izbori i 
                      WHERE i.Id_Sik    = @v_idsik
                        AND i.id_lice <> prmID
                        and i.Code_rolia = prmKODROL) THEN
                        
          SET retval     := '01';
          SET v_opisanie := CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Заета длъжност ');        
      ELSE
         -- proverka za druga rykovodna dlyzjnost ot syshtata partia
          IF EXISTS(SELECT 1 
                          FROM n_lica_izbori i 
                          WHERE i.Id_Sik    = @v_idsik
                            AND i.id_lice <> prmID
                            and i.id_sila = prmIdSila
                            and i.Code_rolia in (401,402,403)) THEN
              SET retval     := '01';
              SET v_opisanie := CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Друга ръководна длъжност от същата политическа сила');        
          ELSE    
           -- proverka za rykovodna dlyzjnost ot druga partia
            IF EXISTS(SELECT 1 
                          FROM n_lica_izbori i
                          WHERE i.Id_Sik  = @v_idsik
                            AND i.id_lice <> prmID
                            and i.id_sila <> prmIdSila
                            and i.Code_rolia = prmKODROL) THEN
                              
                SET retval     := '01';
                SET v_opisanie := CONCAT(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Заета длъжност от друга политическа сила');        
            END IF;      
          END IF;      
      END IF;      
    END IF;
  END IF;
  
  SET retval := CONCAT(retval,'|',v_opisanie);
  RETURN retval;  	
END;
//

DELIMITER //
