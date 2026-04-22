DROP FUNCTION IF EXISTS fnGetIzborenRajon;

DELIMITER //

CREATE FUNCTION fnGetIzborenRajon (prmIzbAlias varchar(6),prmToa varchar(2)) RETURNS varchar(250)
BEGIN
   SELECT w2.nkod
      INTO @v_izbrajon
      FROM wntoa_izbraion w1 inner join wnizbraion w2 on w1.IZB_R = w2.NKOD AND w2.IZB_ALIAS = prmIzbAlias AND w2.status=1
      WHERE w1.NKOD = prmToa;
  
  RETURN  IFNULL(@v_izbrajon,'00');  	
END;
//

DELIMITER //
