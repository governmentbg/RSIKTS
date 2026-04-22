DROP PROCEDURE IF EXISTS spravka_3_2;

DELIMITER //

CREATE PROCEDURE spravka_3_2(
  prmTOA      varchar(2)
  ,prmTUR     int
  ,prmSIKS    varchar(250)
  ,prmUSER    varchar(128)
  ,prmDummy   varchar(30)
)
BEGIN
  DECLARE done TINYINT DEFAULT FALSE;
  DECLARE v_id INT DEFAULT 0;

  DECLARE crsFields 
     CURSOR FOR SELECT id FROM tblpart2 t1; 

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  SET NAMES 'utf8';
  SET @v_tur = prmTUR;

  SELECT MAX(IF(id=1,VALUE,''))
    INTO @v_izbalias
    FROM sys_main
    WHERE ID in (1,2);

  SELECT coef_stoinost
     INTO @v_maxosigsum 
     FROM n_top_dancoef
     WHERE Izb_Allias = @v_izbalias
       AND status_coef = 1 
       and nred = '20';

  call createLog (prmUSER, 3,'Справка','spravka_3_2',prmTOA,'');

  DROP TEMPORARY TABLE  IF EXISTS `tblvalues`;

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  IF convert(prmSIKS, UNSIGNED INTEGER)> 0 THEN
      DROP TEMPORARY TABLE if exists tblsiks;
      CREATE TEMPORARY TABLE if not exists tblsiks (sik varchar(3));

      SET @Values = prmSIKS;
      WHILE (LOCATE(',', @Values) > 0)
      DO
          SET @value = ELT(1, @Values);
          SET @Values= SUBSTRING(@Values, LOCATE(',',@Values) + 1);

          INSERT INTO tblsiks VALUES(@value);
      END WHILE;

      SET @value = ELT(1, @Values);
      INSERT INTO tblsiks VALUES(@value);
    
      INSERT INTO tblvalues
        SELECT ID_SEK
          FROM siks s inner join tblsiks t on s.sik = t.sik 
          WHERE s.Izb_Alias = @v_izbalias
            and s.TUR = prmTUR 
            and s.TOA = prmTOA;
           
      DROP TEMPORARY TABLE tblsiks;     
  ELSE
    INSERT INTO tblvalues 
        SELECT id_sek 
          FROM siks s
            inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
            inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition and n.CALC=1
          WHERE s.Izb_Alias = @v_izbalias
            AND s.TUR = @v_tur
            AND s.TOA = prmToa
            AND s.status_sekcia = 1;               
  END IF;

  -- syzdavam vremenna tablica
  CREATE TEMPORARY TABLE if not exists tblpart2 (
         id int
        ,S01 varchar(100) not null default '0'
        ,S02 varchar(100) not null default '0'
        ,S03 varchar(100) not null default '0'
        ,S04 varchar(100) not null default '0'
        ,S05 varchar(100) not null default '0'
        ,S06 varchar(100) not null default '0'
        ,S07 varchar(100) not null default '0'
        ,S08 varchar(100) not null default '0'
        ,S09 varchar(100) not null default '0'
        ,S10 varchar(100) not null default '0'
        ,S   varchar(100) not null default '0'
        ,T   decimal (10,2) not null default 0
  );        

  INSERT INTO tblpart2 (id,S01,S02,S03,S04,S05,S06,S07,S08,S09,S10,S,T)
      VALUES (0,'','','','','','','','','','','Общо осигуровки в евро',0);

  -- popylva se headera
  SET @sql = NULL;
  SELECT CONCAT ('UPDATE tblpart2 SET '
                 ,GROUP_CONCAT(DISTINCT CONCAT(' S',nred,'=','\'',tekst,'\''))
                 ,' WHERE ID = 0'
         )        
     INTO @sql
     FROM n_top_dancoef
     WHERE Izb_Allias = @v_izbalias
       AND status_coef = 1 
       and convert(nred, UNSIGNED INTEGER) < '20';

  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  -- popylvat se redovete
  INSERT INTO tblpart2 (id )
     SELECT l.id 
     FROM tblvalues t
        inner join siks s on s.Id_sek = t.id
        inner join n_lica_izbori l on l.Id_Sik = s.id_sek;

  OPEN crsFields;
  my_loop: 
  LOOP
    FETCH NEXT FROM crsFields INTO v_id;

    IF done THEN 
      LEAVE my_loop; 
    ELSE 
      SET @sql = NULL;
      SELECT CONCAT ('UPDATE tblpart2 SET '
                     ,GROUP_CONCAT(DISTINCT CONCAT(' S',n.Code_dancoef,'=','\'',convert(ifnull(round(n.pari,2),0),char),'\''))
                     ,' WHERE ID = '
                     ,convert(v_id,char)
             ), SUM(n.pari)        
         INTO @sql, @suma
         FROM n_lice_pari_zanap n 
         WHERE n.id_lice = v_id;

      IF length(IFNULL(@sql,''))>0 THEN
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        UPDATE tblpart2 
            SET s=convert(round(@suma,2), char),  t= @suma 
            WHERE id = v_id;
      END IF;
      
      SET done = false;      
    END IF;
  END LOOP;
  CLOSE crsFields;
  
  DROP TEMPORARY TABLE  IF EXISTS `tmptable`;

  CREATE TEMPORARY TABLE tmptable
     SELECT SUM(convert(S01, decimal(10,2)))  as S01
            ,SUM(convert(S02, decimal(10,2))) as S02
            ,SUM(convert(S03, decimal(10,2))) as S03
            ,SUM(convert(S04, decimal(10,2))) as S04
            ,SUM(convert(S05, decimal(10,2))) as S05
            ,SUM(convert(S06, decimal(10,2))) as S06
            ,SUM(convert(S07, decimal(10,2))) as S07
            ,SUM(convert(S08, decimal(10,2))) as S08
            ,SUM(convert(S09, decimal(10,2))) as S09
            ,SUM(convert(S10, decimal(10,2))) as S10
            ,SUM(convert(S, decimal(10,2)))   as S
     FROM tblpart2 t
     WHERE ID > 0;
  
  -- popylvat se redovete
  INSERT INTO tblpart2 (id, S01,S02,S03,S04,S05,S06,S07,S08,S09,S10,S)
    SELECT 999999,S01,S02,S03,S04,S05,S06,S07,S08,S09,S10,S FROM tmptable;
    
  DROP TEMPORARY TABLE  IF EXISTS `tmptable`;
  
  -- popylvat se part1 na rablicata
  DROP TEMPORARY TABLE  IF EXISTS `tblpart1`;

  CREATE TEMPORARY TABLE if not exists tblpart1 (
        id          int
        ,col1       varchar(100)
        ,col2       varchar(100)
        ,col3       varchar(400)
        ,col4       varchar(150)
        ,col5       varchar(100)
        ,col6       varchar(100)
        ,birthyear  int
        ,nmizbrajon varchar(45)
        ,nmrajon    varchar(45)
        ,orders     int
        ,Code_rolia int
        
  );

  SELECT w1.nime 
    INTO @nmizbrajon
    FROM wnizbraion w1 inner join wntoa_izbraion w2 on w1.nkod = w2.Izb_r and w2.nkod = prmTOA
    WHERE w1.status = 1;
    
  SELECT w2.nime 
    INTO @nmrajon
    FROM wntoa w2 
    WHERE w2.NKOD = prmTOA;
    
   SELECT round(sum(w4.pari),2)
      INTO @sumpari
     FROM tblvalues t
          inner join n_lica_izbori l on l.Id_Sik = t.id
          inner join (SELECT id_lice, sum(pari) pari 
                        from n_lice_pari_zaplashtane 
                        group by id_lice) w4 on w4.id_lice = l.id;
      
  INSERT INTO tblpart1 VALUES(0,'№','СИК','Име, Презиме, Фамилия','Длъжност','Начислена сума в евро','Осиг. доход в евро',0,@nmizbrajon,@nmrajon,0,0);
  
  INSERT INTO tblpart1 (ID, orders,col4,col5, col6) VALUES(999999,2,'Общо',@sumpari,@sumpari);
  
  INSERT INTO tblpart1 
    SELECT    
      l.id
      ,0
      ,sik as sikcode
      ,CONCAT(IFNULL(CAST(AES_DECRYPT(FROM_BASE64(lc.im1),prmDummy) as CHAR(50)),''),' ',
             IFNULL(CAST(AES_DECRYPT(FROM_BASE64(lc.im2),prmDummy) as CHAR(50)),''),' ',
             IFNULL(CAST(AES_DECRYPT(FROM_BASE64(lc.im3),prmDummy) as CHAR(50)),''))  ime
      ,p.nime   rolia
      ,round(w4.pari,2) as suma        
      ,ROUND(w4.pari,2) as maxosigsuma
      ,fnGetLiceBirthYear(CAST(AES_DECRYPT(FROM_BASE64(lc.egn),prmDummy) as CHAR(50))) as birthyear
      ,'' as nmizbrajon
      ,'' as nmrajon     
      ,1
      ,l.Code_rolia
     FROM tblvalues t
          inner join siks s on s.Id_sek = t.id
          inner join n_lica_izbori l on l.Id_Sik = s.id_sek
          inner join n_lica lc on lc.Id = l.id_lice
          inner join n_list_codepositions p on p.NKODE = l.Code_rolia and p.PKODE=4
          inner join (SELECT id_lice, sum(pari) pari from n_lice_pari_zaplashtane group by id_lice) w4 on w4.id_lice = l.id
      ORDER BY s.sik, l.Code_rolia;
      
  SET @row_number = 0;
  SELECT (@row_number:=@row_number + 1) AS Id  
          ,nmizbrajon
          ,nmrajon
          ,t1.orders,t1.birthyear,t2.t
          ,t1.col1,t1.col2, t1.col3, t1.col4, t1.col5, t1.col6
          ,t2.s01, t2.s02, t2.s03, t2.s04, t2.s05, t2.s06, t2.s07, t2.s08, t2.s09, t2.s10
          ,t2.s as s
     FROM tblpart1 t1 
            inner join tblpart2 t2  on t1.id = t2.id
     ORDER BY t1.orders, t1.col2, t1.Code_rolia, t1.id;
    
  DROP TEMPORARY TABLE tblvalues;
  DROP TEMPORARY TABLE tblpart1;
  DROP TEMPORARY TABLE tblpart2;
END;
//

DELIMITER ;