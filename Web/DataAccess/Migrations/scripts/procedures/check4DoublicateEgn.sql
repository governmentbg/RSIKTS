DROP PROCEDURE IF EXISTS check4DoublicateEgn;

DELIMITER //

CREATE PROCEDURE check4DoublicateEgn (prmEGN varchar(10),prmVid integer, prmID int, prmToa varchar(2),prmDummy varchar(128))
BEGIN
  DECLARE retval varchar(100) default "";
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  
  SELECT CONCAT(s.AA_BB_CC, ' ', w.Short_name)
     INTO @v_fullsikcode
     FROM n_lica l
          left join n_lica_izbori i on l.id = i.id_lice AND i.TUR = @v_tur
              inner join wnsila w on w.ID_Party = i.id_sila
              inner join siks s on i.id_sik = s.Id_sek
     WHERE l.id <> prmID
       and l.Vid_id = prmVid 
       and AES_DECRYPT(FROM_BASE64(l.EGN),prmDummy)=prmEGN
       and (s.TOA = prmToa OR (s.sik != '000' and s.TOA != prmToa))
     LIMIT 1;                  

  IF LENGTH(IFNULL (@v_fullsikcode,''))>0 THEN
      IF prmVid = 2 THEN
        SET retval =concat('Дублирано ЛНЧ (',@v_fullsikcode,')');
      ELSE
        SET retval =concat('Дублирано ЕГН (',@v_fullsikcode,')');
      END IF;
  ELSE
       -- proverka za korektno EGN
    IF checkNumber(prmVid, prmEGN) = -1 THEN
      IF prmVid = 2 THEN
        SET retval = "Грешно ЛНЧ.";
      ELSE
        SET retval = "Грешно ЕГН.";
      END IF;
    END IF;  
  END IF;
  
  SELECT retval as ImpMessage;  	
END;
//

DELIMITER //
