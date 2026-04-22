DROP PROCEDURE IF EXISTS selectWrongLica;

DELIMITER //

CREATE PROCEDURE selectWrongLica (prmUser varchar(128))

BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

		select 
        l.ID,l.egn, im1, im2, im3, SIK, Rolja, Obra, Spec, Tel, opisanie,Status
      FROM n_lica_import l 
      WHERE USER = prmUser
        AND l.status>1;
END
//

DELIMITER ;	
