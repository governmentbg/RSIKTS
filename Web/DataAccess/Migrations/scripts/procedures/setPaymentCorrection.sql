DROP PROCEDURE IF EXISTS setPaymentCorrection;

DELIMITER //

CREATE PROCEDURE setPaymentCorrection(
   prmIdLice  int
   ,prmUSER      varchar(128) 
   ,prmPARI      decimal(10,2)
   ,prmDummy     varchar(30)
)
BEGIN
  DECLARE prmIME      varchar(250);  
  
  SET NAMES 'utf8';

SELECT CONCAT(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),' ',
             IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
             CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50))) as ime
        ,ifnull(i.hasmaxincome,0)
        ,CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) as Egn
        ,i.TOA
        ,i.Izb_Alias
        ,i.ID
    INTO @w_IME,  @v_hasmaxincome, @v_egn, @v_toa, @v_izb_alias, @prmIdLiceIzb
    FROM n_lica_izbori i 
          inner join  n_lica l ON i.ID_Lice = l.ID AND i.Tur = 1
    WHERE l.ID = prmIdLice;

  DELETE FROM n_lice_pari_zaplashtane 
    WHERE ID_Lice = @prmIdLiceIzb
      AND Code_Table = 3 and Code_possition = 330;
  
  INSERT INTO n_lice_pari_zaplashtane  (`ID_Lice`,`Code_Table`,`Code_possition`,`Pari`,`Koga`)
      VALUES(@prmIdLiceIzb, 3, 330, prmPARI, NOW() );
    
  DELETE FROM n_lice_pari_zanap
    WHERE ID_Lice = @prmIdLiceIzb;
    
  IF @v_hasmaxincome = 0 THEN
        if fnGetLiceBirthYear(@v_egn) > 1959 THEN   
            -- pari za NAP,  sled 1959 g           
            INSERT INTO n_lice_pari_zanap (`ID_Lice`,`Code_dancoef`,`Pari`,`Koga`)
                SELECT @prmIdLiceIzb,nred,pari*Coef_stoinost,now()
                    FROM (SELECT SUM(Pari) pari
                                      FROM n_lice_pari_zaplashtane
                                      WHERE ID_Lice = @prmIdLiceIzb) x
                          cross join  n_top_dancoef d
                    WHERE IZB_ALLIAS   = @v_izb_alias
                      AND CAST(nred AS UNSIGNED integer) between 2 and 10
                      AND status_coef  = 1
                      AND Coef_stoinost> 0;
        ELSE
            -- pari za NAP,  predi 1960 g           
            INSERT INTO n_lice_pari_zanap (`ID_Lice`,`Code_dancoef`,`Pari`,`Koga`)
                SELECT @prmIdLiceIzb,nred,pari*Coef_stoinost,now()
                    FROM (SELECT SUM(Pari) pari
                                      FROM n_lice_pari_zaplashtane
                                      WHERE ID_Lice = @prmIdLiceIzb) x
                          cross join  n_top_dancoef d
                    WHERE IZB_ALLIAS   = @v_izb_alias
                      AND (CAST(nred AS UNSIGNED integer) =1 OR CAST(nred AS UNSIGNED integer) between 4 and 10)
                      AND status_coef  = 1
                      AND Coef_stoinost> 0;
        END IF;            
  END IF;   
    
  call createLog (prmUSER, 1,'Корекция на плащане в Тур 1',CONCAT(@w_IME,' [',prmIdLice,']'),IFNULL( @v_toa,''),'');
  select prmIdLice as ID from dual;  
END;
//

DELIMITER ;	