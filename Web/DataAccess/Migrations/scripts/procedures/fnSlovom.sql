DROP FUNCTION IF EXISTS fnSlovom;

DELIMITER //

CREATE FUNCTION fnSlovom (prmPari numeric(12,2)) RETURNS varchar(250)
BEGIN
  DECLARE retval varchar(250) default ''  collate utf8_unicode_ci;
  DECLARE v_counter int default 1;
  DECLARE v_finished INTEGER default 0;
  DECLARE v_number  char(3); 
  
  DECLARE numberCursor CURSOR FOR 
      SELECT pos, number FROM tblvalues ORDER BY pos desc;       
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished := 1;   

  SET NAMES 'utf8';
  CREATE TEMPORARY TABLE if not exists tblvalues (pos int NOT NULL AUTO_INCREMENT  PRIMARY KEY , number char(3));
  
  SET @vRest   := prmPari - FLOOR (prmPari); 
  SET @cNumber := TRIM(CAST(FLOOR (prmPari) as CHAR(50)));
  SET @cNumber := LPAD(@cNumber, 12, '0');
    
  SET v_counter := 1;
  WHILE v_counter < CHAR_LENGTH (@cNumber) do
    INSERT INTO tblvalues (number)
        VALUES (SUBSTRING(@cNumber,v_counter,3));
        
    SET v_counter=v_counter+3;
  END WHILE;

  OPEN numberCursor;
  REPEAT
      FETCH numberCursor INTO v_counter,v_number;
      IF NOT v_finished THEN

          SET @cTempStr  := '' collate utf8_unicode_ci;
          SET @cTempStr1 := '' collate utf8_unicode_ci;
          SET @cTempStr2 := '' collate utf8_unicode_ci;
          SET @cTempStr3 := '' collate utf8_unicode_ci;
         
          SET @tmpDigit  := SUBSTRING(v_number,1,1) collate utf8_unicode_ci;

          SET @cTempStr1 = fnSearchNumber(@tmpDigit);          
          SET @cTempStr1 = IF (@tmpDigit='1','сто',
                                              IF(@tmpDigit='0','', 
                                                               IF(CONVERT(@tmpDigit,UNSIGNED INTEGER)>3, 
                                                                              CONCAT(@cTempStr1,'стотин'),
                                                                              IF(@tmpDigit='2','двеста',CONCAT(@cTempStr1,'ста')))));

          IF SUBSTRING(v_number,2,1) = '1' THEN
              IF SUBSTRING(v_number,3,1) = '0' THEN
                SET @cTempStr2 := 'десет';
              ELSE
                SET @cTempStr2 :=  fnSearchNumber(SUBSTRING(v_number,3,1));                
                SET @cTempStr2 := IF(SUBSTRING(v_number,3,1)='1','единадесет',CONCAT(@cTempStr2,'надесет'));
              END IF;  
         ELSE
            SET @cTempStr2  := fnSearchNumber(SUBSTRING(v_number,2,1));                              
            SET @cTempStr2 := IF(IFNULL(@cTempStr2,'')='','',concat(@cTempStr2,'десет'));
            SET @cTempStr3 := fnSearchNumber(SUBSTRING(v_number,3,1));                              
         END IF;
  
         SET @cTempStr :=  CASE
                              WHEN IFNULL(concat(@cTempStr1,@cTempStr2,@cTempStr3),'')='' 
                                    THEN ''
                              WHEN IFNULL(concat(@cTempStr1,@cTempStr2),'')='' AND IFNULL(@cTempStr3,'')>''                                 
                                    THEN @cTempStr3
                              WHEN IFNULL(concat(@cTempStr1,@cTempStr3),'')='' AND IFNULL(@cTempStr2,'')>'' 
                                    THEN @cTempStr2
                              WHEN IFNULL(concat(@cTempStr2,@cTempStr3),'')='' AND IFNULL(@cTempStr1,'')>'' 
                                    THEN @cTempStr1
                              WHEN IFNULL(@cTempStr1,'')='' AND IFNULL(@cTempStr2,'')>'' AND IFNULL(@cTempStr3,'')>'' 
                                    THEN CONCAT(@cTempStr2,' и ',@cTempStr3)
                              WHEN IFNULL(@cTempStr2,'')='' AND IFNULL(@cTempStr1,'')>'' AND IFNULL(@cTempStr3,'')>'' 
                                    THEN CONCAT(@cTempStr1,' и ',@cTempStr3)
                              WHEN IFNULL(@cTempStr3,'')='' AND IFNULL(@cTempStr1,'')>'' AND IFNULL(@cTempStr2,'')>'' 
                                    THEN CONCAT(@cTempStr1,' и ',@cTempStr2)
                              ELSE
                                    CONCAT(@cTempStr1,' ',@cTempStr2, ' и ',@cTempStr3)
                            END;
     
         SET @cTempStr := CASE
                            WHEN v_counter = 1
                                 THEN IF (v_number='001',concat(@cTempStr,' милиард'),
                                                                    IF (v_number='000','',concat(@cTempStr,' милиарда')))
                            WHEN v_counter = 2
                                 THEN IF (v_number='001',concat(@cTempStr,' милион'),
                                                                    IF (v_number='000','',concat(@cTempStr,' милиона')))
                            WHEN v_counter = 3
                                 THEN CASE
                                        WHEN v_number = '000' THEN ''
                                        WHEN v_number = '001' THEN 'хиляда'
                                        WHEN v_number = '002' THEN 'две хиляди'
                                        ELSE concat(@cTempStr ,' хиляди')
                                      END     
                            ELSE @cTempStr          
                         END;
                         
         -- tyrsenoto v sys_numbers skapva handlera
         SET v_finished := 0;                    
   
         SET retval := concat(IF(IFNULL(@cTempStr,'')='','',concat(@cTempStr,' ')),retval);    
      END IF;
      
  UNTIL v_finished END REPEAT;   
  CLOSE numberCursor;
  
  SET retval := TRIM(retval);
  SET @cTempStr := TRIM(SUBSTRING_INDEX(retval, ' ', -1));

  IF @cTempStr not in ('','хиляди','милион','милиона','милиард','милиарда') THEN           
      SET @cTempStr := TRIM(SUBSTRING_INDEX(retval,' и ', -1));
  /*  
      IF NOT (RAT (' и ',cString1)+2 = RAT (' ',cString1)) THEN
         SET retval := LEFT (cString1,RAT (' ',cString1))+'и'+
                                     RIGHT(cString1,LEN (cString1)-RAT(' ',cString1)+1);
      END;              
  */    
  END IF;           

  SET retval := concat(retval,' евро');
  
  IF @vRest > 0 THEN
      SET retval := concat(retval,' и ',TRIM(cast((CAST(@vRest*100 as SIGNED )) as CHAR(10))),' цента');
  END IF;
  
  DROP TEMPORARY TABLE tblvalues; 
  RETURN retval;  	
END;
//

DELIMITER //
