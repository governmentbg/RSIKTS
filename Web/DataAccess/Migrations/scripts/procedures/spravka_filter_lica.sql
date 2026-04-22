DROP PROCEDURE IF EXISTS spravka_filter_lica;

DELIMITER //

CREATE PROCEDURE spravka_filter_lica(
  prmTOA      varchar(2)
  ,prmIdRolja int
  ,prmIdSila  int
  ,prmRe      varchar(128)
  ,prmOper    int
  ,prmSIKS    varchar(250)
  ,prmFilter  varchar(30)
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
  ,prmTUR     int
  ,prmGlobal  int  
)

BEGIN
  SET NAMES 'utf8';

  IF prmTUR > 0 THEN
     SET @v_tur = prmTUR;
  ELSE
    SELECT VALUE
      INTO @v_tur 
      FROM sys_main
      WHERE ID =2;
  END IF;

  SELECT VALUE
    INTO @v_izbalias
    FROM sys_main
    WHERE ID =1;

  IF LENGTH(prmSIKS) > 0 THEN
    CREATE TEMPORARY TABLE if not exists tblsiks (id int);
  
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
        SELECT i.id
          FROM n_lica_izbori i 
               inner join siks s on i.id_sik = s.id_sek
          WHERE s.sik in (SELECT id FROM tblsiks)
            AND s.TUR = @v_tur 
            AND s.TOA = IF(prmGlobal=1,s.TOA,prmToa);
    
    DROP TEMPORARY TABLE tblsiks;
     
  ELSE
    IF (prmGlobal=1) THEN
      INSERT INTO tblvalues 
          SELECT i.id
            FROM n_lica_izbori i 
                  inner join siks s on i.id_sik = s.id_sek
            WHERE s.Izb_Alias = @v_izbalias
              AND s.TUR = @v_tur
              AND s.status_sekcia = 1;
    ELSE
      INSERT INTO tblvalues 
          SELECT i.id
            FROM n_lica_izbori i 
                  inner join siks s on i.id_sik = s.id_sek
                   inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
                   inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
            WHERE s.Izb_Alias = @v_izbalias
              AND s.TUR = @v_tur
              AND s.TOA = prmToa
              AND s.status_sekcia = 1;
    END IF;
  END IF;
  
  IF prmIdRolja > 0 THEN
      DELETE FROM tblvalues
          where id not in (SELECT id FROM n_lica_izbori WHERE Code_rolia=prmIdRolja);
  END IF;
  
  IF prmIdSila > 0 THEN
      DELETE FROM tblvalues
          where id not in (SELECT id FROM n_lica_izbori WHERE id_sila = prmIdSila);
  END IF;

  IF LENGTH(prmRe) > 0  THEN
      DELETE FROM tblvalues
          where id not in (SELECT id FROM n_lica_izbori WHERE re = prmRe);
  END IF;

  IF prmOper > 0  THEN
      DELETE FROM tblvalues
          where id not in (SELECT i.id 
                              FROM n_lica_izbori i inner join n_lica_dopylnenie d on i.id = d.Id_Lice and d.VidCodetable=3 
                              WHERE d.Idcodeposition = prmOper);
  END IF;

  IF LENGTH(prmFilter) > 0  THEN
      DELETE FROM tblvalues
          where id not in (SELECT i.id
                              FROM n_lica l inner join n_lica_izbori i on l.id = i.ID_Lice
                              WHERE (INSTR(AES_DECRYPT(FROM_BASE64(im1),prmDummy),prmFilter) > 0
                                      OR INSTR(AES_DECRYPT(FROM_BASE64(im2),prmDummy),prmFilter) > 0
                                      OR INSTR(AES_DECRYPT(FROM_BASE64(im3),prmDummy),prmFilter) > 0
                                      OR INSTR(AES_DECRYPT(FROM_BASE64(egn),prmDummy),prmFilter) > 0));
  END IF;                                      
END;
//

DELIMITER ;