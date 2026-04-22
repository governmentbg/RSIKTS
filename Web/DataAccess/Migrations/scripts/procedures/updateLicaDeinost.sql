DROP PROCEDURE IF EXISTS updateLicaDeinost;

DELIMITER //

CREATE PROCEDURE updateLicaDeinost(
  prmIdLice          int
  ,prmDeinost        int
  ,prmAdd            int
  ,prmUSER           varchar(128)
  ,prmDummy     varchar(30)
)
BEGIN
   DECLARE prmIME varchar(100);
   
   SET NAMES 'utf8';
   
   SELECT cast(value as unsigned integer)
      INTO @v_tur
      FROM sys_main 
      WHERE ID = 2;
      
    -- podava se ID ot n_lice i trjabva da namerim ID ot n_lice_izbori    
   SELECT i.ID , s.TOA
      INTO @v_id_lice_izbori, @v_toa
      FROM n_lica_izbori i inner join siks s on i.Id_Sik = s.Id_sek 
      WHERE i.ID_LICE = prmIdLice
        AND s.TUR = @v_tur;        
        
   SELECT CONCAT(CAST(AES_DECRYPT(FROM_BASE64(im1),prmDummy) as CHAR(50)),' ',
                 IFNULL(CAST(AES_DECRYPT(FROM_BASE64(im2),prmDummy) as CHAR(50)),''),' ',
                 CAST(AES_DECRYPT(FROM_BASE64(im3),prmDummy) as CHAR(50))) as ime
        INTO prmIME
        FROM n_lica
        WHERE ID = prmIdLice;
        
   SELECT NIME 
      INTO @v_name
      FROM n_list_codepositions
      WHERE PKODE = 3
        AND NKODE = prmDeinost;
      
   DELETE FROM n_lica_dopylnenie
      WHERE Id_Lice  = @v_id_lice_izbori
        AND VidCodetable = 3
        AND Idcodeposition = prmDeinost;
    
    
   IF prmAdd = 1 THEN
      INSERT INTO n_lica_dopylnenie (Id_Lice, VidCodetable, Idcodeposition, Status, User, Koga)
          VALUES (@v_id_lice_izbori, 3,prmDeinost,1,prmUSER, NOW());          

      call createLog (prmUSER, 4, @v_name,prmIME,@v_toa,'Да');   
   ELSE
      call createLog (prmUSER, 4, @v_name,prmIME,@v_toa,'Не');   
   END IF;
   
   
   SELECT prmIdLice as 'Id' FROM DUAL;    
END;
//

DELIMITER ;	