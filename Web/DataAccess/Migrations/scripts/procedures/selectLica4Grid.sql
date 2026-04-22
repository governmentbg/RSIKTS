DROP PROCEDURE IF EXISTS selectLica4Grid;

DELIMITER //

CREATE PROCEDURE selectLica4Grid (prmFilter varchar(30), prmToa varchar(2), prmDummy varchar(30), prmSIK int)

BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

    SELECT MAX(IF(id=2,cast(value as unsigned integer),0))
      INTO @v_tur
      FROM sys_main
      WHERE ID =2;
    
    IF IFNULL(prmSIK,0) > 0 THEN
  		select
          s.SIK
          ,l.ID
          ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) as Egn
          ,CONCAT(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),' ',
                 IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
                 CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50))) as ime
          ,c.NIME as dlyzjnost
          ,w.NIME as partia
          ,'' as Deistvie
          ,'' as Reshenie
          ,l.tel as Telefon
          ,i.tur
        FROM n_lica l 
            inner join n_lica_izbori i on l.ID = i.ID_Lice
            inner join siks s on s.Id_sek = i.Id_Sik
            left join n_list_codepositions c on c.NKODE = i.Code_rolia and c.PKODE=4
            left join wnsila w on w.id_party = i.id_sila
        WHERE i.id_sik = prmSIK
          AND (INSTR(AES_DECRYPT(FROM_BASE64(im1),prmDummy),prmFilter) > 0
                OR INSTR(AES_DECRYPT(FROM_BASE64(im2),prmDummy),prmFilter) > 0
                OR INSTR(AES_DECRYPT(FROM_BASE64(im3),prmDummy),prmFilter) > 0
                OR INSTR(AES_DECRYPT(FROM_BASE64(egn),prmDummy),prmFilter) > 0)
        ORDER BY i.Code_rolia;      	
    ELSE
  		select
          s.SIK
          ,l.ID
          ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) as Egn
          ,CONCAT(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),' ',
                 IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
                 CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50))) as ime
          ,c.NIME as dlyzjnost
          ,w.NIME as partia
          ,'' as Deistvie
          ,'' as Reshenie          
          ,l.tel as Telefon
          ,@v_tur as tur
        FROM n_lica l 
            inner join n_lica_izbori i on l.ID = i.ID_Lice
            inner join siks s on s.Id_sek = i.Id_Sik
            left join n_list_codepositions c on c.NKODE = i.Code_rolia and c.PKODE=4
            left join wnsila w on w.id_party = i.id_sila
        WHERE s.TUR = @v_tur
          AND s.TOA = prmToa
 --         AND convert(s.sik, unsigned integer)>0
          AND (INSTR(AES_DECRYPT(FROM_BASE64(im1),prmDummy),prmFilter) > 0
                OR INSTR(AES_DECRYPT(FROM_BASE64(im2),prmDummy),prmFilter) > 0
                OR INSTR(AES_DECRYPT(FROM_BASE64(im3),prmDummy),prmFilter) > 0
                OR INSTR(AES_DECRYPT(FROM_BASE64(egn),prmDummy),prmFilter) > 0)
        ORDER BY s.SIK,i.Code_rolia;      	
    END IF;
END
//

DELIMITER ;	
