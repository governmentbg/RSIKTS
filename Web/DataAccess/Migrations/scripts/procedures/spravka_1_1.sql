DROP PROCEDURE IF EXISTS spravka_1_1;

DELIMITER //

CREATE PROCEDURE spravka_1_1(
  prmIZB_R    varchar(2)
  ,prmUSER    varchar(128)
)
BEGIN   
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_1_1',prmIZB_R,'');

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);
    
  CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
      nkod varchar(2),
      name varchar(45)
  );

  SELECT Administrative_Rajon
    INTO @v_usertoa
    FROM aspnetusers
    WHERE Id = prmUSER;
  
  -- local user
  IF LENGTH(IFNULL(@v_usertoa, '')) > 0 THEN
      SELECT w1.NIME as nmizbrajon
            ,w3.NIME as nmrajon
            ,COUNT(distinct s.sik) total
            ,SUM(CASE WHEN s.Idcodeposition =101 THEN 1 ELSE 0 END) basic
            ,SUM(CASE WHEN s.Idcodeposition =102 THEN 1 ELSE 0 END) mobail
            ,SUM(CASE WHEN s.Idcodeposition =103 THEN 1 ELSE 0 END) official
            ,SUM(CASE WHEN s.Idcodeposition =104 THEN 1 ELSE 0 END) another
        FROM (SELECT s0.sik, s0.TOA, sv.Idcodeposition 
                            FROM siks s0 
                                  inner join siks_vidove sv on s0.Id_sek = sv.Id_Sik
                                  inner join n_list_codepositions cp on cp.NKODE = sv.Idcodeposition  and cp.PKODE=sv.Vid_codetable and cp.CALC=1
                            WHERE s0.Izb_Alias =@v_izbalias
                              and s0.TUR = @v_tur
                              and s0.TOA = @v_usertoa
                              and s0.Status_Sekcia=1) s 
              inner join wntoa w3 on s.TOA = w3.NKOD
              inner join wntoa_izbraion w2 on w3.NKOD = w2.NKOD
              inner join wnizbraion w1 on w2.izb_r = w1.nkod  and w1.status =1
        GROUP BY w3.NKOD
        ORDER BY w3.NKOD;  
  ELSE
      IF prmIZB_R = '00' THEN
        INSERT INTO tblizbr
            SELECT nkod, nime
              FROM wnizbraion 
              WHERE IZB_ALIAS = @v_izbalias
                AND STATUS=1;
      ELSE
          INSERT INTO tblizbr
              SELECT nkod, nime
                  FROM wnizbraion 
                  WHERE IZB_ALIAS = @v_izbalias
                    AND NKOD = prmIZB_R
                    AND STATUS=1;
      END IF;     

      SELECT w1.NIME as nmizbrajon
            ,w3.NIME as nmrajon
            ,COUNT(distinct s.sik) total
            ,SUM(CASE WHEN s.Idcodeposition =101 THEN 1 ELSE 0 END) basic
            ,SUM(CASE WHEN s.Idcodeposition =102 THEN 1 ELSE 0 END) mobail
            ,SUM(CASE WHEN s.Idcodeposition =103 THEN 1 ELSE 0 END) official
            ,SUM(CASE WHEN s.Idcodeposition =104 THEN 1 ELSE 0 END) another
        FROM tblizbr t 
              inner join wnizbraion w1 on t.nkod = w1.nkod and w1.status =1
              inner join wntoa_izbraion w2 on w2.izb_r = w1.nkod
              inner join wntoa w3 on w3.NKOD = w2.NKOD
              left join  (SELECT s0.sik, s0.TOA, sv.Idcodeposition 
                            FROM siks s0 
                                  inner join siks_vidove sv on s0.Id_sek = sv.Id_Sik
                                  inner join n_list_codepositions cp on cp.NKODE = sv.Idcodeposition  and cp.PKODE=sv.Vid_codetable and cp.CALC=1
                            WHERE s0.Izb_Alias =@v_izbalias
                              and s0.TUR =@v_tur
                              and s0.Status_Sekcia=1) s 
              on s.TOA = w3.NKOD                          
        GROUP BY w3.NKOD
        ORDER BY t.nkod, w3.NKOD;  
  END IF;    
  
  DROP TEMPORARY TABLE tblizbr;   
END;
//

DELIMITER ;	