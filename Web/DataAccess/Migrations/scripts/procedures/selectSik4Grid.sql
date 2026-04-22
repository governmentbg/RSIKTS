DROP PROCEDURE IF EXISTS selectSik4Grid;

DELIMITER //

CREATE PROCEDURE selectSik4Grid(
  prmTOA     varchar(2)
)
BEGIN
  SET NAMES 'utf8';

  SELECT MAX(IF(id=1,VALUE,''))
        ,MAX(IF(id=2,cast(value as unsigned integer),0))
    INTO @v_izbalias, @v_tur
    FROM sys_main
    WHERE ID in (1,2);

  CREATE TEMPORARY TABLE if not exists tblvalues (id int);

  INSERT INTO tblvalues 
      SELECT id_sek 
        FROM siks
        WHERE Izb_Alias = @v_izbalias
          AND TUR = @v_tur
          AND TOA = prmToa;
 --         AND Status_Sekcia=1
 --         AND convert(sik, UNSIGNED INTEGER) > 0;               
  
  SELECT 
      t.id as idsek
      ,s.sik
      ,fnGetSikAddress(t.id) as AdrIme
      ,s.Status_Sekcia as StatusSekcia
      ,n.NIME as Vid
      ,IFNULL(s.adr_ime,'') as descript     
   FROM tblvalues t       
        INNER JOIN siks s ON s.id_sek = t.id
        inner join siks_vidove sv ON s.Id_sek = sv.Id_Sik and sv.Vid_codetable=1
        inner join n_list_codepositions n ON n.PKODE = sv.Vid_codetable and n.NKODE = sv.Idcodeposition
   ORDER BY 2;

  DROP TEMPORARY TABLE tblvalues;
END;
//

DELIMITER ;