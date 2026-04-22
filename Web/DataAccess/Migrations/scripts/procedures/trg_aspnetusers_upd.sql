DROP TRIGGER IF EXISTS trg_aspnetusers_upd;

DELIMITER //

CREATE TRIGGER trg_aspnetusers_upd AFTER UPDATE ON aspnetusers
    FOR EACH ROW
    BEGIN
        IF NEW.Administrative_Rajon <> OLD.Administrative_Rajon and NEW.Administrative_Rajon is not null
        THEN  
           UPDATE sys_usermain 
              SET VALUE = NEW.Administrative_Rajon 
              WHERE USER = new.id 
                AND NAME = 'TOA';
        END IF;
    END;
//

DELIMITER ;