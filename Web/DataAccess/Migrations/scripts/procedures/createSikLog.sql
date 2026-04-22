DROP PROCEDURE IF EXISTS createSikLog;

DELIMITER //

CREATE PROCEDURE createSikLog (
   prmUser          varchar(128) 
  ,prmToa           varchar(2)  
  ,prmSIK           varchar(10) 
  ,prmKOD           varchar(250) 
  ,prmDescriptipon  varchar(250) 
  ,prmOldVal        text 
  ,prmNewVal        text
)

BEGIN
    SET NAMES 'utf8';
 
    SELECT UserName
      INTO @v_username 
      FROM aspnetusers
      WHERE ID=prmUser;

    SET @v_username = IFNULL(@v_username ,concat('Грешен потребител: ','prmUser'));
    
    SELECT  NIME
      INTO @v_toaname
      FROM wntoa 
      WHERE NKOD = prmToa;
       
    INSERT INTO `n_log_sik_istoria` (`User`,  Koga, `TOA`,  `TOA_Tekst`,  `SIK`
                  ,`Kod_Obrabotka`,  `Kod_Tekst`,  `Pole_Bilo`,  `Pole_Stava`)
      VALUES (
        @v_username      
        ,NOW()
        ,prmToa
        ,@v_toaname
        ,prmSIK
        ,prmKOD 
        ,prmDescriptipon
        ,prmOldVal
        ,prmNewVal
      );

END
//

DELIMITER ;	
