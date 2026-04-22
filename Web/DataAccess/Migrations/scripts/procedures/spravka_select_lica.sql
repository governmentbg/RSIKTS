DROP PROCEDURE IF EXISTS spravka_select_lica;

DELIMITER //

CREATE PROCEDURE spravka_select_lica(
  prmTOA      varchar(2)
  ,prmIdRolja int
  ,prmIdSila  int
  ,prmRe      varchar(128)
  ,prmOper    int
  ,prmSik     varchar(250)
  ,prmFilter  varchar(30)
  ,prmUSER    varchar(128)
  ,prmTip     int
  ,prmDummy   varchar(30)
  ,prmTUR     int
  ,prmGlobal  int
)

BEGIN
  SET NAMES 'utf8';

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  IF prmTUR > 0 THEN
     SET @v_tur = prmTUR;
  ELSE
    SELECT VALUE
      INTO @v_tur 
      FROM sys_main
      WHERE ID =2;
  END IF;


  CALL spravka_filter_lica(
            prmTOA
            ,prmIdRolja
            ,prmIdSila
            ,prmRe    
            ,prmOper  
            ,prmSik   
            ,prmFilter
            ,prmUSER  
            ,prmDummy
            ,@v_tur
            ,prmGlobal
  );

  SELECT CONCAT(s.AA_BB_CC,IF(prmGlobal=1,CONCAT(' ',w2.NIME),'')) as SIK
        ,lc.ID
        ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) as Egn
        ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
               IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)),'')) as ime
        ,p.NIME as dlyzjnost
        ,w.NIME as partia
        ,lc.tel as telefon
        ,ifnull(x.nime,'') as Deistvie
        ,ifnull(w1.nime,'') as Reshenie
        ,@v_tur as Tur
     FROM tblvalues t
          inner join n_lica_izbori i on i.id = t.id
          INNER JOIN siks s ON s.id_sek = i.id_sik
          inner join n_lica lc on lc.Id = i.id_lice
          inner join n_list_codepositions p on p.NKODE = i.Code_rolia and p.PKODE=4
          inner join wntoa w2 ON w2.NKOD = s.TOA
          left join wnsila w on w.id_party = i.id_sila
          left join (SELECT d.Id_Lice, GROUP_CONCAT(p1.NIME SEPARATOR ', ') as nime
                       FROM n_lica_dopylnenie d 
                              inner join n_list_codepositions p1 
                              on d.idcodeposition = p1.nkode and d.vidcodetable = p1.pkode
                       WHERE d.VidCodetable=3
                       GROUP BY d.Id_Lice) x
            on t.id = x.Id_Lice
           
          left join wndocs w1 on w1.nkod = i.re  
    WHERE i.Code_rolia < IF(prmTip=0,999,410)
    ORDER BY s.AA_BB_CC, p.nkode;

  DROP TEMPORARY TABLE tblvalues;
                                     
END;
//

DELIMITER ;