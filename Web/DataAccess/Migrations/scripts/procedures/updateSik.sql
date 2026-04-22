DROP PROCEDURE IF EXISTS updateSik;

DELIMITER //

CREATE PROCEDURE updateSik(
  prmID         int
  ,prmIzb_Alias  varchar(6)
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
  ,prmStatus_Sekcia int
  ,prmBroiMembers int  
  ,prmNumbVoters int
  ,prmBorders   text  
  ,prmUSER      varchar(128)
)
BEGIN
    SET NAMES 'utf8';
    SET @v_izbrajon = IFNULL(fnGetIzborenRajon(prmIzb_Alias,prmTOA),'00');
    SET @v_fullSik = CONCAT(fnGetFullSikNumber(prmTOA),prmSik) collate utf8_unicode_ci;
    
    SELECT AA_BB_CC, Sik,Obl,Obs,NAS,JK_KV,UL,Nom,BLok,ADR_IME,broimembers,Status_Sekcia,numbvoters,borders
    INTO @v_AA_BB_CC, @v_Sik,@v_Obl,@v_Obs,@v_NAS,@v_JK_KV,@v_UL,@v_Nom,@v_BLok
        ,@v_ADR_IME,@v_broimembers,@v_Status_Sekcia,@v_numbvoters,@v_borders
    FROM siks         
    WHERE Id_sek = prmID;
    
    SET @v_oldaddress = fnGetSikAddress(prmID);
    
    UPDATE siks 
      SET Izb_Alias   = prmIzb_Alias
      ,TUR            = prmTUR
      ,Izb_rajon      = @v_izbrajon 
      ,TOA            = prmTOA
      ,AA_BB_CC       = @v_fullSik
      ,Sik            = prmSik
      ,Obl            = prmObl
      ,Obs            = prmObs
      ,NAS            = prmNAS
      ,JK_KV          = prmJK_KV
      ,UL             = prmUL
      ,Nom            = prmNom
      ,BLok           = prmBLok
      ,ADR_IME        = prmADR_IME
      ,Status_Sekcia  = prmStatus_Sekcia
      ,USER           = prmUSER
      ,KOGA           = now()
      ,broimembers    = prmBroiMembers        /*  v.2  */
      ,numbvoters     = prmNumbVoters
      ,borders        = prmBorders
    WHERE Id_sek = prmID;
    
    SET @v_newaddress = fnGetSikAddress(prmID);

    IF @v_Status_Sekcia <> prmStatus_Sekcia THEN
      IF prmStatus_Sekcia = 1 THEN
        call createSikLog (prmUser, prmTOA, @v_FullSIK, 13, 'Активирана','','');
      ELSE
        call createSikLog (prmUser, prmTOA, @v_AA_BB_CC, 14, 'Деактивирана','','');
      END IF;  
    ELSE    
      IF  @v_oldaddress <> @v_newaddress THEN
          call createSikLog (prmUser, prmTOA, @v_AA_BB_CC, 21
                            ,'Смяна в адрес',@v_oldaddress,@v_newaddress);
      END IF;
      
      IF  @v_ADR_IME <> prmADR_IME THEN
          call createSikLog (prmUser, prmTOA, @v_AA_BB_CC, 22
                            ,'Смяна в описание',@v_ADR_IME,prmADR_IME);      
      END IF;
      
      IF  @v_broimembers <> prmBroiMembers THEN
          call createSikLog (prmUser, prmTOA, @v_AA_BB_CC, 23
                            ,'Смяна брой членове в СИК', @v_broimembers ,prmBroiMembers);      
      END IF;
        
      IF  @v_numbvoters <> prmNumbVoters THEN
          call createSikLog (prmUser, prmTOA, @v_AA_BB_CC, 24
                            ,'Смяна брой избиратели', @v_numbvoters ,prmNumbVoters);      
      END IF;

      IF  IFNULL(STRCMP(@v_borders,prmBorders),-1) <> 0 THEN
          call createSikLog (prmUser, prmTOA, @v_AA_BB_CC, 25
                            ,'Промяна в границите', @v_borders ,prmBorders);      
      END IF;

    END IF;
    
  	SELECT prmID as Id;
END;
//

DELIMITER ;	