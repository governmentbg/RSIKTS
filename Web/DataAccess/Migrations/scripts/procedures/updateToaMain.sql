DROP PROCEDURE IF EXISTS updateToaMain;

DELIMITER //

CREATE PROCEDURE updateToaMain(
  prmId             int
  ,prmIzb_Alias      varchar(6)
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
      
   SET @izbrajon =  fnGetIzborenRajon(prmIzb_Alias, prmToa);
   
   IF checkNumber (3,prmBul) = -1 THEN
     SET prmBul = '';
   END IF;  
   
   SELECT  NIME, PREFIX
      INTO @izbrajon_name, @izbrajon_predstavka
      FROM wnizbraion
      WHERE nkod =  @izbrajon
        AND IZB_ALIAS = prmIzb_Alias;
        
   UPDATE n_toa_main 
    SET `IZB_ALIAS` = prmIzb_Alias 
        ,`TOA`      = prmTOA
        ,`Tur`      = prmTur
        ,`Status_Master` = prmStatus_Master
        ,`IME`      = prmIME
        ,`TEL`      = prmTel
        ,`Tel1`     = prmTel1
        ,`Izr`      = prmIzr
        ,`OBL`      = prmObl
        ,`OBS`      = prmObs
        ,`RAJ`      = prmRaj
        ,`NAS`      = prmNas
        ,`UL`       = prmUl
        ,`NOM`      = prmNom
        ,`JK_KV`    = prmJK_KV
        ,`BLOK`     = prmBlok
        ,`VH`       = prmVH
        ,`ET`       = prmET
        ,`AP`       = prmAP
        ,`PK`       = prmPK
        ,`EPOD`     = prmEPOD
        ,`IPOD`     = prmIPOD
        ,`Pred`     = prmPred
        ,`Sekr`     = prmSekr
        ,`Nsik`     = prmNSIK
        ,`Pris`     = IFNULL(@izbrajon_predstavka,'0000')
        ,`R1`       = @izbrajon_name
        ,`R2`       = prmR2
        ,`ANO`      = prmANO
        ,`Bul`      = prmBul
    WHERE NREC = prmId;
    
    IF prmANO <> 0 THEN
        UPDATE siks 
          SET broimembers =prmANO
          WHERE TOA = prmTOA;
    END IF;
    
    call createLog (prmUSER, 5,'Редактиране на Административен район',IFNULL(prmIME,''),IFNULL(prmToa,''),'');  
    SELECT prmId as 'Id' FROM DUAL;    
END;
//

DELIMITER ;	