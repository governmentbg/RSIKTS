DROP PROCEDURE IF EXISTS getSikAddress;

DELIMITER //

CREATE PROCEDURE getSikAddress(
  prmSIKS    int
)
BEGIN
  SET NAMES 'utf8';
   
  SELECT fnGetSikAddress(prmSIKS) as address;
END;
//

DELIMITER ;