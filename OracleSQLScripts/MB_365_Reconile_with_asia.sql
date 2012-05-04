Select * From mapping_list a Where a.mapping_id=180 For Update;
Select mapping_sour From mapping_list a Where a.mapping_id=222;

-- codes that exist in MB365 but not exist country config (180)
Select Count(*) From
(
    Select to_char(code_seg) From prm.Tmp_Mb365_All_Access_Codes
    Minus
    Select mapping_sour From mapping_list a Where a.mapping_id=180
);

--codes that exist in country config (181) but not exist in country zones config(222)
Select Count(*) From
(
    Select mapping_dest From mapping_list a Where a.mapping_id=180
    Minus
    Select mapping_sour From mapping_list a Where a.mapping_id=222
);

-- codes that is configured in (180) but it is not exist in MB365 data
Select Count(*) From
(
    Select mapping_sour From mapping_list a Where a.mapping_id=180
    Minus
    Select to_char(code_seg) From prm.Tmp_Mb365_All_Access_Codes  
);

-- codes that exist in mapping 222 but does not exist in 180
Select Count(*) From
(
    Select mapping_sour From mapping_list a Where a.mapping_id=222
    Minus
    Select mapping_dest From mapping_list a Where a.mapping_id=180
);


-- get the codes that exist in 180 and not exist in 222 but it is supported by MB365

Select mapping_dest,a.mapping_sour From Mapping_List a Where a.mapping_id=180 And a.mapping_sour In (
Select to_char(code_seg) From prm.Tmp_Mb365_All_Access_Codes Where to_char(code_seg)
In (Select mapping_sour From mapping_list a Where a.mapping_id=180 And a.mapping_dest 
In ('ALA','ASI','AZO','CAI','DIG','FWI','GLB','HAW','INM','IRD','IVC','MRI','SLA','SVG','THU','UIF','VIR')));










