DROP PROCEDURE IF EXISTS insertLicaZamestvane;

DELIMITER //

CREATE PROCEDURE insertLicaZamestvane(
  prmIdLiceNovo   int
  ,prmIdLiceStaro int(11)
  ,prmUSER        varchar(128)
  ,prmTIP         int
)
BEGIN
    SET NAMES 'utf8';
    
    SELECT cast(value as unsigned integer)
      INTO @v_tur
      FROM sys_main 
      WHERE ID = 2;
      
    -- podava se ID ot n_lice i trjabva da namerim ID ot n_lice_izbori
    SELECT ID 
      INTO @v_id_lice_staro
      FROM n_lica_izbori 
      WHERE ID_LICE = prmIdLiceStaro
        AND TUR = @v_tur;
  
    SELECT s.ID_SEK, s.Izb_Alias, s.TOA, s.TUR, i.id_sila, i.Code_rolia
        INTO @v_idsik, @v_IzbAlias, @v_toa, @v_tur, @v_idsila, @v_id_rolja
        FROM n_lica_izbori i inner join siks s on i.Id_Sik = s.id_sek
        WHERE i.id =  @v_id_lice_staro;
    
    DELETE FROM n_lica_izbori_zamestvane 
        WHERE Id_Lice_staro = @v_id_lice_staro
          AND Id_Lice_novo  = prmIdLiceNovo;
      
    IF prmTIP = 2 THEN      
      DELETE FROM n_lica_izbori_zamestvane 
          WHERE Id_Lice_staro = prmIdLiceNovo
            AND Id_Lice_novo  = @v_id_lice_staro;

      -- danni za novoto lice
      SELECT s.ID_SEK, s.Izb_Alias, s.TOA, s.TUR, i.id_sila, i.Code_rolia
          INTO @v_idsiknovo, @v_IzbAlias, @v_toa, @v_tur, @v_idsilanova, @v_id_roljanova
          FROM n_lica_izbori i inner join siks s on i.Id_Sik = s.id_sek
          WHERE i.id =  prmIdLiceNovo;
      
      -- mestim staroto lice
      UPDATE n_lica_izbori
          SET Id_Sik = @v_idsiknovo, Code_rolia =  @v_id_roljanova
          WHERE ID =  @v_id_lice_staro;

      INSERT INTO n_lica_izbori_zamestvane (ID_Lice_novo,`Id_Lice_staro`,`id_sila`, `id_rolja`, `id_sek`, `USER`,`KOGA`)
            VALUES (@v_id_lice_staro, prmIdLiceNovo, @v_idsilanova,@v_id_roljanova,@v_idsiknovo,prmUSER ,now());
      
      -- mestim novoto lice
      UPDATE n_lica_izbori
          SET Id_Sik = @v_idsik, Code_rolia =  @v_id_rolja
          WHERE ID =  prmIdLiceNovo;

      INSERT INTO n_lica_izbori_zamestvane (ID_Lice_novo,`Id_Lice_staro`,`id_sila`, `id_rolja`, `id_sek`, `USER`,`KOGA`)
            VALUES (prmIdLiceNovo, @v_id_lice_staro,@v_idsila,@v_id_rolja,@v_idsik,prmUSER ,now());
      
    ELSE
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
          WHERE ID =  @v_id_lice_staro;

      -- novoto lice vzima rolqta na staroto
      UPDATE n_lica_izbori
          SET Code_rolia =  @v_id_rolja
          WHERE ID =  prmIdLiceNovo;

      INSERT INTO n_lica_izbori_zamestvane (ID_Lice_novo,`Id_Lice_staro`,`id_sila`, `id_rolja`, `id_sek`, `USER`,`KOGA`)
            VALUES (prmIdLiceNovo, @v_id_lice_staro,@v_idsila,@v_id_rolja,@v_idsik,prmUSER ,now());
    END IF;
    
    SELECT LAST_INSERT_ID() as `Id` FROM DUAL;     
END;
//

DELIMITER ;	