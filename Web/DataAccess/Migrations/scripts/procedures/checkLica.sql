DROP PROCEDURE IF EXISTS checkLica;

DELIMITER //

CREATE PROCEDURE checkLica (
    prmIzbAlias   varchar(6)
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
    ,prmIdReplace int  
)

BEGIN
  DECLARE v_opisanie varchar(250) default ''  collate utf8_unicode_ci;
  
  SET CHARSET "utf8";
    
  SET v_opisanie  := fnCheckLica (1
                                  ,prmIzbAlias  
                                  ,prmToa       
                                  ,prmTur       
                                  ,prmID        
                                  ,prmVIDID     
                                  ,prmEgn       
                                  ,prmIdSila    
                                  ,prmSIK       
                                  ,prmKODROL    
                                  ,prmKODSPEC   
                                  ,prmKODOBR    
                                  ,prmDummy
                                  ,prmIdReplace
                              );
   
  
  SELECT v_opisanie as impmessage;
END;
//

DELIMITER //
