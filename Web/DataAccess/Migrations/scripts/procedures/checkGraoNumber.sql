DROP PROCEDURE IF EXISTS checkGraoNumber;

DELIMITER //

CREATE PROCEDURE checkGraoNumber (
    prmGraoNumber   varchar(10)
    ,prmGraoType    integer
)

BEGIN
  DECLARE v_year,v_month,v_day varchar(10);
  
  SET NAMES 'utf8';  

  SET @retval := checkNumber (prmGraoType,prmGraoNumber);
  
  IF (@retval = 0 AND prmGraoType < 2) THEN
    SET @year := CONVERT(LEFT(prmGraoNumber,2), SIGNED);
    SET @month := CONVERT(SUBSTRING(prmGraoNumber,3,2),SIGNED);
    SET @day := SUBSTRING(prmGraoNumber,5,2);
    
    IF (@month >= 21 AND @month <= 32) THEN
        SET @year := 1800+@year;
        SET @month :=  @month-20;
    ELSE 
      IF (@month >= 41 AND @month <= 52) THEN  
        SET @year := 2000+@year;
        SET @month := @month-40;
      ELSE
        SET @year := 1900+@year;
      END IF;
    END IF;    
    
    SET @birthdate = STR_TO_DATE(CONCAT(cast(@year as NCHAR),'-',cast(@month as NCHAR),'-',@day), '%Y-%m-%d');
   
    IF TIMESTAMPDIFF(YEAR, @birthdate, CURDATE()) < 18 THEN
       SET @retval := 1;
    END IF;
  END IF;
  
  
  SELECT @retval as id;
END;
//

DELIMITER //
