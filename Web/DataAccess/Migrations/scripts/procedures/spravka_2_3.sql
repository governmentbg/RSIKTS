DROP PROCEDURE IF EXISTS spravka_2_3;

DELIMITER //

CREATE PROCEDURE spravka_2_3(
  prmTOA      varchar(2)
  ,prmSIKS     varchar(250)
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)

BEGIN
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_3_3',prmTOA,'');

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);
  
    
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
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
          WHERE s.Izb_Alias = @v_izbalias
            AND s.TUR = @v_tur
            AND s.TOA = prmToa
            AND s.status_sekcia = 1;       
  END IF;

  SET @row_number = 0;

  SELECT (@row_number:=@row_number + 1) AS Id        
        ,w6.NIME as nmizbrajon        
        ,w5.NIME as nmrajon
        ,aa_bb_cc as sikfullcode
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l1.im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l1.im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l1.im3),prmDummy) as CHAR(50)),'')) as imenovo
        ,CAST(AES_DECRYPT(FROM_BASE64(l1.egn),prmDummy) as CHAR(50)) as egnnovo
            
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l2.im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l2.im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(l2.im3),prmDummy) as CHAR(50)),'')) as imestaro
        ,CAST(AES_DECRYPT(FROM_BASE64(l2.egn),prmDummy) as CHAR(50)) as egnstaro

        ,p.nime  rolia
        ,w1.NIME partia
        ,DATE_FORMAT(z.koga, '%d.%m.%Y %H:%i:%s') as koga
        ,l1.tel
        ,IFNULL(l1.deistvie,'') as Deistvie
    FROM tblvalues t 
        inner join n_lica_izbori_zamestvane z on z.id_sek = t.id
        inner join siks s on s.id_sek = z.id_sek
        inner join n_list_codepositions p on p.NKODE = z.id_rolja and p.PKODE=4
        inner join wnsila w1 on w1.ID_Party = z.id_sila
        inner join (SELECT l.*, i.id as idizbori, x.deistvie  
                      FROM n_lica_izbori i 
                            inner join n_lica l on i.id_lice = l.id
                            left join (SELECT id_lice,p.NIME as deistvie 
                                          FROM n_lica_dopylnenie d 
                                              inner join n_list_codepositions p 
                                                 on p.NKODE = d.Idcodeposition and p.PKODE=3 AND p.NKODE >= 304) x
                                  ON x.Id_Lice = i.ID                                              
                      ) l1 
              on l1.idizbori = z.ID_Lice_novo
        inner join (SELECT l.*, i.id as idizbori 
                      FROM n_lica_izbori i inner join n_lica l on i.id_lice = l.id) l2 
              on l2.idizbori = z.ID_Lice_staro
        INNER JOIN wntoa w5 ON w5.NKOD = s.TOA
        INNER JOIN wnizbraion w6 ON w6.NKOD =  s.izb_rajon AND w6.izb_alias= @v_izbalias
		ORDER BY w6.nkod,w5.nkod,z.koga;
    
  DROP TEMPORARY TABLE tblvalues;
END;
//

DELIMITER ;