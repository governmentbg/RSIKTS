DROP PROCEDURE IF EXISTS spravka_2_2_1;

DELIMITER //

CREATE PROCEDURE spravka_2_2_1(
  prmTOA      varchar(2)
  ,prmIdRolja int
  ,prmIdSila  int
  ,prmRe      varchar(2)
  ,prmOper    int
  ,prmSIKS    varchar(250)
  ,prmFilter  varchar(30)  
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)

BEGIN
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_2_2_1',prmTOA,'');

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  CALL spravka_filter_lica(
            prmTOA
            ,prmIdRolja
            ,prmIdSila
            ,prmRe    
            ,prmOper  
            ,prmSIKS   
            ,prmFilter
            ,prmUSER  
            ,prmDummy 
            ,0  -- current tur
            ,0  -- local search
  );

  SELECT w2.NIME
        ,s.AA_BB_CC siknumb
        ,p.NIME
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),'')) as ime
        ,CAST(AES_DECRYPT(FROM_BASE64(lc.egn),prmDummy) as CHAR(50)) as Egn
        ,w1.nime
        ,lc.tel
   FROM tblvalues t
        inner join n_lica_izbori i on i.id = t.id
        INNER JOIN siks s ON s.id_sek = i.id_sik
        inner join n_lica lc on lc.Id = i.id_lice
        INNER JOIN wntoa w2 ON s.TOA = w2.NKOD
        inner join n_list_codepositions p on p.NKODE = i.Code_rolia and p.PKODE=4
        inner join wnsila w1 on w1.id_party = i.id_sila
		WHERE i.Code_rolia < 410		
    ORDER BY w2.nkod, 2;

  DROP TEMPORARY TABLE tblvalues;
END;
//

DELIMITER ;