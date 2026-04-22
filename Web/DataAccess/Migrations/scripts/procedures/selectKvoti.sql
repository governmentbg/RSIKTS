DROP PROCEDURE IF EXISTS selectKvoti;

DELIMITER //

CREATE PROCEDURE selectKvoti (prmToa varchar(2))

BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

    SELECT MAX(IF(id=1,VALUE,''))
          ,MAX(IF(id=2,cast(value as unsigned integer),0))
      INTO @v_izbalias, @v_tur
      FROM sys_main
      WHERE ID in (1,2);

    SELECT  w.nkod
          ,w.nime
          ,SUM(IFNULL(n.SIK_Clenove,0)) as total
          ,SUM(IF(n.Code_rolia=401, n.SIK_Clenove,0)) as sum401
          ,SUM(IF(n.Code_rolia=402, n.SIK_Clenove,0)) as sum402
          ,SUM(IF(n.Code_rolia=403, n.SIK_Clenove,0)) as sum403
          ,SUM(IF(n.Code_rolia=404, n.SIK_Clenove,0)) as sum404
      FROM wnsila w 
             left join n_top_partkvoti n 
             on n.code_wnsila = w.nkod 
              and n.izb_alias = @v_izbalias
              AND n.TOA = prmTOA  
      WHERE w.izb_alias = @v_izbalias 
      and w.status_partii = 1        
      GROUP BY w.nkod;
              
END
//

DELIMITER ;	
