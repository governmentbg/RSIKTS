DROP PROCEDURE IF EXISTS spravka_9_2;

DELIMITER //

CREATE PROCEDURE spravka_9_2(
  prmIZB_R      varchar(2)
  ,prmToa       varchar(2)
  ,prmDate1     datetime
  ,prmDate2     datetime
  ,prmUSER      varchar(128)
)
BEGIN   
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
    INTO @v_izbalias
    FROM sys_main
    WHERE ID = 1;
   
  DROP TEMPORARY TABLE if exists tblizbr; 
   
  CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
      nkod varchar(2),
      name varchar(45)
  );

  IF IFNULL(prmToa,'00') <> '00' THEN
    INSERT INTO tblizbr
        SELECT w2.nkod, w1.nime
          FROM wnizbraion w1 inner join wntoa_izbraion w2 on w1.NKOD = w2.IZB_R 
          WHERE w2.NKOD = prmToa
           AND w1.STATUS= 1;    
  ELSE
    IF prmIZB_R = '00' THEN
      INSERT INTO tblizbr
          SELECT w2.nkod, w1.nime
            FROM wnizbraion w1 inner join wntoa_izbraion w2 on w1.NKOD = w2.IZB_R 
            WHERE w1.IZB_ALIAS = @v_izbalias
              AND w1.STATUS=1;
    ELSE
        INSERT INTO tblizbr
            SELECT w2.nkod, w1.nime
                FROM wnizbraion w1 inner join wntoa_izbraion w2 on w1.NKOD = w2.IZB_R 
                WHERE w1.IZB_ALIAS = @v_izbalias
                  AND w1.NKOD = prmIZB_R
                  AND w1.STATUS=1;
    END IF;     
  END IF;
  
  SET @row_number = 0;

  SELECT 
       (@row_number:=@row_number + 1) AS Id 
        ,t.name as NmIzbRajon
        ,w3.NIME as NmRajon
      	,Koga
        ,USER
      	,TOA
      	,SIK
      	,Kod_Obrabotka as KodObr
      	,Kod_Tekst  as KodText
      	,Pole_Bilo  as OldVal
      	,Pole_Stava as NewVal
   FROM tblizbr t 
        inner join wntoa w3 on w3.NKOD = t.NKOD
        inner join n_log_sik_istoria l on l.TOA = w3.NKOD
   WHERE DATE(l.Koga) between prmDate1 and prmDate2    
   ORDER BY t.name, w3.nkod, SIK, Koga DESC;  
 END;
//

DELIMITER ;	