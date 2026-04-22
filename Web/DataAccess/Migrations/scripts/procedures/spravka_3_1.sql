DROP PROCEDURE IF EXISTS spravka_3_1;

DELIMITER //

CREATE PROCEDURE spravka_3_1(
  prmTOA     varchar(2)
  ,prmTUR     int
  ,prmSIKS    varchar(250)
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  SET NAMES 'utf8';  
  
  SELECT MAX(IF(id=1,VALUE,''))
    INTO @v_izbalias
    FROM sys_main
    WHERE ID in (1,2);

  call createLog (prmUSER, 3,'Справка','spravka_3_1',prmTOA,'');

  CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
      izb_rajon varchar(2),
      name varchar(45)
  );

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  IF convert(prmSIKS, UNSIGNED INTEGER)> 0 THEN
      DROP TEMPORARY TABLE if exists tblsiks;
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
        SELECT ID_SEK
          FROM siks s inner join tblsiks t on s.sik = t.sik 
          WHERE s.Izb_Alias = @v_izbalias
            and s.TUR = prmTUR 
            and s.TOA = prmTOA;
          
      DROP TEMPORARY TABLE tblsiks;   
  ELSE
    INSERT INTO tblvalues 
        SELECT id_sek 
          FROM siks s
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
          WHERE Izb_Alias = @v_izbalias
            AND s.TUR =  prmTUR
            AND s.TOA = prmToa
            AND s.status_sekcia = 1;               
  END IF;

  DROP TEMPORARY TABLE tblizbr;

  SET @row_number = 0;


  SELECT 
        nmizbrajon
        , nmrajon
        ,(@row_number := @row_number + 1) AS num
        ,sikcode
        ,rolia
        ,ime
        ,suma
        ,AA_BB_CC as SikFullCode
        ,Code_rolia
        ,z.Egn
    FROM (SELECT 
                w4.nime  as nmizbrajon
                ,w2.NIME as nmrajon
                ,sikcode
                ,rolia
                ,ime
                ,suma
                ,AA_BB_CC
                ,Code_rolia
                ,x.Egn
            FROM (SELECT    
                      s.Izb_rajon
                      ,s.toa
                      ,sik as sikcode
                      ,p.nime   rolia
                      ,CAST(AES_DECRYPT(FROM_BASE64(lc.egn),prmDummy) as CHAR(50)) as Egn
                      ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
                             IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
                             IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),''))  as ime
                      ,IFNULL(round(w4.pari,2),0) as suma
                      ,s.AA_BB_CC
                      ,l.Code_rolia
                     FROM tblvalues t
                          inner join siks s on s.Id_sek = t.id
                          inner join n_lica_izbori l on l.Id_Sik = s.id_sek
                          inner join n_lica lc on lc.Id = l.id_lice
                          inner join n_list_codepositions p on p.NKODE = l.Code_rolia and p.PKODE=4
                          inner join (SELECT id_lice, sum(pari) pari 
                                        from n_lice_pari_zaplashtane 
                                        group by id_lice) w4 
                          on w4.id_lice = l.id
                      ORDER BY s.sik, l.Code_rolia) x
                  inner join wntoa w2 on w2.NKOD = x.toa
                  inner join wntoa_izbraion w3 on w3.nkod = w2.nkod and w3.IZB_R = x.izb_rajon
                  inner join wnizbraion w4 on w4.nkod = w3.izb_r and w4.izb_alias = @v_izbalias
             WHERE suma >0) z
      ORDER BY AA_BB_CC, Code_rolia;
             
  DROP TEMPORARY TABLE tblvalues;
END;
//

DELIMITER ;