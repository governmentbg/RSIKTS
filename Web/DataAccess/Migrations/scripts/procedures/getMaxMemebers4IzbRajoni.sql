DROP PROCEDURE IF EXISTS getMaxMemebers4IzbRajoni;

DELIMITER //

CREATE PROCEDURE getMaxMemebers4IzbRajoni (
  prmTOA varchar(2)
)

BEGIN
  SET NAMES 'utf8';
    
 SELECT VALUE
    INTO @v_izbalias
    FROM sys_main
    WHERE ID =1;
      
  SELECT w.MAX_BROI_SIK
     INTO @v_maxmembers
     FROM wnizbraion w inner join wntoa_izbraion w1 on w.NKOD = w1.IZB_R and w1.NKOD=prmTOA
     WHERE w.izb_alias = @v_izbalias
       AND w.status = 1;
       
  SELECT @v_maxmembers-3 as id;
END
//

DELIMITER ;	
