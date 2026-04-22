DROP PROCEDURE IF EXISTS spravka_2_1_2;

DELIMITER //

CREATE PROCEDURE spravka_2_1_2(
  prmToa      varchar(2)
  ,prmSIKS     varchar(250)
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

  call createLog (prmUSER, 3,'Справка','spravka_2_1_2',prmTOA,'');

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
    INSERT INTO tblvalues 
        SELECT id_sek 
          FROM siks s
                inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
                inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition
          WHERE s.Izb_Alias = @v_izbalias
            AND s.TUR =  @v_tur
            AND s.TOA = prmToa
            AND (s.Status_Sekcia=1 or  n.CALC=0);               
  END IF;

  SELECT
        w5.NIME as NmRajon
        ,aa_bb_cc as sikfullcode
        ,CAST(AES_DECRYPT(FROM_BASE64(lc.egn),prmDummy) as CHAR(50)) as Egn
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),'')) as ime
        ,p.nime   rolia
        ,w1.nime  sila
        ,lc.tel 
   FROM tblvalues t
        inner join siks s on s.Id_sek = t.id
        inner join n_lica_izbori l on l.Id_Sik = s.id_sek
        inner join n_lica lc on lc.Id = l.id_lice
        inner join n_list_codepositions p on p.NKODE = l.Code_rolia and p.PKODE=4
        inner join wnsila w1 on w1.id_party = l.id_sila
        INNER JOIN wntoa w5 ON w5.NKOD = s.TOA
		WHERE l.Code_rolia = 410		
    ORDER BY w5.nkod,2,w1.nkod;

  DROP TEMPORARY TABLE tblvalues;
END;
//

DELIMITER ;