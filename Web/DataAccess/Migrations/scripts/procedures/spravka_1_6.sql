DROP PROCEDURE IF EXISTS spravka_1_6;

DELIMITER //

CREATE PROCEDURE spravka_1_6(
  prmIZB_R        varchar(2)
  ,prmDeinost     varchar(20)
  ,prmTOA         varchar(2)
  ,prmDummy       varchar(128)
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
  
  CREATE TEMPORARY TABLE if not exists tblcodes (nkod int);
  CREATE TEMPORARY TABLE if not exists tblvalues (id int, fullsikcode varchar(10));
  
  SET @Values = prmDeinost;
  WHILE (LOCATE(',', @Values) > 0)
  DO
      SET @value = ELT(1, @Values);
      SET @Values= SUBSTRING(@Values, LOCATE(',',@Values) + 1);

      INSERT INTO tblcodes VALUES(cast(@value as UNSIGNED));
  END WHILE;

  SET @value = ELT(1, @Values);
  INSERT INTO tblcodes VALUES(cast(@value as UNSIGNED));

  IF convert(prmTOA, unsigned integer) > 0 THEN
      INSERT INTO tblvalues 
          SELECT distinct id_sek, aa_bb_cc 
            FROM siks s0
            WHERE s0.Izb_Alias = @v_izbalias
              AND s0.TUR = @v_tur
              AND s0.TOA = prmToa           
              AND s0.status_sekcia=1 ;
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
           SELECT distinct s.id_sek, s.aa_bb_cc
           FROM tblizbr t
                INNER JOIN wntoa_izbraion w1 ON t.nkod = w1.IZB_R
                INNER JOIN siks s ON s.TOA = w1.NKOD 
                    AND s.Izb_Alias = @v_izbalias 
                    AND s.TUR = @v_tur
           WHERE s.Status_Sekcia=1;      
  END IF;

  select DISTINCT        
        '' as NmIzbRajon
        ,w1.NIME as NmRajon
        ,l.id
        ,CAST(AES_DECRYPT(FROM_BASE64(l.egn),prmDummy) as CHAR(50)) as EGN
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l.im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l.im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l.im3),prmDummy) as CHAR(50)),'')) as ime
        ,s.fullsikcode as SikNumb
        ,l.TEL as Telefon
        ,n.NIME as Deinost
        ,w1.NKOD as TOA
  from n_lica l 
        inner join n_lica_izbori i on l.ID = i.ID_Lice
        inner join n_lica_dopylnenie d on i.ID = d.Id_Lice 
        inner join n_list_codepositions n on n.NKODE = d.Idcodeposition and n.PKODE = d.VidCodetable and n.PKODE=3
        inner join tblvalues s on s.id = i.Id_Sik
        inner join wntoa w1 ON w1.NKOD = i.TOA
   WHERE i.Izb_Alias = @v_izbalias
     AND i.TUR = @v_tur
     AND d.Idcodeposition in (select distinct nkod from tblcodes)
   ORDER BY w1.NKOD,5;  
    
  DROP TEMPORARY TABLE tblvalues; 
  DROP TEMPORARY TABLE tblizbr;
  DROP TEMPORARY TABLE tblcodes;
  
END;
//

DELIMITER ;