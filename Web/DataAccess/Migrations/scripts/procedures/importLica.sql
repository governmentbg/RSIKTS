DROP PROCEDURE IF EXISTS importLica;

DELIMITER //

CREATE PROCEDURE importLica(
   prmUSER      varchar(128) 
   ,prmIzbAlias varchar(6)
   ,prmTur      int
   ,prmToa      varchar(2)
   ,prmIdSila   int
   ,prmDummy    varchar(30)
)
BEGIN
  DECLARE v_finished,v_IDIMP,v_impstatus,v_id INTEGER DEFAULT 0;
  DECLARE v_IM1, v_IM2, v_IM3, v_ROLJA, v_OBRA, v_SPEC, v_TEL, v_PAS1  varchar(100) DEFAULT "";
  DECLARE v_KODROL, v_KODSPEC, v_KODOBR, v_SIK varchar(10) DEFAULT "";
  DECLARE v_opisanie  varchar(1000) DEFAULT "";
  DECLARE v_egn varchar(10) DEFAULT "";
  DECLARE v_VIDID int DEFAULT -1;
  DECLARE v_cntall, v_cntadd,v_cntneval, v_cntothv int default 0;
  DECLARE prmIME varchar(250);
  DECLARE v_KODPAS1 varchar(1) DEFAULT "0";
  
   -- declare cursor for employee email
  DEClARE lica_cursor CURSOR FOR 
  SELECT i.ID, i.EGN, TRIM(i.IM1), TRIM(i.IM2), TRIM(i.IM3)
        , IFNULL(TRIM(i.SIK),''), i.ROLJA, i.OBRA, i.SPEC, i.TEL, IFNULL(l.id,0)
        , IFNULL(TRIM(i.PAS1),'')
    FROM n_lica_import i left join n_lica l on i.egn = l.egn
    WHERE i.USER = prmUSER 
      AND i.STATUS = 0;
         
   -- declare NOT FOUND handler
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;   
  
  SET NAMES 'utf8';
   
  SELECT COUNT(*)
      INTO v_cntothv    
      FROM n_lica_import i left join n_lica l on i.egn = l.egn
      WHERE i.USER = prmUSER 
        AND i.STATUS > 0;
  
  SET v_cntothv := IFNULL(v_cntothv,0);
  SET v_cntall := v_cntothv;
  
  OPEN lica_cursor;  
  read_loop: LOOP
    FETCH lica_cursor INTO v_IDIMP, v_egn, v_IM1, v_IM2, v_IM3, v_SIK, v_ROLJA, v_OBRA, v_SPEC, v_TEL,v_id, v_PAS1 ;
    IF  v_finished  THEN
        LEAVE read_loop;
    END IF;
    
    SET v_impstatus := 0;
    SET v_opisanie  := '';
    SET @v_idsik    := null;
    
    IF LENGTH(v_SIK) < 3 THEN
      SET v_SIK := LPAD(v_SIK, 3, '0');
    END IF; 

    SELECT Id_sek 
      INTO @v_idsik
      FROM siks
      WHERE sik = v_SIK
        AND IZB_ALIAS  = prmIzbAlias
        AND Toa = prmToa
        AND TUR = prmTUR
        AND (Status_Sekcia=1 OR v_SIK='000');

    -- ако не е намерена секциа в района
    IF IFNULL(@v_idsik,0) = 0 THEN
        SET v_impstatus := 2;
        SET v_opisanie  := 'Несъществуваща или неактивна секция';
    END IF;

    IF LENGTH(IFNULL(v_IM1,'')) = 0 THEN
        SET v_impstatus := 2;
        SET v_opisanie  := concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Няма име');
    ELSE
        IF (SELECT v_IM1 REGEXP "^[а-яА-Я- ]+(([а-яА-Я- ])?[а-яА-Я- ]*)*$") = 0 THEN
            SET v_impstatus := 2;
            SET v_opisanie  :=  concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Името съдържа непозволени символи');
        END IF;
    END IF;

/* не е задължително
    IF LENGTH(IFNULL(v_IM2,'')) = 0 THEN
        SET v_impstatus := 9;
        SET v_opisanie  := 'Няма презиме';
    END IF;
*/
    IF LENGTH(IFNULL(v_IM2,'')) > 0 THEN
      IF (SELECT v_IM2 REGEXP "^[а-яА-Я- ]+(([а-яА-Я- ])?[а-яА-Я- ]*)*$") = 0 THEN
          SET v_impstatus := 2;
          SET v_opisanie  :=  concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Презимето съдържа непозволени символи');
      END IF;
    END IF;
    
    IF LENGTH(IFNULL(v_IM3,'')) = 0 THEN
        SET v_impstatus := 2;
        SET v_opisanie  :=  concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Няма фамилия');
    ELSE
        IF (SELECT v_IM3 REGEXP "^[а-яА-Я- ]+(([а-яА-Я- ])?[а-яА-Я- ]*)*$") = 0 THEN
            SET v_impstatus := 2;
            SET v_opisanie  :=  concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Фамилията съдържа непозволени символи');
        END IF;
    END IF;
     
    -- proverka za korektno EGN
    IF checkNumber(0, v_egn) = 0 THEN
        SET v_VIDID := 0;
/*
    ELSE
      -- proverka za korektno LNCH
      IF checkNumber(2, v_egn) = 0 THEN
          SET v_VIDID := 2;
      END IF;
*/      
    END IF;  
    
    SET @v_fullsikcode = '';
    
    SELECT CONCAT(s.AA_BB_CC, ' ', w.Short_name)
       INTO @v_fullsikcode
       FROM n_lica l
            left join n_lica_izbori i on l.id = i.id_lice
                inner join wnsila w on w.ID_Party = i.id_sila
                inner join siks s on i.id_sik = s.Id_sek
       WHERE l.id <> v_id
         and l.Vid_id = v_VIDID 
         and AES_DECRYPT(FROM_BASE64(l.EGN),prmDummy)=v_egn
         and (s.TOA = prmToa OR (s.sik != '000' and s.TOA != prmToa))
       LIMIT 1;                  
       
    IF LENGTH(IFNULL (@v_fullsikcode,''))>0 THEN
        SET v_impstatus := 2;
        SET v_opisanie  := concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Дублирано ЕГН (',@v_fullsikcode,')');
    ELSE    
        IF v_VIDID = -1 THEN
            SET v_impstatus := 2;
            SET v_opisanie  :=  concat(v_opisanie,IF(length(v_opisanie)>0,', ',''),'Грешно ЕГН');
        END IF;
    END IF;

    IF v_impstatus = 0 THEN
        SET @v_idnullsik := null;
        
        -- izbirame 0-a SIK za rajona
        SELECT Id_sek 
          INTO @v_idnullsik
          FROM siks
          WHERE sik = '000'
            AND Izb_Alias  = prmIzbAlias
            AND Toa = prmToa
            AND TUR = prmTUR;

        -- ako nqma nulewa sekciq se syzdawa
        IF IFNULL(@v_idnullsik,'') = '' THEN            
            INSERT INTO siks (Izb_Alias,TUR,Izb_rajon,TOA,AA_BB_CC,Sik,
                              Obl,Obs,NAS,JK_KV,UL,Nom,BLok,ADR_IME,USER,KOGA,Status_Sekcia,
                              broimembers, numbvoters, borders)
            VALUES (prmIzbAlias
                    ,prmTUR
                    ,fnGetIzborenRajon(prmIzbAlias,prmTOA)
                    ,prmTOA
                    ,CONCAT(fnGetFullSikNumber(prmTOA),'000')
                    ,'000'
                    ,'SOF'
                    ,'SOF46'
                    ,'68134'
                    ,null
                    ,null
                    ,null
                    ,null
                    ,null
                    ,prmUSER
                    ,now()
                    ,1
                    ,0
                    ,0
                    ,''
                );
            
           SELECT LAST_INSERT_ID() INTO @v_idnullsik FROM DUAL; 
           
           INSERT INTO siks_vidove (`IZB_allias`,`Tur`,`Id_Sik`,`Vid_codetable`,`Idcodeposition`,`Status`)
                VALUES (prmIzbAlias,prmTOA,@v_idnullsik,1,'100',1);
           
           call createSikLog (prmUser, prmTOA, CONCAT(fnGetFullSikNumber(prmTOA),'000'), 12, 'Нова','','');
        END IF;
                
        -- новото поле
        SET v_KODPAS1 = '0';
        IF v_PAS1 = 'Ваксиниран' THEN
          SET v_KODPAS1 = '1';
        ELSE
          IF v_PAS1 = 'Желае ваксина' THEN
             SET v_KODPAS1 = '2';
          ELSE
            IF v_PAS1 = 'Не желае' THEN
               SET v_KODPAS1 = '3';
            END IF;
          END IF;  
        END IF;
        
        SET v_KODROL = '';    
        SELECT NKODE INTO v_KODROL 
          FROM n_list_codepositions
          WHERE PKODE = '4'
             AND IZB_ALLIAS  = prmIzbAlias
             AND UPPER(NIME) = UPPER(v_ROLJA);
          
        SET v_KODSPEC  = '';  
        SELECT NKOD INTO v_KODSPEC 
          FROM wnspec
          WHERE UPPER(NIME) = UPPER(v_SPEC);

        SET v_KODOBR = '';
        SELECT NKOD INTO v_KODOBR 
          FROM wnszem
          WHERE UPPER(NIME) = UPPER(v_OBRA);
              
        SET v_opisanie  := fnCheckLica (0,prmIzbAlias,prmToa,prmTur,v_id,v_VIDID,v_egn,prmIdSila,v_SIK,v_KODROL,v_SPEC,v_OBRA,prmDummy,0);

        SET @v_error := CAST(LEFT(v_opisanie,2) as unsigned);

        IF @v_error > 0 THEN
          IF @v_error > 10 THEN
            SET v_impstatus := 2;            
          ELSE
            SET v_impstatus := 1;
          END IF;
        END IF;
        
   
        SET v_opisanie := SUBSTRING(v_opisanie,4);

        IF v_impstatus = 2 THEN
            SET v_cntneval = v_cntneval+1;                        
        ELSE
          -- if person exists i njama greshni danni, update  
      	  IF v_id > 0 THEN
             IF v_impstatus=0 THEN  
               SET v_cntadd = v_cntadd+1;
               
               UPDATE n_lica 
                  SET  Vid_id  = v_VIDID
                      ,EGN    = TO_BASE64(AES_ENCRYPT(v_egn,prmDummy))
                      ,IM1    = TO_BASE64(AES_ENCRYPT(UPPER(v_IM1),prmDummy))
                      ,IM2    = TO_BASE64(AES_ENCRYPT(UPPER(v_IM2),prmDummy))
                      ,IM3    = TO_BASE64(AES_ENCRYPT(UPPER(v_IM3),prmDummy))
                      ,Obra   = v_KODOBR
                      ,Spec   = v_KODSPEC
                      ,TEL    = v_TEL
                      ,PAS1   = v_KODPAS1
                      ,impstatus  = v_impstatus
                      ,impmessage = v_opisanie
                      ,USER   = prmUSER
                      ,KOGA   = now()
                  WHERE ID = v_id;
              
               UPDATE n_lica_izbori
                  SET Id_Sik=@v_idsik
                     ,id_sila=prmIdSila
                     ,Code_rolia=v_KODROL
                     ,KOGA=now()        
                  where id_lice = v_id 
                    and Izb_Alias = prmIzbAlias
                    and TUR = prmTur;    
                                                    
                DELETE FROM  N_LICA_DOPYLNENIE 
                    WHERE Id_Lice = v_id;
                
                IF v_KODPAS1 <> '0' THEN
                  INSERT INTO N_LICA_DOPYLNENIE (`Id_Lice`, `VidCodetable`,`Idcodeposition`,`Status`,`User`,`Koga`)
                      VALUES(v_id,3,IF(v_KODPAS1='2','305',IF(v_KODPAS1='3','306','304')),1,prmUSER,now() );
                END IF;                    
/*                
                SET prmIme =  CONCAT(TO_BASE64(AES_ENCRYPT(UPPER(v_IM1),prmDummy)),' ',
                                   IFNULL(TO_BASE64(AES_ENCRYPT(UPPER(v_IM2),prmDummy)),''),' ',
                                   IFNULL(TO_BASE64(AES_ENCRYPT(UPPER(v_IM3),prmDummy)),''));
                
                call createLog (prmUSER, 1,'Редактиране',CONCAT(prmIme,' [',v_id,']'),IFNULL(prmToa,''),'импорт');                
*/
             ELSE
                SET v_cntothv = v_cntothv+1;                 
             END IF;
          ELSE
              IF v_impstatus=0 THEN  
                SET v_cntadd = v_cntadd+1;
              ELSE 
                SET v_cntothv = v_cntothv+1; 
              END IF;
              
              INSERT INTO n_lica (VID_ID,EGN,IM1,IM2 ,IM3,Obra,Spec,TEL,PAS1,impstatus,impmessage,USER,KOGA)
                      VALUES (
                        v_VIDID
                        ,TO_BASE64(AES_ENCRYPT(v_egn,prmDummy))
                        ,TO_BASE64(AES_ENCRYPT(UPPER(v_IM1),prmDummy))
                        ,TO_BASE64(AES_ENCRYPT(UPPER(v_IM2),prmDummy))
                        ,TO_BASE64(AES_ENCRYPT(UPPER(v_IM3),prmDummy))
                        ,v_KODOBR
                        ,v_KODSPEC
                        ,v_TEL
                        ,v_KODPAS1
                        ,v_impstatus
                        ,v_opisanie
                        ,prmUSER
                        ,now()
                      );
             
              SELECT LAST_INSERT_ID() INTO v_id FROM DUAL;    
                            
              IF v_id > 0 THEN
                INSERT INTO n_lica_izbori (ID_Lice,Izb_Alias,Tur,TOA,Id_Sik,id_sila,Re,Code_rolia,Ime_rolia,hasmaxincome,USER,KOGA)
                    VALUES (v_id,prmIzbAlias, prmTur, prmToa
                            ,IF(v_impstatus=1,@v_idnullsik,@v_idsik)
                            ,prmIdSila, '', v_KODROL, '',0,prmUser, now());
                
                IF v_KODPAS1 <> '0' THEN
                  SELECT LAST_INSERT_ID() INTO v_id FROM DUAL;    
                  
                  INSERT INTO N_LICA_DOPYLNENIE (`Id_Lice`, `VidCodetable`,`Idcodeposition`,`Status`,`User`,`Koga`)
                      VALUES(v_id,3,IF(v_KODPAS1='2','305',IF(v_KODPAS1='3','306','304')),1,prmUSER,now() );
                END IF;                    
              
              END IF;
/*
              SET prmIme =  CONCAT(TO_BASE64(AES_ENCRYPT(UPPER(v_IM1),prmDummy)),' ',
                                 IFNULL(TO_BASE64(AES_ENCRYPT(UPPER(v_IM2),prmDummy)),''),' ',
                                 IFNULL(TO_BASE64(AES_ENCRYPT(UPPER(v_IM3),prmDummy)),''));
              
              call createLog (prmUSER, 1,'Ново лице',CONCAT(prmIme,' [',v_id,']'),IFNULL(prmToa,''),'импорт');                
*/
          END IF;                           
        END IF;
    ELSE
        SET v_cntneval = v_cntneval+1;                        
    END IF;
    
    SET v_cntall = v_cntall+1;
    
    UPDATE n_lica_import
        SET opisanie = v_opisanie, status = 1+v_impstatus
        WHERE ID = v_IDIMP;
    
    SET v_finished = 0;  
    
  END LOOP read_loop;
  CLOSE lica_cursor;       
  
  SELECT concat("Обработени: "
                ,cast(v_cntall as char)
                ,' записа, Добавени: '
                ,cast(v_cntadd as char)
                ,' записа, Отхвърлени: '
                ,cast(v_cntneval as char)
                ,' записа, Невалидни: '
                ,cast(v_cntothv as char)
                ,' записа')  as ImpExcelMessage
        ,v_cntothv+v_cntneval as wrongRec ;  
END;
//

DELIMITER ;	