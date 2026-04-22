DROP PROCEDURE IF EXISTS calculateBonuses;

DELIMITER //

CREATE PROCEDURE calculateBonuses(
   prmUSER          varchar(128) 
   ,prmIdLiceIzb    int
   ,prmDummy        varchar(30)
)
BEGIN
  DECLARE v_code_rolia,v_idsik,v_tur, v_hasmaxincome,v_vidsik INTEGER DEFAULT 0;
  DECLARE v_toa varchar(2) default "";
  DECLARE v_izb_alias varchar(6) default "MI2019";
  DECLARE v_sik varchar(3) default "000";
  DECLARE v_egn      varchar(10);
  
  SET NAMES 'utf8';
    
   -- danni za liceto, uchastvashto v izbora
  SELECT i.Code_rolia, i.IZB_Alias, i.TUR, s.TOA, i.ID_SIK, s.SIK
        ,ifnull(i.hasmaxincome,0), ifnull(v.Idcodeposition,101)
        ,CAST(AES_DECRYPT(FROM_BASE64(l.egn),prmDummy) as CHAR(50))
    INTO v_code_rolia, v_izb_alias,v_tur,v_toa,v_idsik,v_sik, v_hasmaxincome, v_vidsik,v_egn
    FROM n_lica_izbori i 
          inner join n_lica l on i.id_lice = l.id
          inner join siks s on i.Id_Sik = s.Id_sek
            left join  siks_vidove v on v.Id_Sik = s.Id_sek and v.Vid_codetable=1
    WHERE i.Id = prmIdLiceIzb;
       
  DELETE FROM n_lice_pari_zaplashtane
    WHERE ID_Lice = prmIdLiceIzb;
    
  DELETE FROM n_lice_pari_zanap
    WHERE ID_Lice = prmIdLiceIzb;
  
  SELECT Calc
    INTO @isCalc
    FROM n_list_codepositions
    WHERE PKODE = 1 AND NKODE=v_vidsik;
    
  IF @isCalc = 1  AND v_code_rolia < 410 THEN   
 
    -- pari po roljata mu v sekcijata 
    INSERT INTO n_lice_pari_zaplashtane(`ID_Lice`,`Code_Table`,`Code_possition`,`Pari`,`Koga`)
      SELECT prmIdLiceIzb,  o.Vid_codetable, o.Idcodeposition, Pari, now()
          FROM  siks_vidove v 
                inner join  normi_roli o 
                    ON v.Vid_codetable = o.Vid_codetable_1 
                        and v.Idcodeposition = o.Idcodeposition_1 
          where v.id_sik = v_idsik
             and v.Vid_codetable  = 1
             AND o.Vid_codetable  = 4
             AND o.idcodeposition = v_code_rolia
             AND o.Izb_allias     = v_izb_alias
             and o.tur            = v_tur
             AND o.status         = 1;
          
      -- pari po harakteristika na sekcijata 
    INSERT INTO n_lice_pari_zaplashtane(`ID_Lice`,`Code_Table`,`Code_possition`,`Pari`,`Koga`)
        SELECT prmIdLiceIzb,  v.Vid_codetable, v.Idcodeposition, Pari, now()
          FROM  siks_vidove v 
                inner join  normi_priznaci o 
                    ON v.Vid_codetable = o.Vid_codetable and v.Idcodeposition = o.Idcodeposition
          where v.id_sik = v_idsik
             and v.Vid_codetable = 2
             AND o.Izb_allias = v_izb_alias
             and o.tur = v_tur
             AND o.status=1;

    -- pari po operacii, koito izvyrshva liceto 
    INSERT INTO n_lice_pari_zaplashtane (`ID_Lice`,`Code_Table`,`Code_possition`,`Pari`,`Koga`)
        SELECT prmIdLiceIzb,  d.Vidcodetable, d.Idcodeposition, Pari, now()
          FROM n_lica_dopylnenie d
                inner join n_lica_izbori i on d.Id_Lice = i.ID
                inner join normi_operacii o on d.vidcodetable = o.vid_codetable and d.idcodeposition = o.idcodeposition
          WHERE i.ID        = prmIdLiceIzb
            AND o.Izb_allias = v_izb_alias
            AND o.TUR        = v_tur
            AND o.status     = 1;

    IF v_hasmaxincome = 0 THEN
        if fnGetLiceBirthYear(v_egn) > 1959 THEN   
            -- pari za NAP,  sled 1959 g           
            INSERT INTO n_lice_pari_zanap (`ID_Lice`,`Code_dancoef`,`Pari`,`Koga`)
                SELECT prmIdLiceIzb,nred,pari*Coef_stoinost,now()
                    FROM (SELECT SUM(Pari) pari
                                      FROM n_lice_pari_zaplashtane
                                      WHERE ID_Lice = prmIdLiceIzb) x
                          cross join  n_top_dancoef d
                    WHERE IZB_ALLIAS   = v_izb_alias
                      AND CAST(nred AS UNSIGNED integer) between 2 and 10
                      AND status_coef  = 1
                      AND Coef_stoinost> 0;
        ELSE
            -- pari za NAP,  predi 1960 g           
            INSERT INTO n_lice_pari_zanap (`ID_Lice`,`Code_dancoef`,`Pari`,`Koga`)
                SELECT prmIdLiceIzb,nred,pari*Coef_stoinost,now()
                    FROM (SELECT SUM(Pari) pari
                                      FROM n_lice_pari_zaplashtane
                                      WHERE ID_Lice = prmIdLiceIzb) x
                          cross join  n_top_dancoef d
                    WHERE IZB_ALLIAS   = v_izb_alias
                      AND (CAST(nred AS UNSIGNED integer) =1 OR CAST(nred AS UNSIGNED integer) between 4 and 10)
                      AND status_coef  = 1
                      AND Coef_stoinost> 0;
        END IF;            
    END IF;   
  END IF;    
END;
//

DELIMITER ;	