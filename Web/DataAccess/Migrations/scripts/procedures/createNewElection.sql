DROP PROCEDURE IF EXISTS createNewElection;

DELIMITER //

CREATE PROCEDURE createNewElection(
   prmUSER          varchar(128) 
   ,prmTIPIZB       varchar(2)
   ,prmName         varchar(50)
   ,prmDATE1TUR     datetime
   ,prmDATE2TUR     datetime
)
BEGIN
   SET NAMES 'utf8';
   
   DELETE FROM n_top_main;
   
   SET @v_izbalias = CONCAT(prmTIPIZB,CAST(YEAR(prmDATE1TUR) as char(4)));
   
   IF NOT EXISTS (SELECT 1 FROM wntipizbori WHERE NKOD = prmTIPIZB AND TUR=2) THEN
       INSERT INTO n_top_main 
            (IZB_ALIAS,Description,DATE1TUR,DATE2TUR,Status_parameters)
          VALUES(@v_izbalias,prmName,prmDATE1TUR,null,1 );   
   ELSE
     INSERT INTO n_top_main 
          (IZB_ALIAS,Description,DATE1TUR,DATE2TUR,Status_parameters)
        VALUES(@v_izbalias,prmName,prmDATE1TUR,prmDATE2TUR,1 );   
   END IF; 
   
         
   CALL createNewTurOrElection ( prmUSER,@v_izbalias,0);
   
   UPDATE n_top_parameters 
      SET znachenie =  DATE_FORMAT(prmDATE1TUR, '%d/%m/%Y')
      WHERE KOD in ('52','53')
        AND IZB_ALIAS =@v_izbalias;

   UPDATE n_top_parameters 
      SET znachenie =  IFNULL(DATE_FORMAT(prmDATE2TUR, '%d/%m/%Y'),'')
      WHERE KOD in ('54','55')
        AND IZB_ALIAS =@v_izbalias;
   
END;
//

DELIMITER ;	