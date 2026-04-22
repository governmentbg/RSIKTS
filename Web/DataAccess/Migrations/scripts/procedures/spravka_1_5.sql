DROP PROCEDURE IF EXISTS spravka_1_5;

DELIMITER //

CREATE PROCEDURE spravka_1_5(
  prmTOA      varchar(2)
  ,prmBorders varchar(20)
  ,prmUSER    varchar(128)
)
BEGIN
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  call createLog (prmUSER, 3,'Справка','spravka_1_5',prmTOA,'');

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);
  
  IF convert(prmTOA, unsigned integer) > 0 THEN
      INSERT INTO tblvalues 
          SELECT id_sek 
            FROM siks s0
              inner join siks_vidove sv on s0.Id_sek = sv.Id_Sik
              inner join n_list_codepositions cp on cp.NKODE = sv.Idcodeposition  and cp.PKODE=sv.Vid_codetable and cp.CALC=1     
            WHERE s0.Izb_Alias = @v_izbalias
              AND s0.TUR = @v_tur
              AND s0.TOA = prmToa           
              AND s0.status_sekcia=1 ;
  ELSE  
      INSERT INTO tblvalues           
         SELECT s.id_sek
         FROM siks s 
              inner join siks_vidove sv on s.Id_sek = sv.Id_Sik
              inner join n_list_codepositions cp on cp.NKODE = sv.Idcodeposition  and cp.PKODE=sv.Vid_codetable and cp.CALC=1     
         WHERE s.Izb_Alias = @v_izbalias 
           AND s.TUR = @v_tur
           AND s.status_sekcia=1 ;
  END IF;

  IF LENGTH(prmBorders) > 0 THEN
     DELETE FROM tblvalues 
          WHERE ID NOT IN (SELECT id_sek FROM SIKS WHERE INSTR(borders,prmBorders) > 0);
  END IF;

  SET @row_number = 0;
  SELECT (@row_number:=@row_number + 1) AS Id        
        ,nmizbrajon
        ,nmrajon
        ,siknumb
        ,Borders
        ,NumbVoters
      FROM (SELECT 
              w8.nime as nmizbrajon
              ,w6.nime as nmrajon
              ,s.AA_BB_CC siknumb
              ,s.Borders
              ,s.NumbVoters
           FROM tblvalues t       
                INNER JOIN siks s ON s.id_sek = t.id
                inner join wntoa w6 on w6.nkod = s.toa
                inner join wntoa_izbraion w7 on w7.nkod = w6.nkod
                inner join wnizbraion w8 on w8.nkod = w7.izb_r and w8.status =1
            ORDER BY s.AA_BB_CC) x;

  DROP TEMPORARY TABLE tblvalues;
END;
//

DELIMITER ;