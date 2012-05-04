/*manager_info*/
select m.manager_code,m.manager_name,m.settle_type,m.manager_id
  from prm.manager_info m
minus 
select n.manager_code,n.manager_name,n.settle_type,n.manager_id
 from manager_info n;
/*Interconnect*/
--trunk info
select substr(t.mapping_sour,7,10)||substr(t.mapping_sour,19)||substr(t.mapping_sour,17,2),replace(t.mapping_dest,'SV203','SV101')
 from prm.mapping_list t 
where t.mapping_id = 194
  and t.mapping_dest like '%SV203' 
minus
select m.mapping_sour,m.mapping_dest
  from mapping_list m
where m.mapping_id = 7
  and m.mapping_dest like '%SV101';
	
--Number prefix
select * from mapping_list t where t.mapping_id = 2; -- need to double check the number prefix config with NSS

--tariff
--Voice In Coming
select c.note,b.manager_id,a.rate
 from prm.settle_relation a ,manager_info b,code_dict c
where  a.settle_mgr = b.manager_code and a.net_name = 'WL001'
  and a.settle_item = c.code
	and a.settle_item = 'AC902'
union
select  a.ratename,substr(t.tariff_criteria,7),a.currency
 from tariff_item t,charge_rate a
  where t.tariff_schema_id = 8
	  and t.tariff_id = a.ratecode;
;
--Voice outgoing
select c.note,b.manager_id,a.rate
 from prm.settle_relation a ,manager_info b,code_dict c
where  a.settle_mgr = b.manager_code and a.net_name = 'WL001'
  and a.settle_item = c.code
	and a.settle_item = 'AC901'
union
select  a.ratename,substr(t.tariff_criteria,8),a.currency
 from tariff_item t,charge_rate a
  where t.tariff_schema_id = 9
	  and t.tariff_id = a.ratecode;
--SMS MO
select c.note,b.manager_id,a.rate
 from prm.settle_relation a ,manager_info b,code_dict c
where  a.settle_mgr = b.manager_code and a.net_name = 'WL001'
  and a.settle_item = c.code
	and a.settle_item = 'AC903'
union
select  a.ratename,substr(t.tariff_criteria,7,instr(t.tariff_criteria,',')),a.currency
 from tariff_item t,charge_rate a
  where t.tariff_schema_id = 10
	  and t.tariff_id = a.ratecode;
--SMS MT
select c.note,b.manager_id,a.rate
 from prm.settle_relation a ,manager_info b,code_dict c
where  a.settle_mgr = b.manager_code and a.net_name = 'WL001'
  and a.settle_item = c.code
	and a.settle_item = 'AC904'
union
select  a.ratename,substr(t.tariff_criteria,13,instr(t.tariff_criteria,',')),a.currency
 from tariff_item t,charge_rate a
  where t.tariff_schema_id = 11
	  and t.tariff_id = a.ratecode;
--transit
--from interface;


/*IDD*/
--Trunk info
select substr(t.mapping_sour,7,10)||substr(t.mapping_sour,19)||substr(t.mapping_sour,17,2),replace(t.mapping_dest,'SV301','SV102')
 from prm.mapping_list t 
where t.mapping_id = 194
  and t.mapping_dest like '%SV301'
minus
select m.mapping_sour,m.mapping_dest
 from mapping_list m
where m.mapping_id = 7
  and m.mapping_dest like '%SV102';

--Section code
select * from 
  prm.tbl_c_section
minus 
select * from 
  tbl_c_section;

--IDD Section code 
select m.mapping_sour,m.mapping_dest 
from  prm.mapping_list m
where m.mapping_id = 181
minus 
select n.mapping_sour,n.mapping_dest
 from mapping_list n 
where  n.mapping_id = 16;
;


--IDD country code
select m.mapping_sour,m.mapping_dest
 from prm.mapping_list m 
 where m.mapping_id = 180
  minus 
select t.mapping_sour,substr(t.mapping_dest,1,3)
 from mapping_list t where t.mapping_id = 10;
 Select * From Mapping_List t Where t.mapping_id=10;
 
--IDD Zone code
 select m.mapping_sour,substr(m.mapping_dest,1,5)
 from prm.mapping_list m 
 where m.mapping_id = 222
 minus
select substr(t.mapping_dest,1,3),substr(t.mapping_dest,5)
 from mapping_list t where t.mapping_id = 10;
 
select * from prm.mapping_list t where t.mapping_id = 180 and t.mapping_dest in ('GLB','INM','IRD','IVC','THU');
--Tariff
--IDD voice incoming
select c.note,b.manager_id,a.rate
 from prm.settle_relation a ,manager_info b,code_dict c
where  a.settle_mgr = b.manager_code and a.net_name = 'WL002'
  and a.settle_item = c.code
	and a.settle_item = 'ID911'
union
select  a.ratename,substr(t.tariff_criteria,7),a.currency
 from tariff_item t,charge_rate a
  where t.tariff_schema_id = 17
	  and t.tariff_id = a.ratecode;
		
--IDD voice outgoing
select  substr(m.mapping_sour,instr (m.mapping_sour,',',1,2)+1),to_number(m.mapping_dest) 
 from prm.mapping_list m where m.mapping_id = 197
  and to_char(applytime,'yyyymm') <= '200808' and to_char(expiretime,'yyyymm') >= '200808'
 minus
 select a.tariff_criteria,b.currency from tariff_item a,charge_rate b
 where a.tariff_id = b.ratecode
   and a.tariff_schema_id = 18;
 
 
/*Roaming*/
--Imsi-> Hregion
select m.mapping_sour,m.mapping_dest 
  from prm.mapping_list m 
where m.mapping_id = 14
minus
select n.mapping_sour,n.mapping_dest 
  from mapping_list n
where n.mapping_id = 52; 

--Imsi->Operatior
select m.mapping_sour,m.mapping_dest 
  from prm.mapping_list m 
where m.mapping_id = 21
minus
select n.mapping_sour,n.mapping_dest 
  from mapping_list n
where n.mapping_id = 51; 

--National Roaming IDD Zone info
select t.value,
decode(t.set_id,'33','NZONE1','34','NZONE2','35','NZONE3','36','NZONE4','37','NZONE5','38','NZONE6',
'39','NZONE7','40','NZONE8','41','NZONE9','42','NZONE10','43','NZONE11','44','NZONE12','45','NZONE13',
'46','NZONE14','47','NZONE15','48','NZONE16','49','NZONE17')   
 from prm.set_value t where  t.set_id between  33 and 49
 minus
 select substr(a.mapping_sour,7),a.mapping_dest 
  from mapping_list a
where a.mapping_id = 58;
select * from mapping_list a  where a.mapping_id = 58;
--International Roaming Zone info 
select t.tariff_criteria,'I'||upper(substr(a.ratename,25,4))||upper(substr(a.ratename,30)) 
  from prm.tariff_item t, prm.tariff_rate a 
where t.tariff_schema_id = 26
  and t.tariff_id = a.ratecode
minus 
select m.mapping_sour,m.mapping_dest 
  from mapping_list m
where m.mapping_id = 59;


--Tariff
--IDD  National Roaming IDD Zone info IRQKK
select m.ratename,m.currency 
from prm.tariff_rate m
where m.ratecode in
	 ( select t.tariff_id from prm.tariff_item t where t.tariff_schema_id = 82)
union 
select n.ratename,n.currency
from charge_rate n
where n.ratecode in
(select a.tariff_id from tariff_item a where a.tariff_schema_id = 107) ;


--IDD  International Roaming IDD Zone  Skype phone
select m.ratename,m.currency 
from prm.tariff_rate m
where m.ratecode in
	 ( select t.tariff_id from prm.tariff_item t where t.tariff_schema_id =26)
union 
select n.ratename,n.currency
from charge_rate n
where n.ratecode in
(select a.tariff_id from tariff_item a where a.tariff_schema_id = 106) ;

--other tariff
select 'OLD '||ratename,currency from prm.tariff_rate b where b.ratecode in
(
select a.tariff_id from prm.tariff_item a where a.tariff_schema_id in (select tariff_schema_id from prm.tariff_plan_item t where t.tariff_plan_id = 88  ) and a.subtariff_type = 1)
union
select 'NEW '||c.ratename,c.currency
from 
charge_rate c where c.oper_sort = 'WL004'
and c.ratename not like '%Zone%';