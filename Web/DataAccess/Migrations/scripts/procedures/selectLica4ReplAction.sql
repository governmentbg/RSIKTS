DROP PROCEDURE IF EXISTS selectLica4ReplAction;

DELIMITER //

CREATE PROCEDURE selectLica4ReplAction (prmToa varchar(2), prmSik varchar(3), prmDummy varchar(30))

BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';


    SELECT MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_tur
    FROM sys_main
    WHERE ID =2;
    
		select
        l.ID
        ,s.sik as Sekciq
        ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) as Egn        
        ,CONCAT(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)))  as Imena               
        ,c.nime as Dlujnost
        ,w1.nime as PoliticheskaSila
        ,IFNULL(w2.nime,'') as Reshenie
        ,i.ID as IdLiceIzbori 
      FROM n_lica l 
          inner join n_lica_izbori i on l.ID = i.ID_Lice
          inner join siks s on s.Id_sek = i.Id_Sik
          inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
          inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1          
          inner join n_list_codepositions c on c.nkode = i.code_rolia and c.PKODE=4
          inner join wnsila w1 on w1.id_Party = i.id_sila
          left join wndocs w2 on w2.nkod = i.re          
      WHERE i.TUR = @v_tur
        AND s.TOA = prmToa
        AND s.sik = IF(convert(prmSik, unsigned integer)=0,s.sik,prmSik)
        AND convert(s.sik, unsigned integer) > 0
        AND s.Status_Sekcia = 1
        AND i.code_rolia < 410
      ORDER BY s.SIK,i.Code_rolia;      	      
END
//

DELIMITER ;	
