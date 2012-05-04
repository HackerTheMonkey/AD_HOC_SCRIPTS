select  *from charging_event_def;
select  *from processed_event  t where t.source_event_id = 102;
select *from  process_flow t where t.process_step_id = 102;
select  *from mapping_rule t where t.rule_id = 150;
select  *from mapping_list t where t.mapping_id = 180;
select *from  mapping_rule t where t.rule_id = 149;
select  *from mapping_list t where t.mapping_id = 181;
select  *from mapping_rule t where t.rule_id  = 151;

select * from tariff_item;
select  *from tariff_plan  t where t.tariff_plan_id = 88;
select  *from tariff_plan_item  t where t.tariff_plan_id = 88;
select * from tariff_schema t where t.tariff_schema_id = 64;
select * from tariff_item t where t.tariff_schema_id = 64;
select * from tariff_rate b where b.ratecode in
(
select a.tariff_id from tariff_item a where a.tariff_schema_id in (select tariff_schema_id from tariff_plan_item t where t.tariff_plan_id = 88  ) and a.subtariff_type = 1);
--national
select *from tariff_schema t where t.tariff_schema_id = 82;
select *from tariff_item t where t.tariff_schema_id = 82;

--international
select  *from tariff_schema t where t.tariff_schema_id = 26;
select *from tariff_item t where t.tariff_schema_id = 26;
select t.tariff_criteria,upper(substr(a.ratename,25,4))||upper(substr(a.ratename,30)) from tariff_item t, tariff_rate a 
where t.tariff_schema_id = 26
  and t.tariff_id = a.ratecode;
	
	select * from tariff_rate a  where a.ratecode in  (select t.tariff_id from tariff_item t where t.tariff_schema_id = 26) for update;



select * from tariff_rate t where t.ratecode = 102;

select * from set_def t where  t.set_id between  33 and 49;


select t.value,
decode(t.set_id,'33','NZONE1','34','NZONE2','35','NZONE3','36','NZONE4','37','NZONE5','38','NZONE6',
'39','NZONE7','40','NZONE8','41','NZONE9','42','NZONE10','43','NZONE11','44','NZONE12','45','NZONE13',
'46','NZONE14','47','NZONE15','48','NZONE16','49','NZONE17')   
 from set_value t where  t.set_id between  33 and 49;