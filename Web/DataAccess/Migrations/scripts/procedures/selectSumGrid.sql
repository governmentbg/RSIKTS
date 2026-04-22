DROP PROCEDURE IF EXISTS selectSumGrid;

DELIMITER //

CREATE PROCEDURE selectSumGrid (prmToa varchar(2))

BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

    SELECT MAX(IF(id=1,VALUE,''))
          ,MAX(IF(id=2,cast(value as unsigned integer),0))
      INTO @v_izbalias, @v_tur
      FROM sys_main
      WHERE ID in (1,2);

    SELECT  w.nime
            ,MAX(IF(n1.Code_rolia=401 and w.nkod = n1.code_wnsila,cnt,0)) as cnt401
            ,MAX(IF(n2.Code_rolia=401 and w.nkod = n2.code_wnsila,n2.maxcnt,0)) as max401
            ,MAX(IF(n1.Code_rolia=402 and w.nkod = n1.code_wnsila,cnt,0)) as cnt402
            ,MAX(IF(n2.Code_rolia=402 and w.nkod = n2.code_wnsila,n2.maxcnt,0)) as max402
            ,MAX(IF(n1.Code_rolia=403 and w.nkod = n1.code_wnsila,cnt,0)) as cnt403
            ,MAX(IF(n2.Code_rolia=403 and w.nkod = n2.code_wnsila,n2.maxcnt,0)) as max403
            ,MAX(IF(n1.Code_rolia=404 and w.nkod = n1.code_wnsila,cnt,0)) as cnt404
            ,MAX(IF(n2.Code_rolia=404 and w.nkod = n2.code_wnsila,n2.maxcnt,0)) as max404
      FROM wnsila w
              left join (SELECT code_wnsila, Code_rolia, COUNT(Code_rolia) cnt 
                           FROM n_top_partgrid n inner join siks s on s.id_sek = n.id_sek
                           WHERE convert(s.sik, UNSIGNED INTEGER) > 0
                             AND s.Status_Sekcia=1
                             and n.TOA = prmTOA        
                             AND n.izb_alias= @v_izbalias 
                           GROUP BY code_wnsila, Code_rolia) n1
                on w.nkod = n1.code_wnsila 
              left join (SELECT code_wnsila, Code_rolia, SUM(SIK_Clenove) maxcnt 
                           FROM n_top_partkvoti
                           WHERE TOA = prmTOA        
                             AND izb_alias= @v_izbalias 
                           GROUP BY code_wnsila, Code_rolia) n2
                on w.nkod = n2.code_wnsila 
      WHERE w.izb_alias= @v_izbalias 
        AND w.Status_Partii = 1
      GROUP BY w.nkod  ;
END
//

DELIMITER ;	
