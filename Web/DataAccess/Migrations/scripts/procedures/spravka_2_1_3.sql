DROP PROCEDURE IF EXISTS spravka_2_1_3;

DELIMITER //

CREATE PROCEDURE spravka_2_1_3(
  prmTOA      varchar(2)
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

  call createLog (prmUSER, 3,'Справка','spravka_2_1_3',prmTOA,'');

  CREATE TEMPORARY TABLE if not exists tblvalues (id int, siknumb varchar(10));

  INSERT INTO tblvalues 
      SELECT id_sek, concat(aa_bb_cc,sik) 
        FROM siks
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
        WHERE Izb_Alias = @v_izbalias
          AND TUR = @v_tur
          AND TOA = prmToa
          AND Status_Sekcia=1;               

  SELECT t.siknumb
        ,CAST(AES_DECRYPT(FROM_BASE64(lc.egn),prmDummy) as CHAR(50)) as Egn
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),'')) as ime
        ,p.nime   rolia
        ,w1.nime  sila
        ,w2.nime  re
        ,lc.tel 
        ,w3.nime  obra 
        ,w4.nime  spec
   FROM tblvalues t
        inner join n_lica_izbori l on l.Id_Sik = t.id
        inner join n_lica lc on lc.Id = l.id_lice
        inner join n_list_codepositions p on p.NKODE = l.Code_rolia and p.PKODE=4
        inner join wnsila w1 on w1.id_party = l.id_sila
        inner join wndocs w2 on w2.NKOD = l.re
        inner join wnszem w3 on w3.NKOD = lc.obra
        inner join wnspec w4 on w4.NKOD = lc.spec
		WHERE l.Code_rolia < 410		
    ORDER BY 1, l.Code_rolia;

  DROP TEMPORARY TABLE tblvalues;
END;
//

DELIMITER ;