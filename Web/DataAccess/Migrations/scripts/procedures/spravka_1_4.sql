DROP PROCEDURE IF EXISTS spravka_1_4;

DELIMITER //

CREATE PROCEDURE spravka_1_4 (
  prmIZB_R    varchar(2)
  ,prmTOA     varchar(2)
  ,prmUSER    varchar(128)
)
BEGIN
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
      nkod varchar(2),
      name varchar(45)
  );

  CREATE TEMPORARY TABLE if not exists tblvalues (id int, sumvoter int);
  
  IF convert(prmTOA, unsigned integer) > 0 THEN
      INSERT INTO tblvalues 
          SELECT s0.id_sek, sum(Voter_number) 
            FROM siks s0
              inner join siks_vidove sv on s0.Id_sek = sv.Id_Sik AND sv.Idcodeposition  = 102
              inner join siks_podvijni sp on sp.id_sik = s0.id_sek
            WHERE s0.Izb_Alias = @v_izbalias
              AND s0.TUR = @v_tur
              AND s0.Status_Sekcia=1
              AND sp.TOA = prmToa
            GROUP BY s0.id_sek;
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
  
    INSERT INTO tblvalues           
       SELECT s.id_sek, sum(Voter_number)
       FROM siks s 
            inner join siks_vidove sv on s.Id_sek = sv.Id_Sik AND sv.Idcodeposition  = 102
            inner join siks_podvijni sp on sp.id_sik = s.id_sek
       WHERE sp.TOA IN (SELECT w1.NKOD 
                          FROM tblizbr t
                                INNER JOIN wntoa_izbraion w1 ON t.nkod = w1.IZB_R)    
          AND s.Izb_Alias = @v_izbalias 
          AND s.TUR = @v_tur
          AND s.Status_Sekcia=1
       GROUP BY s.id_sek;
  END IF;

  DROP TEMPORARY TABLE tblizbr;

  SET @row_number = 0;
  
  SELECT 
      (@row_number:=@row_number + 1) AS Id 
      ,w8.nime as nmizbrajon
      ,w6.nime as nmrajon
      ,t.sumvoter
      ,s.AA_BB_CC as siknumb
      ,fnGetSikAddress(t.id) as address
      ,w1.nime obsrajon
      ,sp.Voter_number voters
   FROM tblvalues t       
        INNER JOIN siks s ON s.id_sek = t.id
        inner join siks_podvijni sp on sp.id_sik = t.id
        inner join wntoa w1 on w1.nkod = sp.toa             -- obsluzjvashti rajoni
        inner join wntoa w6 on w6.nkod = s.toa              -- sik adm. rajon
        inner join wntoa_izbraion w7 on w7.nkod = w6.nkod
        inner join wnizbraion w8 on w8.nkod = w7.izb_r and w8.status =1
    ORDER BY w8.NKOD,w6.NKOD ,5, sp.Voter_number desc;

  DROP TEMPORARY TABLE tblvalues;
END;
//

DELIMITER ;