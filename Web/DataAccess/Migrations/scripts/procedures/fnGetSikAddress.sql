DROP FUNCTION IF EXISTS fnGetSikAddress;

DELIMITER //

CREATE FUNCTION fnGetSikAddress (prmSIK int) RETURNS varchar(500)
BEGIN
  DECLARE retval varchar(500) default ''
   collate utf8_unicode_ci;
  
  SET NAMES 'utf8';

  SELECT  
      CONCAT(
--            IFNULL(w1.nime,''), IF(IFNULL(w1.nime,'')='','',', ')
--            ,IFNULL(w2.nime,''),IF(IFNULL(w2.nime,'')='','',', ')
            IFNULL(w3.nime,''),IF(IFNULL(w3.nime,'')='','',', ')
            ,IFNULL(w5.nime,''),IF(IFNULL(w5.nime,'')='','',', ')
            ,IFNULL(w4.nime,''),IF(IFNULL(s.nom,'')='','',' № ')
            ,IFNULL(s.nom,''),  IF(IFNULL(s.nom,'')='','',', ')
            ,IF(IFNULL(s.blok,'')='','',' бл.')
            ,IFNULL(s.blok,''), IF(IFNULL(s.blok,'')='','',', ')
   )
   INTO retval 
   FROM siks s 
--        inner join wnobl w1 on w1.NKOD = s.Obl
--        inner join wnobs w2 on w2.NKOD = s.Obs
        inner join wnasm w3 on w3.NKOD = s.nas
         left join wnuli w4  on w4.NKOD = s.UL
         left join wnjk_kv w5 on w5.NKOD = s.JK_KV
   WHERE s.ID_SEK = prmSIK;
   
   SET retval= TRIM(IFNULL(retval,''));
   IF(RIGHT(retval,1)=',') THEN
      SET retval = LEFT(retval,char_length(retval)-1);
   END IF;   
   
   RETURN retval;  	
END;
//

DELIMITER //
