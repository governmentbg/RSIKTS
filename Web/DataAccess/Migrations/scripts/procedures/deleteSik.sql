DROP PROCEDURE IF EXISTS deleteSik;

DELIMITER //

CREATE PROCEDURE deleteSik(
  prmID         int
  ,prmUSER      varchar(128)
)
BEGIN
    DECLARE prmSik      varchar(3);
    DECLARE prmADR_IME  varchar(100);
    DECLARE prmToa      varchar(3);
    DECLARE prmFullSik  varchar(10);

    SET NAMES 'utf8';

    SELECT SIK, ADR_IME, TOA, AA_BB_CC
      INTO prmSik, prmADR_IME, prmToa, prmFullSik
      FROM siks
      WHERE ID_SEK = prmID;

    IF prmSIk = '000' THEN
      SELECT -1 as ID FROM DUAL;
    ELSEIF EXISTS (SELECT 1 FROM n_lica_izbori where id_sik = prmID) THEN
      SELECT -2 as ID FROM DUAL;    
    ELSE
      UPDATE siks 
        SET Status_Sekcia = 0
      WHERE Id_sek = prmID;

      call createSikLog (prmUser, prmTOA, prmFullSik, 11, 'Закрита','','');
      SELECT prmID as ID FROM DUAL;
    END IF;
END;
//

DELIMITER ;	