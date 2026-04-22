DROP PROCEDURE IF EXISTS deleteImportLica;

DELIMITER //

CREATE PROCEDURE deleteImportLica(
   prmUSER      varchar(128) 
)
BEGIN
  DELETE FROM n_lica_import  WHERE USER = prmUSER;      
  SELECT 0 as ID ;  
END;
//

DELIMITER ;	