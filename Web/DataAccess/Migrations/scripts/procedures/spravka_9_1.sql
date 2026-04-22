DROP PROCEDURE IF EXISTS spravka_9_1;

DELIMITER //

CREATE PROCEDURE spravka_9_1( 
  prmToa    varchar(2)
  ,prmUSER    varchar(128)
)
BEGIN   
  SET NAMES 'utf8';

  call createLog (prmUSER, 3,'Справка','spravka_9_1',prmToa,'');

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  DROP TEMPORARY TABLE if exists tblsiks; 
   
  CREATE TEMPORARY TABLE IF NOT EXISTS tblsiks (
      id_sek int(10)
  );
  
  INSERT INTO tblsiks
    SELECT s.id_sek
      FROM siks s 
          inner join siks_vidove v 
          on s.id_sek = v.Id_Sik 
            AND v.Vid_codetable = 1 
            AND v.Idcodeposition > 100
      where s.Izb_Alias = @v_izbalias
        AND s.TUR = @v_tur
        AND s.toa = prmToa
        and s.Status_Sekcia = 1;
  
  select count(id_sek)
    into @v_cntsik
    from tblsiks s;
                    
  select sum(IF(i.code_rolia<=410,1,0))
         ,sum(IF(i.code_rolia=401,1,0))
         ,sum(IF(i.code_rolia=402,1,0))
         ,sum(IF(i.code_rolia=403,1,0))
         ,sum(IF(i.code_rolia=404,1,0))
         ,sum(IF(i.code_rolia=410,1,0))                   -- vkluchen samo kod 410
    into @v_cntlica, @v_cnt401, @v_cnt402, @v_cnt403, @v_cnt404, @v_others
    from n_lica_izbori i 
        inner join tblsiks t
          on i.id_sik = t.id_sek
        inner join siks s 
          on s.id_sek = t.id_sek;
  
  IF EXISTS (SELECT 1 FROM tblsiks s) THEN
      SET @row_number = 0;

      SELECT (@row_number := @row_number + 1) AS Id 
            ,'Секции' as n1
            ,IFNULL(@v_cntsik,0) as c1
            ,'Лица' as n2
            ,IFNULL(@v_cntlica,0) as c2
            ,MAX(IF(NKODE = 401,NIME,'')) as n3
            , IFNULL(@v_cnt401,0) as c3
            ,MAX(IF(NKODE = 402,NIME,'')) as n4
            , IFNULL(@v_cnt402,0) as c4
            ,MAX(IF(NKODE = 403,NIME,'')) as n5
            , IFNULL(@v_cnt403,0) as c5
            ,MAX(IF(NKODE = 404,NIME,'')) as n6
            , IFNULL(@v_cnt404,0) as c6
            ,MAX(IF(NKODE = 410,NIME,'')) as n7             -- vkluchen samo kod 410
            , IFNULL(@v_others,0) as c7
        FROM  tblsiks t
              inner join siks s on t.id_sek = s.id_sek
              inner join n_lica_izbori i on i.id_sik = s.id_sek
              inner join n_list_codepositions c on c.nkode = i.code_rolia and c.PKODE = 4;
  ELSE
      SELECT 1 AS Id 
            ,'Секции' as n1
            ,0 as c1
            ,'Лица' as n2
            ,0 as c2
            ,' ' as n3
            ,0.0 as c3
            ,' ' as n4
            ,0.0 as c4
            ,' ' as n5
            ,0.0 as c5
            ,' ' as n6
            ,0.0 as c6
            ,' ' as n7
            ,0.0 as c7;
  END IF;
  
END;
//

DELIMITER ;	