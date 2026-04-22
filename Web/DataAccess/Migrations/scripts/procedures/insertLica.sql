DROP PROCEDURE IF EXISTS insertLica;

DELIMITER //

CREATE PROCEDURE `insertLica`(
   prmVid_id      int
  ,prmEGN         varchar(128)
  ,prmIM1         varchar(128)
  ,prmIM2         varchar(128)
  ,prmIM3         varchar(128)
  ,prmObra        varchar(16)
  ,prmSpec        varchar(16)
  ,prmTEL         varchar(14) 
  ,prmPAS1        varchar(1)
  ,prmPAS2        varchar(10)
  ,prmPAS3        datetime
  ,prmPAS4        varchar(2)
  ,prmNAZ         varchar(2)
  ,prmOBL         varchar(3)
  ,prmOBS         varchar(5)
  ,prmRAJ         varchar(2)
  ,prmNAS         varchar(5)
  ,prmULKOD       varchar(5)
  ,prmNOM         varchar(6)
  ,prmJK_KV       varchar(2)
  ,prmBLOK        varchar(5)
  ,prmVH          varchar(2)
  ,prmET          varchar(2)
  ,prmAP          varchar(3)
  ,prmPK          varchar(4)
  ,prmimpstatus   int
  ,prmimpmessage  varchar(100)
  ,prmUSER        varchar(128) 
  ,prmToa         varchar(2)  
  ,prmDummy       varchar(30)
  ,OUT prmId      int
)
BEGIN
    DECLARE prmIME      varchar(250);

    SET NAMES 'utf8';
     
    IF NOT EXISTS(SELECT 1 
                    FROM n_lica l 
                          inner join n_lica_izbori i on l.ID = i.id_lice
                          inner join siks s on i.ID_sik = s.id_sek                    
                    WHERE l.VID_ID =  prmVid_id 
                      AND l.EGN = TO_BASE64(AES_ENCRYPT(prmEGN,prmDummy))
                      and (s.TOA = prmToa OR (s.sik != '000' and s.TOA != prmToa))
                  )
    THEN                      
        INSERT INTO n_lica (VID_ID,EGN,IM1,IM2 ,IM3,Obra,Spec,TEL,PAS1,PAS2,PAS3,PAS4,NAZ
              ,OBL,OBS,RAJ,NAS,UL,NOM,JK_KV,BLOK,VH,ET,AP,PK,impstatus,impmessage,USER,KOGA
        )
        VALUES (
          prmVid_id
    /*      
          ,prmEGN
          ,UPPER(prmIM1)
          ,UPPER(prmIM2)
          ,UPPER(prmIM3)
    */
          
          ,TO_BASE64(AES_ENCRYPT(prmEGN,prmDummy))
          ,TO_BASE64(AES_ENCRYPT(UPPER(prmIM1),prmDummy))
          ,TO_BASE64(AES_ENCRYPT(UPPER(prmIM2),prmDummy))
          ,TO_BASE64(AES_ENCRYPT(UPPER(prmIM3),prmDummy))
          
          ,prmObra
          ,prmSpec
          ,prmTEL
          ,null
          ,prmPAS2
          ,prmPAS3
          ,prmPAS4
          ,prmNAZ
          ,prmOBL
          ,prmOBS
          ,prmRAJ
          ,prmNAS
          ,prmULKOD
          ,prmNOM
          ,prmJK_KV
          ,prmBLOK
          ,prmVH
          ,prmET
          ,prmAP
          ,prmPK
          ,prmimpstatus
          ,prmimpmessage
          ,prmUSER
          ,now()
        );
      
       SELECT LAST_INSERT_ID() INTO prmID FROM DUAL;    

       SET prmIME =  CONCAT(UPPER(prmIM1),' ',
                           IFNULL(UPPER(prmIM2),''),' ',
                           IFNULL(UPPER(prmIM3),''));

       call createLog (prmUSER, 1,'Ново лице',CONCAT(prmIme,' [',prmID,']'),IFNULL(prmToa,''),'');

       SELECT prmID as 'Id' FROM DUAL;
    ELSE
       SELECT -1 as 'Id' FROM DUAL;
    END IF;
END
//

DELIMITER ;	