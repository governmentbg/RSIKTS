DROP PROCEDURE IF EXISTS spravka_4_1;

DELIMITER //

CREATE PROCEDURE spravka_4_1(
  prmIZB_R    varchar(2)
  ,prmTOA     varchar(2)  
  ,prmType    tinyint
  ,prmUSER    varchar(128)
)
BEGIN   
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_4_1',prmTOA,'');

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);


  DROP TEMPORARY TABLE if exists tblizbr; 

  CREATE TEMPORARY TABLE if not exists tblizbr (toa varchar(2), toaname varchar(45), izb_rajon varchar(2), name varchar(45));
    
  DROP TEMPORARY TABLE if exists tblvalues; 
  
  CREATE TEMPORARY TABLE if not exists tblvalues (id int, toa varchar(2));

  IF convert(prmTOA, unsigned integer) > 0 THEN
      INSERT INTO tblvalues 
          SELECT id_sek, toa 
            FROM siks s
              inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
              inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
            WHERE s.Izb_Alias = @v_izbalias
              AND s.TUR = @v_tur
              AND s.TOA = prmToa
              AND s.status_sekcia = 1;               
              
      INSERT INTO tblizbr
        SELECT w.nkod, w.nime, w2.nkod, w2. nime
          FROM wntoa w 
              inner join wntoa_izbraion w1 ON w.nkod = w1.nkod
              inner join wnizbraion w2 ON w1.izb_r = w2.nkod and w2.IZB_ALIAS = @v_izbalias and w2.status=1
          WHERE w.nkod = prmTOA;
          
  ELSE
 
    IF prmIZB_R = '00' THEN
       INSERT INTO tblizbr
          SELECT w.nkod, w.nime, w2.nkod, w2. nime
            FROM wntoa w 
                inner join wntoa_izbraion w1 ON w.nkod = w1.nkod
                inner join wnizbraion w2 ON w1.izb_r = w2.nkod and w2.IZB_ALIAS = @v_izbalias and w2.status=1
            WHERE w2.status = 1;
            
    ELSE
       INSERT INTO tblizbr
          SELECT w.nkod, w.nime, w2.nkod, w2. nime
            FROM wntoa w 
                inner join wntoa_izbraion w1 ON w.nkod = w1.nkod
                inner join wnizbraion w2 ON w1.izb_r = w2.nkod and w2.IZB_ALIAS = @v_izbalias and w2.status=1
            WHERE w2.nkod = prmIZB_R
              AND w2.status = 1;

    END IF;    
  
    INSERT INTO tblvalues           
       SELECT s.id_sek, s.toa
       FROM tblizbr t
            INNER JOIN siks s 
                ON s.TOA = t.toa 
                    AND s.Izb_Alias = @v_izbalias 
                    AND s.TUR = @v_tur
                    AND s.status_sekcia = 1
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1;

  END IF;
  
  DROP TEMPORARY TABLE  IF EXISTS `tmptable`;

  CREATE TEMPORARY TABLE tmptable
    SELECT t.TOA
          , w.ID_Party as id_sila
          , 0 kvotatotmem
          , 0 totmem
          , 0 kvotaheadmem
          , 0 headmem
      FROM tblizbr t cross join wnsila w;

  UPDATE tmptable T1
    INNER JOIN (select k.TOA
                  , w.ID_Party id_sila
                  , sum(ifnull(k.sik_clenove,0)) kvotatotmem
                  , sum(if(k.Code_rolia<404,k.sik_clenove,0)) kvotaheadmem
               from n_top_partkvoti k 
                      inner join wnsila w on k.code_wnsila = w.NKOD
               GROUP BY k.TOA, w.ID_Party) x
        ON t1.toa = x.toa and t1.id_sila = x.id_sila
    SET T1.kvotatotmem = x.kvotatotmem, 
        t1.kvotaheadmem = x.kvotaheadmem;

  UPDATE tmptable T1
    INNER JOIN (select t.TOA
                  , i.id_sila
                  , count(i.id) totmem
                  , sum(if(i.Code_rolia<404,1,0)) headmem
               from tblvalues t 
                      inner join n_lica_izbori i on i.id_sik = t.Id
               GROUP BY t.TOA, i.id_sila) x
        ON t1.toa = x.toa and t1.id_sila = x.id_sila
    SET T1.totmem = x.totmem, 
        t1.headmem = x.headmem;
    
  SET @row_number = 0;

  IF prmType = 1 THEN
      SELECT  (@row_number:=@row_number + 1) AS Id
              ,x.name as nmizbrajon
              , x.toaname as nmrajon
              , x.wnsilaname as wnsila
              , ifnull(z.kvotatotmem,0) as col1
              , ifnull(z.totmem,0) as col2
              , ifnull(z.totmem,0)-ifnull(z.kvotatotmem,0) as col3
              , ifnull(z.kvotaheadmem,0) as col4
              , ifnull(z.headmem,0) as col5
              ,ifnull(z.headmem,0)-ifnull(z.kvotaheadmem,0) as col6
         FROM(SELECT t.izb_rajon, t.toa, w.ID_Party, t.name, t.toaname, w.nime as wnsilaname, w.nkod as wnsilakod
                FROM tblizbr t cross join  wnsila w
                WHERE w.Status_Partii = 1 ) x
              left join tmptable z on z.toa = x.toa and z.id_sila = x.id_party            
         ORDER BY x.izb_rajon,x.toa,x.wnsilakod;
  ELSE
      SELECT  (@row_number:=@row_number + 1) AS Id
              ,x.name as nmizbrajon
              , '' as nmrajon
              , x.wnsilaname as wnsila
              , SUM(ifnull(z.kvotatotmem,0)) as col1
              , SUM(ifnull(z.totmem,0)) as col2
              , SUM(ifnull(z.totmem,0)-ifnull(z.kvotatotmem,0)) as col3
              , SUM(ifnull(z.kvotaheadmem,0)) as col4
              , SUM(ifnull(z.headmem,0)) as col5
              , SUM(ifnull(z.headmem,0)-ifnull(z.kvotaheadmem,0)) as col6
         FROM(SELECT t.izb_rajon, t.toa, w.ID_Party, t.name, w.nime as wnsilaname, w.nkod as wnsilakod
                FROM tblizbr t cross join  wnsila w
                WHERE w.Status_Partii = 1) x                
              left join tmptable z on z.toa = x.toa and z.id_sila = x.id_party
         GROUP BY x.izb_rajon,x.wnsilakod 
         ORDER BY x.izb_rajon,x.wnsilakod;  
  END IF;
  DROP TEMPORARY TABLE tblvalues; 
  DROP TEMPORARY TABLE tblizbr;
END;
//

DELIMITER ;	