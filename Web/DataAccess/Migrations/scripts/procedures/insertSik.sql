DROP PROCEDURE IF EXISTS insertSik;

DELIMITER //

CREATE PROCEDURE insertSik(
  prmIzb_Alias  varchar(6)
  ,prmTUR       int
  ,prmIzb_rajon varchar(2)
  ,prmTOA       varchar(2)
  ,prmAA_BB_CC  varchar(6)
  ,prmSik       varchar(3)
  ,prmObl       varchar(3)
  ,prmObs       varchar(5)
  ,prmNAS       varchar(5)
  ,prmJK_KV     varchar(3)
  ,prmUL        varchar(5)
  ,prmNom       varchar(5)
  ,prmBLok      varchar(5)
  ,prmADR_IME   varchar(250)
  ,prmUSER      varchar(128)
  ,prmStatus_Sekcia int
  ,prmBroiMembers int
  ,prmNumbVoters int
  ,prmBorders   text
  ,OUT prmId    int
)
BEGIN
    SET NAMES 'utf8';

    SET @v_izbrajon = IFNULL(fnGetIzborenRajon(prmIzb_Alias,prmTOA),'00');
    SET @v_FullSIK = CONCAT(fnGetFullSikNumber(prmTOA),prmSik) collate utf8_unicode_ci;
    
    INSERT INTO siks (Izb_Alias,TUR,Izb_rajon,TOA,AA_BB_CC,Sik,
                      Obl,Obs,NAS,JK_KV,UL,Nom,BLok,ADR_IME,USER,KOGA,Status_Sekcia,
                      broimembers, numbvoters, borders)
    VALUES (
      prmIzb_Alias
      ,prmTUR
      ,@v_izbrajon 
      ,prmTOA
      ,@v_FullSIK
      ,prmSik
      ,prmObl
      ,prmObs
      ,prmNAS
      ,prmJK_KV
      ,prmUL
      ,prmNom
      ,prmBLok
      ,prmADR_IME
      ,prmUSER
      ,now()
      ,1
      ,prmBroiMembers             /*  v.2  */
      ,prmNumbVoters
      ,prmBorders
    );
  
     SELECT LAST_INSERT_ID() INTO prmId FROM DUAL;    
     
    call createSikLog (prmUser, prmTOA, @v_FullSIK, 12, 'Нова','','');
    SELECT prmId as 'Id' FROM DUAL;    
END;
//

DELIMITER ;	