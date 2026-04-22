DROP PROCEDURE IF EXISTS checkBulstat;

DELIMITER //

CREATE PROCEDURE checkBulstat (
    prmBulstat   varchar(13)
)

BEGIN
  SET NAMES 'utf8';  
  SET @retval = checkNumber (3,prmBulstat);
  
  SELECT @retval as id;
END;
//

DELIMITER //
