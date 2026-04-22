DROP PROCEDURE IF EXISTS spravka_1_7;

DELIMITER //

CREATE PROCEDURE spravka_1_7(
  prmIZB_R        varchar(2)
  ,prmTOA         varchar(2)
)
BEGIN
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  CREATE TEMPORARY TABLE if not exists tblvalues (
    id            int
    ,fullsikcode  varchar(10)
    ,toa          varchar(2)
    ,Izb_rajon    varchar(2)
    );
  
  CREATE TEMPORARY TABLE IF NOT EXISTS tblizbr (
      nkod varchar(2),
      name varchar(45)
  );  
  
  SET @v_nameizbraion := '';
  SET @v_nametoa := '';
  
  IF convert(prmTOA, unsigned integer) > 0 THEN
      SELECT NIME
        INTO @v_nametoa
        FROM wntoa
        WHERE nkod = prmTOA;
      
      INSERT INTO tblvalues 
          SELECT distinct id_sek, aa_bb_cc , TOA, '00'
            FROM siks s0
            WHERE s0.Izb_Alias = @v_izbalias
              AND s0.TUR = @v_tur
              AND s0.TOA = prmToa           
              AND s0.status_sekcia=1 ;
  ELSE  
      IF prmIZB_R = '00' THEN
          INSERT INTO tblizbr
              SELECT nkod, nime
                FROM wnizbraion 
                WHERE IZB_ALIAS = @v_izbalias
                  AND STATUS=1;
      ELSE      
          SELECT NIME
            INTO @v_nameizbraion
            FROM wnizbraion
            WHERE nkod = prmIZB_R
              AND IZB_ALIAS = @v_izbalias;
             
          INSERT INTO tblizbr
              SELECT nkod, nime
                  FROM wnizbraion 
                  WHERE IZB_ALIAS = @v_izbalias
                    AND NKOD = prmIZB_R
                    AND STATUS=1;
      END IF;    
  
      INSERT INTO tblvalues           
           SELECT distinct s.id_sek, s.aa_bb_cc, '00', prmIZB_R
           FROM tblizbr t
                INNER JOIN wntoa_izbraion w1 ON t.nkod = w1.IZB_R
                INNER JOIN siks s ON s.TOA = w1.NKOD 
                    AND s.Izb_Alias = @v_izbalias 
                    AND s.TUR = @v_tur
           WHERE s.Status_Sekcia=1;      
  END IF;


    
  CREATE TEMPORARY TABLE if not exists tblvalues1 (
    Izb_rajon varchar(2)
    ,toa      varchar(2)
    ,nime     varchar(100)
    ,SIK0     int
    ,SIK1     int
    ,PSIK     int
    ,TOTAL    int
  );
  
  INSERT INTO tblvalues1 
      select s.Izb_rajon
            ,s.TOA
            ,n.NIME
            , SUM(IF(v.Idcodeposition = '101' and v.Vid_codetable=1,1,0)) SIK0
            , SUM(IF(v.Idcodeposition = '103' and v.Vid_codetable=1,1,0)) SIK1
            , SUM(IF(v.Idcodeposition = '102' and v.Vid_codetable=1,1,0)) PSIK
            , SUM(IF(v.Idcodeposition in ('101','102','103') and v.Vid_codetable=1,1,0)) TOTAL
      from n_lica_izbori li
              inner join tblvalues s
                  on s.id = li.Id_Sik
              inner join siks_vidove v
                  on s.id = v.Id_Sik
              inner join `n_list_codepositions` n
                 on li.Code_rolia = n.NKODE and n.PKODE = 4
      where li.Code_rolia < 410
      group by s.Izb_rajon, s.TOA,li.Code_rolia;

  CREATE TEMPORARY TABLE if not exists tblvalues2 (
    Izb_rajon varchar(2)
    ,toa      varchar(2)
    ,nime     varchar(100)
    ,SIK0     int
    ,SIK1     int
    ,PSIK     int
    ,TOTAL    int
  );

  INSERT INTO tblvalues2 
    select s.Izb_rajon
        , s.TOA
        , n.NIME
        , SUM(IF(v.Idcodeposition = '101' and v.Vid_codetable=1,1,0)) SIK0
        , SUM(IF(v.Idcodeposition = '103' and v.Vid_codetable=1,1,0)) SIK1
        , SUM(IF(v.Idcodeposition = '102' and v.Vid_codetable=1,1,0)) PSIK
        , SUM(IF(v.Idcodeposition in ('101','102','103') and v.Vid_codetable=1,1,0)) TOTAL
      from n_lica_izbori i
        inner join tblvalues s
          on s.id = i.Id_Sik
        inner join siks_vidove v
          on s.id = v.Id_Sik
        inner join n_lica_dopylnenie d
          on d.Id_Lice = i.ID
        inner join `n_list_codepositions` n
           on d.VidCodetable = n.PKODE and d.Idcodeposition = n.NKODE
      group by s.Izb_rajon, s.TOA,d.Idcodeposition;

  CREATE TEMPORARY TABLE if not exists tblvalues9 (
       rowno      decimal(6,2)
      ,Pokazatel  varchar(100)
      ,SIK0       decimal(10,4)
      ,SIK1       decimal(10,4)
      ,PSIK       decimal(10,4)
      ,Total      decimal(10,4)
  );

  INSERT INTO tblvalues9 (rowno,Pokazatel,SIK0,SIK1,PSIK,Total)
    select 1
          , 'Брой СИК (Само активни)'
          , SUM(IF(v.Idcodeposition = '101' and v.Vid_codetable=1,1,0)) SIK0
          , SUM(IF(v.Idcodeposition = '103' and v.Vid_codetable=1,1,0)) SIK1
          , SUM(IF(v.Idcodeposition = '102' and v.Vid_codetable=1,1,0)) PSIK
          , SUM(IF(v.Idcodeposition in ('101','102','103') and v.Vid_codetable=1,1,0)) TOTAL
        FROM tblvalues s
            inner join siks_vidove v 
            on s.id = v.Id_Sik
      GROUP BY  s.Izb_rajon, s.TOA; 
    
  INSERT INTO tblvalues9 (rowno,Pokazatel,SIK0,SIK1,PSIK,Total)
    select 2.0
          , 'Брой лица в СИК по длъжности'
          , SUM(SIK0)
          , SUM(SIK1)
          , SUM(PSIK)
          , SUM(TOTAL)          
      FROM tblvalues1
      GROUP BY  Izb_rajon, TOA; 
  
  SET @row_number = 0;   
  INSERT INTO tblvalues9  (rowno,Pokazatel,SIK0,SIK1,PSIK,Total)
    select  2.0 + (@row_number:=@row_number + 1)/10 AS rowno
          , NIME
          , SIK0
          , SIK1
          , PSIK
          , TOTAL          
      FROM tblvalues1; 


  INSERT INTO tblvalues9  (rowno,Pokazatel,SIK0,SIK1,PSIK,Total)
    select 3.0
          , 'Брой лица в СИК по дейности'
          , SUM(SIK0)
          , SUM(SIK1)
          , SUM(PSIK)
          , SUM(TOTAL)          
      FROM tblvalues2
      GROUP BY  Izb_rajon, TOA; 

  SET @row_number = 0;   
  INSERT INTO tblvalues9  (rowno,Pokazatel,SIK0,SIK1,PSIK,Total)
    select  3.0  + (@row_number:=@row_number + 1)/10 AS rowno
          , NIME
          , SIK0
          , SIK1
          , PSIK
          , TOTAL          
      FROM tblvalues2;

  SET @row_number = 0; 
  select DISTINCT
        @row_number:=@row_number + 1 as id
        ,@v_nameizbraion  as NmIzbRajon
        ,@v_nametoa as NmRajon
        ,l.Pokazatel, l.SIK0, l.SIK1, l.PSIK, l.TOTAL, l.rowno
  from tblvalues9 l 
  ORDER BY l.rowno;  
  
  DROP TEMPORARY TABLE tblvalues; 
  DROP TEMPORARY TABLE tblvalues1; 
  DROP TEMPORARY TABLE tblvalues2; 
  DROP TEMPORARY TABLE tblvalues9; 
  DROP TEMPORARY TABLE tblizbr;
  
END;
//

DELIMITER ;