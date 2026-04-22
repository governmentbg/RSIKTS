DROP PROCEDURE IF EXISTS getIzbRajoni;

DELIMITER //

CREATE PROCEDURE getIzbRajoni (prmIizbAlias varchar(6))

BEGIN
  SET NAMES 'utf8';
  
  SELECT NKOD, NIME
     FROM wnizbraion
     WHERE IZB_ALIAS = prmIizbAlias
       AND status = 1;
       
END
//

DELIMITER ;	
