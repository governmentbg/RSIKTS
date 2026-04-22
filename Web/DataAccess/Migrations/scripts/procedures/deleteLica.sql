DROP PROCEDURE IF EXISTS deleteLica;

DELIMITER //

CREATE PROCEDURE deleteLica(
  prmID         int
  ,prmUSER      varchar(128)
  ,prmToa       varchar(2)
  ,prmDummy     varchar(30)
)

BEGIN
    DECLARE prmIME      varchar(250);
    
    SET NAMES 'utf8';

    SELECT MAX(IF(id=2,cast(value as unsigned integer),0))
        INTO @v_tur
        FROM sys_main
        WHERE ID =2;
    
    IF @v_tur = 2 THEN      
      SELECT IFNULL(MAX(s.SIK),'000')
        INTO @v_sik
        FROM n_lica_izbori i inner join siks s on i.id_sik = s.Id_sek
        WHERE i.ID_LICE = prmID
          AND i.TUR = 1;
    ELSE
      SET @v_sik = '000';
    END IF;      

    SELECT i.ID
      INTO @prmIDIZB
      FROM n_lica_izbori i inner join siks s on i.id_sik = s.Id_sek
      WHERE i.ID_LICE = prmID
        AND i.TUR =  @v_tur;

    IF  @v_sik = '000' THEN
      SELECT CONCAT(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),' ',
                 IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
                 CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50))) as ime
        INTO prmIME
        FROM n_lica
        WHERE ID = prmID;
      
      -- TODO delete from all child tables

      DELETE FROM n_lice_pari_zanap WHERE ID_LICE =@prmIDIZB;
      DELETE FROM n_lice_pari_zaplashtane WHERE ID_LICE =@prmIDIZB;
      DELETE FROM n_lica_dopylnenie WHERE ID_LICE =@prmIDIZB;
      DELETE FROM n_lica_dopylnenie_ottur1 WHERE ID_LICE =@prmIDIZB;
      
      DELETE FROM n_lica_izbori_zamestvane WHERE ID_Lice_staro =@prmIDIZB;
      DELETE FROM n_lica_izbori_zamestvane WHERE ID_Lice_novo =@prmIDIZB;
      
      DELETE FROM n_lica_izbori_zamestvane_ottur1 WHERE ID_Lice_staro =@prmIDIZB;
      DELETE FROM n_lica_izbori_zamestvane_ottur1 WHERE ID_Lice_novo =@prmIDIZB;
   
      DELETE FROM n_lica_izbori WHERE ID_LICE =prmID;           
      DELETE FROM N_LICA WHERE ID = prmID;
                     
      call createLog (prmUSER, 1,'Изтриване',CONCAT(prmIme,' [',prmID,']'),IFNULL(prmToa,''),'');
      select prmID as ID from dual;
    ELSE
      select -1 as ID from dual;    
    END IF;  
END;
//

DELIMITER ;	