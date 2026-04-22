DROP PROCEDURE IF EXISTS selectGrid;

DELIMITER //

CREATE PROCEDURE selectGrid (prmToa varchar(2))

BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

    SELECT  s.id_sek 
          ,s.AA_BB_CC as sikfullcode
          ,MAX(IF(n.Code_rolia=401,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum401
          ,SUM(IF(n.Code_rolia=401 and LENGTH(n.code_wnsila)>0,1,0)) as cnt401
          ,MAX(IF(n.Code_rolia=402,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum402
          ,SUM(IF(n.Code_rolia=402 and LENGTH(n.code_wnsila)>0,1,0)) as cnt402
          ,MAX(IF(n.Code_rolia=403,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum403
          ,SUM(IF(n.Code_rolia=403 and LENGTH(n.code_wnsila)>0,1,0)) as cnt403
          ,MAX(IF(n.Code_rolia=404 AND n.order_rolja=1,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum404_1
          ,MAX(IF(n.Code_rolia=404 AND n.order_rolja=2,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum404_2
          ,MAX(IF(n.Code_rolia=404 AND n.order_rolja=3,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum404_3
          ,MAX(IF(n.Code_rolia=404 AND n.order_rolja=4,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum404_4
          ,MAX(IF(n.Code_rolia=404 AND n.order_rolja=5,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum404_5
          ,MAX(IF(n.Code_rolia=404 AND n.order_rolja=6,(SELECT Short_name FROM wnsila where nkod = n.code_wnsila),"")) as sum404_6
          ,SUM(IF(n.Code_rolia=404 and LENGTH(n.code_wnsila)>0,1,0)) as cnt404
      FROM siks s 
             left join n_top_partgrid n on n.id_sek = s.id_sek 
      WHERE s.TOA = prmTOA 
        AND convert(s.sik, UNSIGNED INTEGER) > 0
        AND s.Status_Sekcia = 1        
      GROUP BY s.AA_BB_CC;
       
END
//

DELIMITER ;	
