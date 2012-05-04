Select * From mapping_list a Where a.mapping_id='181' And a.mapping_sour Like 'GLOBE%';
Select Count(1) From mapping_list a Where a.mapping_id='181' And a.mapping_sour Like 'GLOBE%';
Select Count(Distinct a.mapping_sour) From mapping_list a Where a.mapping_id='181' And a.mapping_sour Like 'GLOBE%';

--for Globecom
Select a.mapping_sour,Count(a.mapping_sour) From mapping_list a 
Where a.mapping_id='181' And a.mapping_sour Like 'GLOBE%'
Group By a.mapping_sour Having Count(a.mapping_sour) > 1;

--for Inclarity
Select a.mapping_sour,Count(a.mapping_sour) From mapping_list a 
Where a.mapping_id='181' And a.mapping_sour Like 'INCLA%'
Group By a.mapping_sour Having Count(a.mapping_sour) > 1;

--for Discovery
Select a.mapping_sour,Count(a.mapping_sour) From mapping_list a 
Where a.mapping_id='181' And a.mapping_sour Like 'DECOV%'
Group By a.mapping_sour Having Count(a.mapping_sour) > 1;

Select * From bill_s_idd;
Select Count(*) From bill_s_idd a Where a.trunkout_manager 
In ('INCLA','DECOV','GLOBE') and to_char(a.start_time,'yyyymm')='200709' and a.toll_type='VOICE';

4639468