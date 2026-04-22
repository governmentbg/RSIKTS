DROP PROCEDURE IF EXISTS getPaymentCorrection;

DELIMITER //

CREATE PROCEDURE getPaymentCorrection(
   prmIdLice  int
)
BEGIN
  DECLARE prmIME      varchar(250);  
  
  SET NAMES 'utf8';

  SELECT  n.NIME as TEXT, p.PARI
    FROM n_lice_pari_zaplashtane p 
          inner join n_lica_izbori i ON i.ID = p.Id_lice and i.TUR = 1
          inner join n_list_codepositions n
              ON p.Code_Table = n.PKODE AND p.Code_possition = n.NKODE
    WHERE i.ID_Lice =  prmIdLice;
  --    AND p.code_possition < 330;  
END;
//

DELIMITER ;	