DROP PROCEDURE IF EXISTS createNewTurOrElection;

DELIMITER //

CREATE PROCEDURE createNewTurOrElection(
   prmUSER          varchar(128) 
   ,prmIzbAlias     varchar(6)
   ,prmTUR          int
)
BEGIN
   SET NAMES 'utf8';
  
   DELETE FROM n_log_dokumenti;

   -- inicializacia na bazata
   IF  prmTUR = -1 THEN
      DELETE FROM n_log;
      DELETE FROM n_log_deinosti;
      DELETE FROM n_log_lica;
      DELETE FROM n_log_sik_istoria;
      
      DELETE FROM n_lice_pari_zanap;
      DELETE FROM n_lice_pari_zaplashtane;
      DELETE FROM n_lice_pari_zaplashtane_ottur1;
      
      DELETE FROM n_lica_dopylnenie;
      DELETE FROM n_lica_dopylnenie_ottur1;
      DELETE FROM n_lica_izbori_zamestvane;
      DELETE FROM n_lica_izbori;             
      DELETE FROM n_lica_import;
      DELETE FROM N_LICA;
      
      DELETE FROM n_top_partgrid;
      DELETE FROM n_top_partkvoti;
      
      DELETE FROM siks_vidove 
        WHERE ID_sik  IN (SELECT ID_SEK FROM SIKS WHERE SIK != '000');
        
      DELETE FROM siks_podvijni
        WHERE ID_sik in (SELECT ID_SEK FROM SIKS WHERE SIK != '000'); 
        
      DELETE FROM siks WHERE SIK != '000';
      
      DELETE FROM siks_vidove 
        WHERE ID_sik  IN (SELECT ID_SEK FROM SIKS WHERE (IFNULL(IZB_ALIAS,'') <> prmIzbAlias 
                OR IZB_RAJON <> fnGetIzborenRajon(prmIzbAlias,toa)));
                
      DELETE FROM siks 
        WHERE (IFNULL(IZB_ALIAS,'') <> prmIzbAlias 
                OR IZB_RAJON <> fnGetIzborenRajon(prmIzbAlias,toa));

      INSERT INTO SIKS (Izb_Alias, TUR, Izb_rajon, TOA,AA_BB_CC,Sik,Status_Sekcia,Obl,Obs,NAS,USER,Koga)
        SELECT prmIzbAlias, 1
              ,fnGetIzborenRajon(prmIzbAlias,wntoa.nkod), wntoa.nkod
              ,fnGetFullSikNumber(wntoa.nkod), '000',0,'SOF','SOF46','68134',prmUSER, now() 
        FROM wntoa
        WHERE NOT EXISTS (SELECT 1 FROM SIKS WHERE TOA = wntoa.nkod);
            
      DELETE FROM sys_main WHERE NAME = 'FINANCE';
      UPDATE sys_main SET VALUE =1 WHERE ID  = 2;
    
      DELETE FROM sys_toamain;
      DELETE FROM sys_usermain;
      
      INSERT INTO sys_usermain (`User`,`Name`,`Value`)
        SELECT Id, 'TOA',IFNULL(administrative_rajon,'01')
            FROM aspnetusers;
      
      call createLog (prmUSER, 2,concat('Инициализация на базата',DATE_FORMAT(now(), '%d/%m/%Y %H:%i:%s')),'','','');
   ELSE
     -- ako go ima aliasa, preminavane kym tur 2
     IF EXISTS (SELECT 1
                  FROM sys_main
                  WHERE ID = 1
                    AND VALUE = prmIzbAlias)
     THEN   
        -- prowerka dali veche ne e tur=2
        IF EXISTS (SELECT 1 
                     FROM sys_main 
                     WHERE ID  = 2 
                     AND Value = '1') 
        -- prowerka dali izborite imat tur=2
          AND EXISTS (SELECT 1 
                        FROM wntipizbori 
                        WHERE nkod = left(prmIzbAlias,2) 
                          and tur=2 
                          and status=1) 
        THEN
           DELETE FROM n_toa_main
             WHERE IZB_ALIAS = prmIzbAlias 
                AND TUR = 2;
                      
           INSERT INTO n_toa_main (`IZB_ALIAS`,`TOA`,`Tur`,`Status_Master`,`IME`,`TEL`,`Tel1`,`Izr`,`OBL`,`OBS`,`RAJ`,`NAS`,`UL`,`NOM`,`JK_KV`,`BLOK`
                           ,`VH`,`ET`,`AP`,`PK`,`EPOD`,`IPOD`,`Pred`,`Sekr`,`Nsik`,`Pris`,`R1`,`R2`,`ANO`,`Bul`)
           SELECT IZB_ALIAS,TOA,2,`Status_Master`,`IME`,`TEL`,`Tel1`,`Izr`,`OBL`,`OBS`,`RAJ`,`NAS`,`UL`,`NOM`,`JK_KV`,`BLOK`
                   ,`VH`,`ET`,`AP`,`PK`,`EPOD`,`IPOD`,`Pred`,`Sekr`,`Nsik`,`Pris`,`R1`,`R2`,`ANO`,`Bul`
              FROM n_toa_main
              WHERE IZB_ALIAS = prmIzbAlias 
                AND TUR = 1;
            
           DELETE FROM normi_operacii
             WHERE Izb_allias = prmIzbAlias 
                AND TUR = 2;

           INSERT INTO normi_operacii (`Izb_allias`,`Tur`,`Vid_codetable`,`Idcodeposition`,`Pari`,`Status`,`User`,`Koga`) 
               SELECT `Izb_allias`,2,`Vid_codetable`,`Idcodeposition`,`Pari`,`Status`,prmUSER,now()
                FROM normi_operacii
                WHERE Izb_allias = prmIzbAlias 
                  AND TUR = 1;

           DELETE FROM normi_priznaci
             WHERE Izb_allias = prmIzbAlias 
                AND TUR = 2;

           INSERT INTO normi_priznaci (`Izb_allias`,`Tur`,`Vid_codetable`,`Idcodeposition`,`Pari`,`Status`,`User`,`Koga`) 
               SELECT `Izb_allias`,2,`Vid_codetable`,`Idcodeposition`,`Pari`,`Status`,prmUSER,now()
                FROM normi_priznaci
                WHERE Izb_allias = prmIzbAlias 
                  AND TUR = 1;

           DELETE FROM normi_roli
             WHERE Izb_allias = prmIzbAlias 
                AND TUR = 2;

           INSERT INTO normi_roli (`Izb_allias`,`Tur`,  `Vid_codetable_1`,`Idcodeposition_1`
                                  ,`Vid_Codetable`,`Idcodeposition`,`Pari`,`Status`,`User`,`Koga`) 
               SELECT `Izb_allias`, 2, `Vid_codetable_1`,`Idcodeposition_1`
                     ,`Vid_Codetable`,`Idcodeposition`,`Pari`,`Status`,prmUSER,now()
                FROM normi_roli
                WHERE Izb_allias = prmIzbAlias 
                  AND TUR = 1;

          INSERT INTO N_LICA_DOPYLNENIE_OTTUR1
            SELECT *
              FROM N_LICA_DOPYLNENIE
              WHERE ID_LICE IN (SELECT id 
                                    FROM n_lica_izbori n 
                                          inner join siks s ON n.Id_Sik=s.Id_sek 
                                    WHERE s.IZB_ALIAS = prmIzbAlias 
  --                                    AND s.TUR = 2
                                  );
                                
          DELETE FROM n_lica_dopylnenie 
              WHERE ID_LICE IN (SELECT id 
                                  FROM n_lica_izbori n 
                                        inner join siks s ON n.Id_Sik=s.Id_sek 
                                  WHERE s.IZB_ALIAS = prmIzbAlias 
--                                    AND s.TUR = 2
                                );
           
                                  
          INSERT INTO n_lica_izbori_zamestvane_ottur1 
            SELECT *
              FROM n_lica_izbori_zamestvane
              WHERE ID_Lice_novo IN (SELECT id 
                                  FROM n_lica_izbori n 
                                        inner join siks s ON n.Id_Sik=s.Id_sek 
                                  WHERE s.IZB_ALIAS = prmIzbAlias 
--                                    AND s.TUR = 2
                                );
              
          DELETE FROM n_lica_izbori_zamestvane 
              WHERE ID_Lice_novo IN (SELECT id 
                                  FROM n_lica_izbori n 
                                        inner join siks s ON n.Id_Sik=s.Id_sek 
                                  WHERE s.IZB_ALIAS = prmIzbAlias 
--                                    AND s.TUR = 2
                                );

          DELETE FROM n_lica_izbori 
              WHERE ID_SIK IN (SELECT id_sek FROM siks   WHERE IZB_ALIAS = prmIzbAlias AND TUR = 2);

           DELETE FROM siks_vidove
              WHERE ID_sik in (SELECT id_sek FROM siks   WHERE IZB_ALIAS = prmIzbAlias AND TUR = 2); 
              
           DELETE FROM siks_podvijni
              WHERE ID_sik in (SELECT id_sek FROM siks   WHERE IZB_ALIAS = prmIzbAlias AND TUR = 2); 
 
           DELETE FROM siks WHERE IZB_ALIAS = prmIzbAlias AND TUR = 2; 

           INSERT INTO siks (Izb_Alias,TUR,Izb_rajon,TOA,AA_BB_CC,Sik,Obl,Obs,NAS,JK_KV,UL,Nom,BLok,ADR_IME
                            ,USER,KOGA,Status_Sekcia,broimembers,numbvoters,borders)
                SELECT Izb_Alias,2,Izb_rajon,TOA,AA_BB_CC,Sik,Obl,Obs,NAS,JK_KV,UL,Nom,BLok,ADR_IME
                            ,prmUSER,now(),Status_Sekcia,broimembers,numbvoters,borders
                  FROM SIKS
                  WHERE IZB_ALIAS = prmIzbAlias 
                    AND TUR = 1;

           CREATE TEMPORARY TABLE IF NOT EXISTS tblsiks (
                old_idsek int,
                new_idsek int
           );

           CREATE TEMPORARY TABLE IF NOT EXISTS tblizbori (
                old_id int,
                new_id int
           );
    
           INSERT INTO tblsiks
                SELECT s1.id_sek, s2.id_sek
                  FROM siks s1 inner join siks s2 on s1.Izb_Alias = s2.Izb_Alias and s1.toa = s2.toa and s1.sik = s2.sik and s2.tur=2
                  WHERE s1.Izb_Alias = prmIzbAlias 
                    AND s1.TUR = 1;
                       
           INSERT INTO siks_vidove (IZB_allias,Tur,Id_Sik,Vid_codetable,Idcodeposition,Status)
                SELECT s1.IZB_allias,2,t.new_idsek,s1.Vid_codetable,s1.Idcodeposition,s1.Status
                  FROM SIKS_VIDOVE s1 inner join tblsiks t on s1.id_sik = t.old_idsek
                  WHERE s1.IZB_allias = prmIzbAlias 
                    AND s1.TUR = 1;
                     
           INSERT INTO siks_podvijni (Id_Sik,TOA,Voter_number,USER,Koga)
                SELECT t.new_idsek,TOA,Voter_number,USER,Koga
                  FROM siks_podvijni s1 inner join tblsiks t on s1.id_sik = t.old_idsek;

           INSERT INTO n_lica_izbori (`ID_Lice`,`Izb_Alias`,`Tur`,`TOA`,`Id_Sik`,`id_sila`,`Re`,`Code_rolia`,`Ime_rolia`,USER,KOGA)
               SELECT i.ID_Lice,i.Izb_Alias,2,i.TOA,t.new_idsek,i.id_sila,i.Re,i.Code_rolia,i.Ime_rolia,prmUSER,now()
                FROM n_lica_izbori i inner join tblsiks t on i.Id_Sik = t.old_idsek
                WHERE i.IZB_ALIAS = prmIzbAlias 
                  AND i.TUR = 1;


           INSERT INTO tblizbori
                SELECT s1.id, s2.id
                  FROM n_lica_izbori s1 inner join n_lica_izbori s2 on s1.izb_alias = s2.izb_alias and s1.id_lice = s2.id_lice and s2.tur=2
                  WHERE s1.IZB_ALIAS = prmIzbAlias 
                    AND s1.TUR = 1;

/*
           INSERT INTO n_lica_dopylnenie ( Id_Lice,VidCodetable,Idcodeposition,Status,User,Koga)
              SELECT t.new_id,VidCodetable,Idcodeposition,Status,prmUser,now()
                FROM  n_lica_dopylnenie d inner join tblizbori t on d.id_lice = t.old_id;
*/
             
          UPDATE sys_main
            SET value = 2
            WHERE id = 2;
                    
          DELETE FROM sys_main WHERE NAME = 'FINANCE';
           
          SELECT MAX(ID)+1 INTo @v_ID FROM sys_main;
          INSERT INTO sys_main (ID,NAME,VALUE) 
                VALUES (@v_ID,'TUR2KOGA', UNIX_TIMESTAMP(now()));

          DROP TEMPORARY TABLE IF EXISTS tblsiks;
          DROP TEMPORARY TABLE IF EXISTS tblizbori;
 
          call createLog (prmUSER, 2,concat('Преминаване към тур 2: ',DATE_FORMAT(now(), '%d/%m/%Y %H:%i:%s')),'','','');
        END IF;
     ELSE     
		-- novi izbori
       DELETE FROM n_log;
       DELETE FROM n_log_deinosti;
       DELETE FROM n_log_lica;
       DELETE FROM n_log_sik_istoria;
       
       DELETE FROM sys_main WHERE NAME = 'FINANCE';
       DELETE FROM sys_main WHERE NAME = 'TUR2KOGA';       
       
	   -- zapazwame stariq alias
	   SELECT MAX(IF(id=1,VALUE,''))
        INTO @v_oldizbalias
        FROM sys_main
        WHERE ID = 1;
		
	   UPDATE sys_main SET VALUE =prmIzbAlias WHERE ID  = 1;
     UPDATE sys_main SET VALUE =1 WHERE ID  = 2;
   
     UPDATE wnizbraion 
        SET IZB_ALIAS= prmIzbAlias;
     
     IF EXISTS (SELECT 1 
                      FROM wntipizbori 
                      WHERE nkod = left(prmIzbAlias,2) 
                        and tur=2 
                        and status=1)
     THEN
         UPDATE wnizbraion 
            SET status = 1
            WHERE nkod = '22';

         UPDATE wnizbraion 
            SET status = 0
            WHERE nkod <> '22';
     ELSE
         UPDATE wnizbraion 
            SET status = 0
            WHERE nkod = '22';

         UPDATE wnizbraion 
            SET status = 1
            WHERE nkod <> '22';
     END IF;
                         
     UPDATE n_list_codepositions
        SET IZB_ALLIAS = prmIzbAlias;

     UPDATE n_toa_main
        SET IZB_ALIAS = prmIzbAlias;
        
     UPDATE n_top_dancoef
        SET IZB_ALLIAS = prmIzbAlias;
        
     UPDATE n_top_parameters
        SET IZB_ALIAS = prmIzbAlias;
        
     UPDATE n_top_partkvoti
        SET IZB_ALIAS = prmIzbAlias, SIK_Clenove=0;

     UPDATE wnsila
        SET IZB_alias = prmIzbAlias;
        
     DELETE FROM wndocs;
     
     DELETE FROM N_LICA_DOPYLNENIE_OTTUR1;                                  
     DELETE FROM n_lica_izbori_zamestvane_ottur1;
     
     DELETE FROM n_lice_pari_zanap;
     DELETE FROM n_lice_pari_zaplashtane;
     DELETE FROM n_lica_dopylnenie;
     DELETE FROM n_lica_izbori_zamestvane;
     DELETE FROM n_lica_izbori;             
     DELETE FROM n_lica_import;
     DELETE FROM N_LICA;
     
     DELETE FROM normi_operacii;
     DELETE FROM normi_priznaci;
     DELETE FROM normi_roli;
     DELETE FROM n_top_partgrid;
     
     -- iztrivame vsichko ot podvizjnite sekcii
     DELETE FROM siks_podvijni; 

    -- iztrivame vsichko za SIK=000   
     DELETE FROM siks_vidove 
        WHERE id_sik in (select Id_sek from siks where sik = '000');

     DELETE FROM siks 
      WHERE SIK = '000';

     -- iztrivame vsichko bez osnovnite code=101   
     DELETE FROM siks_vidove 
        WHERE ((Vid_codetable = 1 
          AND Idcodeposition <> 101) OR Vid_codetable > 1) ;

     DELETE FROM siks 
      WHERE not EXISTS (SELECT 1
                             FROM siks_vidove 
                             WHERE Id_Sik = siks.Id_sek);

     IF EXISTS (SELECT 1 
                      FROM wntipizbori 
                      WHERE nkod = left(@v_oldizbalias,2) 
                        and tur=2 
                        and status=1) THEN
       -- iztrivame vsichko ot tur=1   
       DELETE FROM siks_vidove WHERE TUR=1;
       DELETE FROM siks WHERE TUR=1;
     END IF;            
      
     -- update IZB_allias
     UPDATE siks_vidove
        SET IZB_allias = prmIzbAlias
            ,TUR = 1;

     UPDATE siks
        SET IZB_alias = prmIzbAlias
          , TUR = 1;

     -- update pylniq nomer
     UPDATE siks
        SET AA_BB_CC = concat(fnGetFullSikNumber(TOA), sik)
           ,Izb_rajon = fnGetIzborenRajon(prmIzbAlias,TOA);
                          
     -- dobawqme nulevi sekcii   
     INSERT INTO SIKS (Izb_Alias, TUR, Izb_rajon, TOA,AA_BB_CC,Sik,Status_Sekcia,Obl,Obs,NAS,USER,Koga)
        SELECT prmIzbAlias, 1,fnGetIzborenRajon(prmIzbAlias,wntoa.nkod), wntoa.nkod
              ,concat(fnGetFullSikNumber(wntoa.nkod), '000'), '000',0,'SOF','SOF46','68134',prmUSER, now() 
        FROM wntoa
        WHERE NOT EXISTS (SELECT 1 FROM SIKS WHERE TOA = wntoa.nkod AND SIK = '000');

     INSERT INTO siks_vidove (IZB_allias,Tur,Id_Sik,Vid_codetable,Idcodeposition, Status)
        SELECT Izb_Alias, TUR, Id_sek, 1, 100,1
           FROM SIKS
           WHERE SIK = '000';
         
     CREATE TEMPORARY TABLE IF NOT EXISTS tbltoamain (
          `TOA` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL
     );
           
     INSERT INTO tbltoamain
      SELECT toa 
         FROM n_toa_main t 
         WHERE t.TUR=1; 
     
     DELETE FROM n_toa_main 
        WHERE TUR=2 
           AND EXISTS (SELECT 1 
                         FROM tbltoamain t 
                         WHERE n_toa_main.TOA = t.TOA);
                         
     DROP TEMPORARY TABLE IF EXISTS tbltoamain;                           

     UPDATE n_toa_main 
        SET TUR=1; 

     INSERT INTO n_toa_main (IZB_ALIAS, TOA, TUR, status_master, IME, OBL, OBS,RAJ,ANO )
     select prmIzbAlias, w.nkod as TOA, 1 as TUR,1 as status_master,w.NIME as IME, 'SOF' as OBL, 'SOF46' as OBS, w.nkod as RAJ, 0 as ANO 
        from  wntoa w left join n_toa_main t on w.nkod = t.toa
        where t.toa is null
        order by w.NKOD;

     UPDATE n_toa_main 
        SET PRIS = (SELECT  PREFIX
                        FROM wnizbraion
                        WHERE nkod =  fnGetIzborenRajon(prmIzbAlias, TOA)
                          AND IZB_ALIAS =prmIzbAlias);   

    UPDATE n_toa_main 
        SET R1 = (SELECT  NIME
                        FROM wnizbraion
                        WHERE nkod =  fnGetIzborenRajon(prmIzbAlias, TOA)
                          AND IZB_ALIAS =prmIzbAlias);   
               
     DELETE FROM sys_toamain;
     DELETE FROM sys_usermain;

     INSERT INTO sys_usermain (`User`,`Name`,`Value`)
      SELECT Id, 'TOA',IFNULL(administrative_rajon,'01')
          FROM aspnetusers;
          
      UPDATE n_top_parameters 
        SET Status_parameters = 1 
        WHERE KOD in ('52','53','54','55')
          AND IZB_ALIAS =prmIzbAlias;
        
      IF NOT EXISTS (SELECT 1 
                  FROM wntipizbori 
                  WHERE nkod = left(prmIzbAlias,2) 
                    and tur=2 
                    and status=1) THEN  
        UPDATE n_top_parameters 
          SET Status_parameters = 0 
          WHERE KOD in ('54','55')
            AND IZB_ALIAS =prmIzbAlias;
      END IF;
      
     call createLog (prmUSER, 2,concat('Преминаване към нови избори ',DATE_FORMAT(now(), '%d/%m/%Y %H:%i:%s')),'','','');      
    END IF;
  END IF;    
END;
//

DELIMITER ;	