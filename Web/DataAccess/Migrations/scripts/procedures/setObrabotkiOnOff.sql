DROP PROCEDURE IF EXISTS setObrabotkiOnOff;

DELIMITER //

CREATE PROCEDURE setObrabotkiOnOff(
   prmUSER          varchar(128) 
   ,prmTOA          varchar(3)
)
BEGIN
  
  SET NAMES 'utf8';

  IF EXISTS(SELECT 1 FROM sys_main WHERE name = 'FINANCE' AND Value=prmTOA) THEN
      SELECT VALUE
        INTO @v_tur
        FROM sys_main
        WHERE ID =2;

     DELETE FROM sys_main WHERE name = 'FINANCE' AND Value=prmTOA;
     
     DELETE FROM n_lice_pari_zanap
        where ID_Lice in (select id 
                             from n_lica_izbori i inner join  siks s on i.id_sik = s.Id_sek
                             WHERE s.TOA = prmTOA
                               AND s.TUR = @v_tur);

     DELETE FROM n_lice_pari_zaplashtane 
        where ID_Lice in (select id 
                            from n_lica_izbori i inner join  siks s on i.id_sik = s.Id_sek
                             WHERE s.TOA = prmTOA
                               AND s.TUR = @v_tur);
        
     call createLog (prmUSER, 2,'Отмяна на финансовите изчисления','',prmTOA,'');     
  ELSE
     SELECT MAX(ID)+1 INTo @v_ID FROM sys_main;
     
     INSERT INTO sys_main (ID, Name, Value) 
          VALUES(@v_id, 'FINANCE',prmTOA);
  
     call createLog (prmUSER, 2,'Финансови изчисления','',prmTOA,'');
  END IF;   
  
END;
//

DELIMITER ;	