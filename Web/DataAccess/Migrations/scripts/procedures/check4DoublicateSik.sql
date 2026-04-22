DROP PROCEDURE IF EXISTS check4DoublicateSik;

DELIMITER //

CREATE PROCEDURE check4DoublicateSik (prmSIK varchar(3),prmIzbAlias varchar(6), prmTUR int, prmTOA varchar(2), prmID int) 
BEGIN
  DECLARE retval integer default 0;
  
  if EXISTS (SELECT 1 
              FROM siks s
              WHERE s.ID_SEK <> prmID
                AND s.Izb_Alias = prmIzbAlias
                AND s.TUR = prmTUR
                AND s.TOA = prmToa
                AND s.Sik = prmSIK)
  THEN
    SET retval = -1;
  END IF;
  
  SELECT retval as Id;  	
END;
//

DELIMITER //
