SET NAMES 'utf8';

delete from n_log; 

delete from n_lica_dopylnenie; 

delete from n_lica_izbori; 

delete from n_lica; 


/*
delete from n_lica_import; 

insert into n_lica_import (egn  ,im1  ,im2  ,im3  ,SIK  ,Rolja  ,Obra  ,Spec  ,Tel  ,status  ,opisanie  ,user)
SELECT LPAD(row, 10, 0), Concat('Име 1 ',row), Concat('Име 2 ',row), Concat('Име 3 ',row), '01','Член','Висше','Инженер','0888555555',0,'','78752568-4ac7-4809-8eab-491a00c3bb9c'
  FROM 
(SELECT @row := @row + 1 AS row FROM 
  (select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t,
--  (select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t2, 
--  (select 0 union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t3, 
  (SELECT @row:=0) numbers)x;

select * from n_lica_import;
*/
update n_lica_import set status=0;

CALL importLica('78752568-4ac7-4809-8eab-491a00c3bb9c', 'MI2019', 1, '01', 1, 'TbSoft2019');

--CALL selectLica('', 'TbSoft2019');