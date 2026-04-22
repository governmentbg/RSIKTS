DROP PROCEDURE IF EXISTS spravka_1_2;

DELIMITER //

CREATE PROCEDURE spravka_1_2(
  prmIZB_R    varchar(2)
  ,prmTOA     varchar(2)
  ,prmUSER    varchar(128)
  ,prmSIKS    varchar(250)
)
BEGIN
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  call createLog (prmUSER, 3,'Справка','spravka_1_2',prmTOA,'');

  CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
      nkod varchar(2),
      name varchar(45)
  );

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);
  
  IF LENGTH(prmSIKS) > 0 THEN
    CREATE TEMPORARY TABLE if not exists tblsiks (sik varchar(3));

    SET @Values = prmSIKS;
    WHILE (LOCATE(',', @Values) > 0)
    DO
        SET @value = ELT(1, @Values);
        SET @Values= SUBSTRING(@Values, LOCATE(',',@Values) + 1);

        INSERT INTO tblsiks VALUES(@value);
    END WHILE;

    SET @value = ELT(1, @Values);
    INSERT INTO tblsiks VALUES(@value);

    INSERT INTO tblvalues 
        SELECT s.id_sek 
          FROM siks s inner join tblsiks t ON s.sik = t.sik
          WHERE s.Izb_Alias = @v_izbalias
            AND s.TUR =  @v_tur
            AND s.TOA = prmToa;   
            
    DROP TEMPORARY TABLE tblsiks; 
  
  ELSE
      IF convert(prmTOA, unsigned integer) > 0 THEN
          INSERT INTO tblvalues 
              SELECT id_sek 
                FROM siks s0
                  inner join siks_vidove sv on s0.Id_sek = sv.Id_Sik
                  inner join n_list_codepositions cp on cp.NKODE = sv.Idcodeposition  and cp.PKODE=sv.Vid_codetable and cp.CALC=1     
                WHERE s0.Izb_Alias = @v_izbalias
                  AND s0.TUR = @v_tur
                  AND s0.TOA = prmToa
                  AND s0.Status_Sekcia = 1;               
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
           SELECT s.id_sek
           FROM tblizbr t
                INNER JOIN wntoa_izbraion w1 ON t.nkod = w1.IZB_R
                INNER JOIN siks s ON s.TOA = w1.NKOD 
                    AND s.Izb_Alias = @v_izbalias 
                    AND s.TUR = @v_tur
                inner join siks_vidove sv on s.Id_sek = sv.Id_Sik
                inner join n_list_codepositions cp on cp.NKODE = sv.Idcodeposition  and cp.PKODE=sv.Vid_codetable and cp.CALC=1
           WHERE s.Status_Sekcia=1;     
      END IF;

      DROP TEMPORARY TABLE tblizbr;
  END IF; 

  SELECT 
      t.id
      ,w8.nime as nmizbrajon
      ,w6.nime as nmrajon
      ,s.AA_BB_CC siknumb
      ,fnGetSikAddress(t.id) as address
      ,v.vid
      ,IFNULL(v.priznak,'') priznak
      ,IF(IFNULL(cntmembers,0)=0,"Няма",IF(s.broimembers > cntmembers,"Недостатъчен",IF(cntmembers>s.broimembers,"Надвишен","OK"))) control
      ,IF(s.Status_Sekcia=1,"Активна","Неактивна") as status
      ,IFNULL(s.adr_ime,'') as descript           
   FROM tblvalues t       
        INNER JOIN siks s ON s.id_sek = t.id
        inner join (SELECT id_sik
                           ,GROUP_CONCAT(c1.nime) vid
                           ,GROUP_CONCAT(c2.nime) priznak
                      FROM siks_vidove v
                             left join n_list_codepositions c1 on c1.NKODE = v.Idcodeposition and c1.PKODE=1
                             left join n_list_codepositions c2 on c2.NKODE = v.Idcodeposition and c2.PKODE=2
                      GROUP BY id_sik) v
            on v.Id_Sik = s.Id_sek  
        inner join wntoa w6 on w6.nkod = s.toa
        inner join wntoa_izbraion w7 on w7.nkod = w6.nkod
        inner join wnizbraion w8 on w8.nkod = w7.izb_r and w8.status =1
        left join (SELECT id_sik, count(id_lice) cntmembers 
                      FROM n_lica_izbori 
                      WHERE Code_rolia < 410
                      group by ID_SIK ) i on i.id_sik = t.id
    ORDER BY w8.NKOD,w6.NKOD,4;

  DROP TEMPORARY TABLE tblvalues;
END;
//

DELIMITER ;