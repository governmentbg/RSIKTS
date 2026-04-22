DROP PROCEDURE IF EXISTS updateLicaZamestvane;

DELIMITER //

CREATE PROCEDURE updateLicaZamestvane(
  prmId           int
  ,prmIdLiceStaro int(11)
  ,prmUSER        varchar(128)
)
BEGIN
    SET NAMES 'utf8';
 
    SELECT s.ID_SEK, s.Izb_Alias, s.TOA, s.TUR
      INTO @v_idsik, @v_IzbAlias, @v_toa, @v_tur
      FROM n_lica_izbori i inner join siks s on i.Id_Sik = s.id_sek
      WHERE i.id = prmIdLiceStaro;
      
    -- izbirame 0-a SIK za rajona
    SELECT Id_sek 
      INTO @v_idnullsik
      FROM siks
      WHERE sik = '000'
        AND IZB_ALIAS  = @v_IzbAlias
        AND Toa = @v_Toa
        AND TUR = @v_TUR;  

    UPDATE n_lica_izbori
      SET Id_Sik = @v_idnullsik
      WHERE ID = prmIdLiceStaro;

    UPDATE n_lica_izbori_zamestvane 
        SET `Id_Lice_staro` = prmIdLiceStaro
            ,`USER` = prmUSER
            ,`KOGA` = now()
        WHERE ID = prmId;    
 
    SELECT prmId as 'Id' FROM DUAL;    
END;
//

DELIMITER ;	