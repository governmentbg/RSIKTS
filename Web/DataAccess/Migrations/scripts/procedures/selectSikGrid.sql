DROP PROCEDURE IF EXISTS selectSikGrid;

DELIMITER //

CREATE PROCEDURE selectSikGrid (prmSik int)

BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

    SELECT w.NKOD
          ,w.NIME
          ,SUM(IF(IFNULL(n.code_rolia,0) between 401 and 403,1,0)) as cntheadmembers
          ,SUM(IF(LENGTH(IFNULL(n.code_wnsila,""))>0,1,0)) as cntmembers
      FROM wnsila w 
             left join n_top_partgrid n on n.code_wnsila = w.NKOD and n.id_sek = prmSik
      WHERE w.status_partii = 1
      GROUP BY w.nkod;
       
END
//

DELIMITER ;	
