DROP PROCEDURE IF EXISTS createLog;

DELIMITER //

/*
  prmACTION 
    1- lica
    2- siks
    3- sprawki
    4- kalkulacii
    5- master (toamain)
*/

CREATE PROCEDURE createLog (
   prmUser          varchar(128) 
  ,prmACTION        int
  ,prmKOD           varchar(250) 
  ,prmDescriptipon  varchar(250) 
  ,prmToa           varchar(2)  
  ,prmAA            varchar(250)
)

BEGIN
    SET NAMES 'utf8';
 
    SELECT UserName
      INTO @v_username 
      FROM aspnetusers
      WHERE ID=prmUser;

    SET @v_username = IFNULL(@v_username ,concat('Грешен потребител: ','prmUser'));
    
    SELECT  NIME
      INTO @v_action
      FROM wntoa 
      WHERE NKOD = prmToa;
        
    IF @v_action is null THEN
      SELECT w.nime
        INTO @v_action
        FROM sys_usermain s inner join wntoa w on s.Value = w.NKOD and s.Name='TOA'
        WHERE User=prmUser;
    END IF;
    
    CASE prmACTION
      WHEN 1 THEN      
              INSERT INTO `n_log_lica` (`User`,  Koga, `ACTION`,  `Kod_Obrabotka`,  `Ime_Obrabotka`)
                VALUES (
                  @v_username      
                  ,NOW()
                  ,IFNULL(@v_action,'')
                  ,prmKOD
                  ,IFNULL(prmDescriptipon,'')
                );
      WHEN 3 THEN      
              INSERT INTO `n_log_dokumenti` (`User`,  Koga, `ACTION`,  `Kod_Obrabotka`,  `Ime_Obrabotka`)
                VALUES (
                  @v_username      
                  ,NOW()
                  ,IFNULL(@v_action,'')
                  ,prmKOD 
                  ,IFNULL(prmDescriptipon,'')
                );
                
      WHEN 4 THEN      
              INSERT INTO `n_log_deinosti` (`User`,  Koga, `ACTION`,  `Kod_Obrabotka`,  `Ime_Obrabotka`, `AAA`)
                VALUES (
                  @v_username      
                  ,NOW()
                  ,IFNULL(@v_action,'')
                  ,prmKOD 
                  ,IFNULL(prmDescriptipon,'')
                  ,prmAA
                );
      ELSE          
          BEGIN
              INSERT INTO `n_log` (`User`,  Koga, `ACTION`,  `Kod_Obrabotka`,  `Ime_Obrabotka`, `AAA`)
                VALUES (
                  @v_username      
                  ,NOW()
                  ,IFNULL(@v_action,'')
                  ,prmKOD 
                  ,IFNULL(prmDescriptipon,'')
                  ,prmAA
                );
          END;
    END CASE;      
END
//

DELIMITER ;	
