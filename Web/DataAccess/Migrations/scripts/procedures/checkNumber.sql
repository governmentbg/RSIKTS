DROP FUNCTION  IF EXISTS checkNumber;

/*
  prmType = 1, EGN
          = 2, LNC
          = 3, BULSTAT
*/

DELIMITER //

CREATE FUNCTION  checkNumber (prmType int, prmValue varchar(20)) returns int

BEGIN
  DECLARE retval int;
  SET retval := -1;
     
  CREATE TEMPORARY TABLE if not exists tblvalues (val int, numb tinyint);

  CASE
    WHEN prmType = 2 THEN
      SET @fixlen := 10;      
      SET @Values = '21,19,17,13,11,9,7,3,1';

    WHEN prmType = 3 THEN          
      SET @Values  = '1,2,3,4,5,6,7,8';
      SET @Values2 = '3,4,5,6,7,8,9,10';

      IF Length(prmValue) = 13 THEN
        SET @fixlen := 13;
        SET @Values131 = '2,7,3,5';
        SET @Values132 = '4,9,5,7';
      ELSE
        SET @fixlen := 9;
      END IF;
      
     ELSE BEGIN
        SET @fixlen := 10;
        SET @Values = '2,4,8,5,10,9,7,3,6';      
     END;
  END CASE;    

  IF LENGTH(prmValue) = @fixlen THEN
    SET @cnt = 0;
    WHILE (LOCATE(',', @Values) > 0)
    DO
        SET @cnt   = @cnt +1;
        SET @value = ELT(1, @Values);
        SET @Values= SUBSTRING(@Values, LOCATE(',',@Values) + 1);
        
        SET @number =  SUBSTRING(prmValue, @cnt,1);
        INSERT INTO tblvalues VALUES(@value, IF(@number REGEXP '^[0-9]+$',@number, '-1'));
    END WHILE;

    SET @cnt = @cnt +1;
    SET @value = ELT(1, @Values);
    SET @number =  SUBSTRING(prmValue, @cnt,1);
    INSERT INTO tblvalues VALUES(@value, IF(@number REGEXP '^[0-9]+$',@number, '-1'));
    
    IF prmType = 3 THEN
       SET @result := (SELECT MOD(sum(val*numb),11) from tblvalues );
       
       IF @result = 10 THEN
          DELETE FROM tblvalues;
          
          SET @cnt = 0;
          WHILE (LOCATE(',', @Values2) > 0)
          DO
              SET @cnt   = @cnt +1;
              SET @value = ELT(1, @Values2);
              SET @Values2= SUBSTRING(@Values2, LOCATE(',',@Values2) + 1);

              INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt,1));
          END WHILE;

          SET @cnt   = @cnt +1;
          SET @value = ELT(1, @Values2);
          INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt,1));
          
          -- calculirame s 2-ta poredica
          SET @result := (SELECT MOD(sum(val*numb),11) from tblvalues );              
       END IF;
       
       IF @fixlen = 13 THEN
          DELETE FROM tblvalues;
          
          SET @cnt = 0;
          WHILE (LOCATE(',', @Values131) > 0)
          DO
              SET @cnt   = @cnt +1;
              SET @value = ELT(1, @Values131);
              SET @Values131= SUBSTRING(@Values131, LOCATE(',',@Values131) + 1);

              INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt+8,1));
          END WHILE;

          SET @cnt   = @cnt +1;
          SET @value = ELT(1, @Values131);
          INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt+8,1));
          
          -- calculirame s 2-ta poredica
          SET @result := (SELECT MOD(sum(val*numb),11) from tblvalues );              

          IF @result = 10 THEN
            DELETE FROM tblvalues;
            
            SET @cnt = 0;
            WHILE (LOCATE(',', @Values132) > 0)
            DO
                SET @cnt   = @cnt +1;
                SET @value = ELT(1, @Values132);
                SET @Values132= SUBSTRING(@Values132, LOCATE(',',@Values132) + 1);

                INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt+8,1));
            END WHILE;

            SET @cnt   = @cnt +1;
            SET @value = ELT(1, @Values132);
            INSERT INTO tblvalues VALUES(@value, SUBSTRING(prmValue, @cnt+8,1));
            
            -- calculirame s 2-ta poredica
            SET @result := (SELECT MOD(sum(val*numb),11) from tblvalues );              
          END IF;
      END IF;        
    ELSE
      IF prmType = 2 THEN
        SET @result := (select IF(MOD(sum(val*numb),10)=10,0,MOD(sum(val*numb),10)) from tblvalues);    
      ELSE
        SET @result := (select IF(MOD(sum(val*numb),11)=10,0,MOD(sum(val*numb),11)) from tblvalues);
      END IF;
    END IF;
    
    IF SUBSTRING(prmValue,@fixlen) = @result THEN
        SET retval := 0;
    END IF;
  END IF;
  
  DROP TEMPORARY TABLE tblvalues; 
  RETURN retval;  	
END
//

DELIMITER ;	
