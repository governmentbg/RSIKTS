DROP PROCEDURE IF EXISTS selectLica;

DELIMITER //

CREATE PROCEDURE selectLica (prmID int, prmDummy varchar(30))

BEGIN
    DECLARE rowcount int;

    SET NAMES 'utf8';

		select 
        l.ID,
        CAST(AES_DECRYPT(FROM_BASE64(egn),prmDummy) as CHAR(50)) as Egn,
         CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)) as im1,
         CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)) as im2,
         CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50)) as im3,
        l.AP,
        l.BLOK,
        l.ET,
        l.Impmessage,
        l.impstatus,
        l.Jk_Kv,
        l.Koga,
        l.NAS,
        l.NAZ,
        l.NOM,
        l.OBL,
        l.Obra,
        l.OBS,
        l.PAS1,
        l.PAS2,
        l.PAS3,
        l.PAS4,
        l.PK,
        l.RAJ,
        l.Spec,
        l.TEL,
        l.UL,
        l.USER,
        l.VH,
        l.Vid_id  
      FROM n_lica l 
      WHERE ID = prmID;
END
//

DELIMITER ;	
