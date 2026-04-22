DROP PROCEDURE IF EXISTS spravka_9_3;

DELIMITER //

CREATE PROCEDURE spravka_9_3( 
  prmToa      varchar(2)
  ,prmCode    int
  ,prmUSER    varchar(128)
)
BEGIN   
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_9_3',prmToa,'');

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
                  
  select ifnull(count(i.Code_rolia),0) members 
    into @total
    from tblvalues t inner join n_lica_izbori i on t.id = i.id_sik    
    WHERE i.Code_rolia = if(prmCode=0,i.Code_rolia,prmCode) 
      AND i.Code_rolia <= 410;                                                          -- vkluchen i kod 410
    
  SET @row_number = 0;
  SELECT (@row_number:=@row_number + 1) AS Id  
        , IFNULL(w.Short_name,w.nkod) as col1
        , w.nime as col2
        , ifnull(count(n.Code_rolia),0) as col3
        , ifnull(round((count(n.Code_rolia)/@total)*100,2),0)  as col4
    from wnsila w 
          left join (select i.id_sila, i.Code_rolia 
                       from tblvalues t 
                              inner join n_lica_izbori i 
                              on t.id = i.id_sik
                                and i.Code_rolia = if(prmCode=0,i.Code_rolia,prmCode) 
                                AND i.Code_rolia <= 410) n                               -- vkluchen i kod 410
          on n.id_sila = w.ID_Party  
    where w.izb_alias = @v_izbalias 
      and w.Status_Partii=1           
    group by w.ID_Party;  
END;
//

DELIMITER ;	