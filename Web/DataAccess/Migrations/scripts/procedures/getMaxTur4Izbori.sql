DROP PROCEDURE IF EXISTS getMaxTur4Izbori;

DELIMITER //

CREATE PROCEDURE getMaxTur4Izbori ()

BEGIN
  SET NAMES 'utf8';
    
 SELECT MAX(IF(id=1,VALUE,''))
    INTO @v_izbalias
    FROM sys_main
    WHERE ID in (1,2);
      
  SELECT TUR
     INTO @v_maxtur
     FROM wntipizbori
     WHERE nkod = LEFT(@v_izbalias,2)
       AND status = 1;
       
  SELECT @v_maxtur as id;
END
//

DELIMITER ;	
