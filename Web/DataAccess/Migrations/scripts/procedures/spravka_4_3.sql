DROP PROCEDURE IF EXISTS spravka_4_3;

DELIMITER //

CREATE PROCEDURE spravka_4_3(
  prmTOA     varchar(2)  
  ,prmSila    int
  ,prmUSER    varchar(128)
)
BEGIN   
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_4_3',prmTOA,'');

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

    
  DROP TEMPORARY TABLE if exists tblvalues; 
  
  CREATE TEMPORARY TABLE if not exists tblvalues (id int, toa varchar(2), sik varchar(3));

  INSERT INTO tblvalues 
      SELECT id_sek, toa, sik 
        FROM siks s
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
        WHERE s.Izb_Alias = @v_izbalias
          AND s.TUR = @v_tur
          AND s.TOA = prmToa
          AND s.status_sekcia = 1;               
                
  DROP TEMPORARY TABLE  IF EXISTS `tmptable`;

  CREATE TEMPORARY TABLE tmptable
  SELECT i.id_sik,i.id_sila, t.sik
        , count(i.id) totmem
        , sum(if(i.Code_rolia=401,1,0)) rol401
        , sum(if(i.Code_rolia=402,1,0)) rol402
        , sum(if(i.Code_rolia=403,1,0)) rol403
        , sum(if(i.Code_rolia=404,1,0)) rol404
     from tblvalues t 
            inner join n_lica_izbori i on i.id_sik = t.Id
     WHERE i.Code_rolia < 410       
     GROUP BY i.id_sik, i.id_sila;

 SELECT w1.nime 
    INTO @nmizbrajon
    FROM wnizbraion w1 inner join wntoa_izbraion w2 on w1.nkod = w2.Izb_r and w2.nkod = prmTOA
    WHERE w1.status = 1;
    
  SELECT w2.nime 
    INTO @nmrajon
    FROM wntoa w2 
    WHERE w2.NKOD = prmTOA;
    
  SET @row_number = 0;

  IF prmSila = 0 THEN
      SELECT  (@row_number:=@row_number + 1) AS Id
              ,@nmizbrajon as nmizbrajon
              , @nmrajon as nmrajon
              , w.nime as wnsila
              , ifnull(z.SIK,'')   as siknumb
              , ifnull(z.totmem,0) as col1
              , ifnull(z.rol401,0) as col2
              , ifnull(z.rol402,0) as col3
              , ifnull(z.rol403,0) as col4
              , ifnull(z.rol404,0) as col5
         FROM wnsila w left join tmptable z on w.id_PArty = z.id_sila
         WHERE w.Status_Partii = 1 
         ORDER BY w.id_PArty,z.sik;
  ELSE
      SELECT  (@row_number:=@row_number + 1) AS Id
              ,@nmizbrajon as nmizbrajon
              , @nmrajon as nmrajon
              , w.nime as wnsila
              , ifnull(z.SIK,'')   as siknumb
              , ifnull(z.totmem,0) as col1
              , ifnull(z.rol401,0) as col2
              , ifnull(z.rol402,0) as col3
              , ifnull(z.rol403,0) as col4
              , ifnull(z.rol404,0) as col5
         FROM wnsila w cross join tmptable z
         WHERE w.id_Party = prmSila
         ORDER BY z.sik;
         
  END IF;
  
  DROP TEMPORARY TABLE tblvalues; 
  DROP TEMPORARY TABLE tmptable;
END;
//

DELIMITER ;	