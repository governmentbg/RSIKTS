DROP FUNCTION IF EXISTS fnGetLiceBirthYear;

DELIMITER //

CREATE FUNCTION fnGetLiceBirthYear (prmEGN varchar(10)) RETURNS int
BEGIN
  SET NAMES 'utf8';
         
  SET @birthyear = convert(left(prmEGN,2), UNSIGNED INTEGER);    
  SET @birthmont = convert(substring(prmEGN,3,2), UNSIGNED INTEGER);
    
  CASE 
    WHEN @birthmont > 40 THEN 
      SET @birthyear = 2000+@birthyear;
    WHEN @birthmont > 20 and @birthmont < 40 THEN 
      SET @birthyear = 1800+@birthyear;
    ELSE
      SET @birthyear = 1900+@birthyear;      
  END CASE;  
  
  RETURN @birthyear;  	
END;
//

DELIMITER //
