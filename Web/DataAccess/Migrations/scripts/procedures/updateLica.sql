DROP PROCEDURE IF EXISTS updateLica;

DELIMITER //

CREATE PROCEDURE updateLica (
   prmID      int
  ,prmVid_id  int
  ,prmEGN     varchar(128)
  ,prmIM1     varchar(128)
  ,prmIM2     varchar(128)
  ,prmIM3     varchar(128)
  ,prmObra    varchar(16)
  ,prmSpec    varchar(16)
  ,prmTEL     varchar(14) 
  ,prmPAS1    varchar(1)
  ,prmPAS2    varchar(10)
  ,prmPAS3    datetime
  ,prmPAS4    varchar(2)
  ,prmNAZ     varchar(2)
  ,prmOBL     varchar(2)
  ,prmOBS     varchar(4)
  ,prmRAJ     varchar(2)
  ,prmNAS     varchar(5)
  ,prmULKOD   varchar(5)
  ,prmNOM     varchar(6)
  ,prmJK_KV   varchar(2)
  ,prmBLOK    varchar(5)
  ,prmVH      varchar(2)
  ,prmET      varchar(2)
  ,prmAP      varchar(3)
  ,prmPK      varchar(4)
  ,prmimpstatus   int
  ,prmimpmessage  varchar(100)
  ,prmUSER      varchar(128) 
  ,prmToa       varchar(2)
  ,prmDummy     varchar(30)
)

BEGIN
    DECLARE prmIME      varchar(250);

    SET NAMES 'utf8';


  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);
    
    IF NOT EXISTS(SELECT 1 
                    FROM n_lica l 
                          inner join n_lica_izbori i on l.ID = i.id_lice AND i.Tur =  @v_tur
                          inner join siks s on i.ID_sik = s.id_sek                    
                    WHERE l.VID_ID =  prmVid_id 
                      AND l.EGN = TO_BASE64(AES_ENCRYPT(prmEGN,prmDummy))
                      and (s.TOA = prmToa OR (s.sik != '000' and s.TOA != prmToa))
                      AND l.ID  <> prmID                      
                   )
    THEN                      

        UPDATE n_lica 
          SET  Vid_id  = prmVid_id
              ,EGN    = TO_BASE64(AES_ENCRYPT(prmEGN,prmDummy))
              ,IM1    = TO_BASE64(AES_ENCRYPT(UPPER(prmIM1),prmDummy))
              ,IM2    = TO_BASE64(AES_ENCRYPT(UPPER(prmIM2),prmDummy))
              ,IM3    = TO_BASE64(AES_ENCRYPT(UPPER(prmIM3),prmDummy))
              ,Obra   = prmObra
              ,Spec   = prmSpec
              ,TEL    = prmTEL
--              ,PAS1   = prmPAS1
              ,PAS2   = prmPAS2
              ,PAS3   = prmPAS3
              ,PAS4   = prmPAS4
              ,NAZ    = prmNAZ
              ,OBL    = prmOBL
              ,OBS    = prmOBS
              ,RAJ    = prmRAJ
              ,NAS    = prmNAS
              ,UL     = prmULKOD
              ,NOM    = prmNOM
              ,JK_KV  = prmJK_KV
              ,BLOK   = prmBLOK
              ,VH     = prmVH
              ,ET     = prmET
              ,AP     = prmAP
              ,PK     = prmPK
              ,impstatus  = prmimpstatus
              ,impmessage = prmimpmessage
              ,USER   = prmUSER
              ,KOGA   = now()
          WHERE ID = prmID;
      
       SET prmIME =  CONCAT(UPPER(prmIM1),' ',
                           IFNULL(UPPER(prmIM2),''),' ',
                           IFNULL(UPPER(prmIM3),''));

       call createLog (prmUSER, 1,'Редактиране',CONCAT(prmIme,' [',prmID,']'),IFNULL(prmToa,''),'');      
       SELECT prmID as ID FROM DUAL;
    ELSE
       SELECT -1 as ID FROM DUAL;
    END IF;
END
//

DELIMITER ;	
