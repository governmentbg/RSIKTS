DROP FUNCTION IF EXISTS fnSearchNumber;

DELIMITER //

CREATE FUNCTION fnSearchNumber (prmDigit char) RETURNS varchar(20)
BEGIN
    return CASE prmDigit
              WHEN '1' THEN 'един'
              WHEN '2' THEN 'два'
              WHEN '3' THEN 'три'
              WHEN '4' THEN 'четири'
              WHEN '5' THEN 'пет'
              WHEN '6' THEN 'шест'
              WHEN '7' THEN 'седем'
              WHEN '8' THEN 'осем'
              WHEN '9' THEN 'девет'
              ELSE ''
            END;
END;
//

DELIMITER //
