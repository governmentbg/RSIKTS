DROP FUNCTION IF EXISTS fnGetFullSikNumber;

DELIMITER //

CREATE FUNCTION `fnGetFullSikNumber`(prmToa varchar(2)) RETURNS varchar(10)
BEGIN
  DECLARE retval varchar(10) default ''  collate utf8_unicode_ci;
  
  SET NAMES 'utf8';
     
  SELECT VALUE
    INTO @v_izbalias
    FROM sys_main
    WHERE ID = 1;
  
  SET @v_izb_rajon = fnGetIzborenRajon(@v_izbalias,prmToa);
  
  SET retval = concat(@v_izb_rajon,'46',prmToa);      
  RETURN retval;  	
END;
//

DELIMITER //