DROP PROCEDURE IF EXISTS spravka_2_1_1;

DELIMITER //

CREATE PROCEDURE spravka_2_1_1(
  prmIZB_R    varchar(2)
  ,prmTOA     varchar(2)
  ,prmSIKS    varchar(250)
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  call createLog (prmUSER, 3,'Справка','spravka_2_1_1',prmTOA,'');

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
            SELECT s.id_sek 
              FROM siks s
                inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
                inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
              WHERE s.Izb_Alias = @v_izbalias
                AND s.TUR =  @v_tur
                AND s.TOA = prmToa
                AND s.Status_Sekcia=1;               
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
                  AND s.Status_Sekcia=1
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1;   
    END IF;
  END IF;

  DROP TEMPORARY TABLE tblizbr;

   SELECT
        w6.NIME as nmizbrajon        
        ,w5.NIME as nmrajon
        ,aa_bb_cc as sikfullcode
        ,p.nime   rolia
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),'')) as ime
        ,CAST(AES_DECRYPT(FROM_BASE64(lc.egn),prmDummy) as CHAR(50)) as Egn
        ,w1.nime  sila
        ,lc.tel 
        ,w2.nime  re
        ,w3.nime  obra 
        ,w4.nime  spec
        ,fnGetSikAddress(t.id) as sikaddress
        ,s.adr_ime as descript
   FROM tblvalues t
        inner join siks s on s.Id_sek = t.id
        inner join n_lica_izbori l on l.Id_Sik = s.id_sek
        inner join n_lica lc on lc.Id = l.id_lice
        inner join n_list_codepositions p on p.NKODE = l.Code_rolia and p.PKODE=4
        inner join wnsila w1 on w1.id_party = l.id_sila
        INNER JOIN wntoa w5 ON w5.NKOD = s.TOA
        INNER JOIN wnizbraion w6 ON w6.NKOD =  s.izb_rajon and w6.IZB_ALIAS =  @v_izbalias 
        left join wndocs w2 on w2.NKOD = l.re
        left join wnszem w3 on w3.NKOD = lc.obra
        left join wnspec w4 on w4.NKOD = lc.spec
		WHERE l.Code_rolia < 410		
    ORDER BY w6.nkod,w5.nkod,3, l.Code_rolia;

  DROP TEMPORARY TABLE tblvalues;
END;
//

DELIMITER ;