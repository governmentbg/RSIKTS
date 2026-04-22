DROP PROCEDURE IF EXISTS insertToaMain;

DELIMITER //

CREATE PROCEDURE insertToaMain(
  prmIzb_Alias       varchar(6)
  ,prmTOA            varchar(2)
  ,prmTur            tinyint
  ,prmStatus_Master  int
  ,prmIME            varchar(30)
  ,prmTEL            varchar(10)
  ,prmTel1           varchar(10)
  ,prmIzr            varchar(15)
  ,prmOBL            varchar(3)
  ,prmOBS            varchar(5)
  ,prmRAJ            varchar(2)
  ,prmNAS            varchar(5)
  ,prmUL             varchar(5)
  ,prmNOM            varchar(4)
  ,prmJK_KV          varchar(2)
  ,prmBLOK           varchar(5)
  ,prmVH             varchar(2)
  ,prmET             varchar(2)
  ,prmAP             varchar(3)
  ,prmPK             varchar(4)
  ,prmEPOD           varchar(30)
  ,prmIPOD           varchar(20)
  ,prmPred           varchar(20)
  ,prmSekr           varchar(20)
  ,prmNsik           int
  ,prmPris           varchar(10)
  ,prmR1             varchar(20)
  ,prmR2             varchar(20)
  ,prmANO            int
  ,prmBul            varchar(13)
  ,prmUSER           varchar(128)    
)
BEGIN
    SET NAMES 'utf8';

    IF checkNumber (3,prmBul) = -1 THEN
       SET prmBul = '';
    END IF;  
   
    SET @izbrajon =  fnGetIzborenRajon(prmIzb_Alias, prmToa);
  
    SELECT  NIME, PREFIX
      INTO @izbrajon_name, @izbrajon_predstavka
      FROM wnizbraion
      WHERE nkod =  @izbrajon
        AND IZB_ALIAS =prmIzb_Alias;
     
     
    IF LENGTH(prmOBL) = 0 THEN
      SET @OBL = 'SOF46';
    ELSE  
      SET @OBL =prmOBL;
    END IF;
    
    IF LENGTH(prmOBS) = 0 THEN
      SET @OBS = 'SOF46';
    ELSE  
      SET @OBS =prmOBL;
    END IF;
     
    IF LENGTH(prmNAS) = 0 THEN
      SET @NAS = '68134';
    ELSE  
      SET @NAS =prmNAS;
    END IF;
    
    INSERT INTO n_toa_main (`IZB_ALIAS`,`TOA`,`Tur`,`Status_Master`,`IME`,`TEL`,`Tel1`,`Izr`,`OBL`,`OBS`,`RAJ`,`NAS`,`UL`,`NOM`,`JK_KV`,`BLOK`
                           ,`VH`,`ET`,`AP`,`PK`,`EPOD`,`IPOD`,`Pred`,`Sekr`,`Nsik`,`Pris`,`R1`,`R2`,`ANO`,`Bul`)
    VALUES (
      prmIzb_Alias
      ,prmTOA
      ,prmTur
      ,prmStatus_Master
      ,prmIME
      ,prmTEL
      ,prmTel1
      ,prmIzr
      ,@OBL
      ,@OBS
      ,prmRAJ
      ,@NAS
      ,prmUL
      ,prmNOM
      ,prmJK_KV
      ,prmBLOK
      ,prmVH
      ,prmET
      ,prmAP
      ,prmPK
      ,prmEPOD
      ,prmIPOD
      ,prmPred
      ,prmSekr
      ,prmNsik
      ,IFNULL(@izbrajon_predstavka,'0000')
      ,@izbrajon_name
      ,prmR2
      ,prmANO
      ,prmBul
    );
  
    SELECT LAST_INSERT_ID() INTO @Id FROM DUAL;    
  
    call createLog (prmUSER, 5,'Нов Административен район',IFNULL(prmIME,''),IFNULL(prmToa,''),'');  
    SELECT @Id as 'Id' FROM DUAL;    
END;
//

DELIMITER ;	