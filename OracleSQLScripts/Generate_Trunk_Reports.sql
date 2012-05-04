Select * From Mapping_Def t Where t.mapping_id='194';
Select Distinct substr(t.mapping_dest,instr(t.Mapping_dest,',')+1) Partner_Type From mapping_list t Where t.mapping_id='194';-- Trunk Type (0 --> Trunk IN , 1 --> TrunkOut);
Select * From mapping_list t Where t.mapping_id='194';-- Trunk Type (0 --> Trunk IN , 1 --> TrunkOut);
-- Services: SV301 --> IDD Partner   ,   SV203 --> Interconnect Partner
Select substr(mapping_sour,18) From Mapping_List t;

Select to_char(substr(t.mapping_sour,(instr(t.mapping_sour,',',1,2) + 1),1)) From prm.Mapping_List t Where t.mapping_id='194'; -- to get the trunk type
Select (((instr(t.mapping_sour,',',1,2)) - (instr(t.Mapping_Sour,',',1,1))) - 1) From prm.Mapping_List t Where t.mapping_id='194'; -- to get the length of the switch field
Select substr(t.Mapping_Sour,instr(t.mapping_sour,',')+1,(((instr(t.mapping_sour,',',1,2)) - (instr(t.Mapping_Sour,',',1,1))) - 1)) switch_code From prm.Mapping_List t Where t.mapping_id='194'; -- to get the switch code
Select substr(t.mapping_dest,1,INSTR(t.mapping_dest,',') -1) Trunk_Manager From prm.Mapping_List t Where t.mapping_id='194'; -- to get the trunk manager name
Select substr(t.mapping_sour,instr(t.mapping_sour,',',1,3)+1) Trunk_No From prm.Mapping_List t Where t.mapping_id='194'; -- to get the trunk manager 


Select instr('JM001,7701144102,0,150',',',1,2) from dual;

-- TrunkIN Report SQL
Create Or Replace View BS_Trunk_Info As
Select 
           u.memo Switch_name,
           substr(t.Mapping_Sour,instr(t.mapping_sour,',')+1,(((instr(t.mapping_sour,',',1,2)) - (instr(t.Mapping_Sour,',',1,1))) - 1)) switch_code,
           decode(to_char(substr(t.mapping_sour,(instr(t.mapping_sour,',',1,2) + 1),1)),0,'Trunk IN',1,'Trunk Out') trunk_type,
                      substr(t.mapping_sour,instr(t.mapping_sour,',',1,3)+1) Trunk_No,
           substr(t.mapping_dest,1,INSTR(t.mapping_dest,',') -1) Trunk_Manager,
           decode(substr(t.mapping_dest,instr(t.Mapping_dest,',')+1),'SV301','IDD Partner','SV203','Interconnect Partner') Partner_Type
From mapping_list t,bill_comprehensive_info u
Where
       t.mapping_id='194' And
       substr(t.Mapping_Sour,instr(t.mapping_sour,',')+1,(((instr(t.mapping_sour,',',1,2)) - (instr(t.Mapping_Sour,',',1,1))) - 1))=u.post_billflag;
       --to_char(substr(t.mapping_sour,(instr(t.mapping_sour,',',1,2) + 1),1))='0';
       
Select * From  BS_Trunk_Info t Where (t.Partner_Type='Interconnect Partner' Or t.Trunk_Manager='ITPC') And t.trunk_type='Trunk IN';
select t.post_billflag,t.memo from bill_comprehensive_info t;
Create Table tmp_bs_swicth_info As select t.post_billflag,t.memo from bill_comprehensive_info t;
Select * From prm.tmp_bs_swicth_info t;

Select Distinct v.Trunk_Manager From prm.bs_trunk_info v;

Create Or Replace View BS_Trunk_Info As
Select 
           u.memo Switch_name,
           substr(t.Mapping_Sour,instr(t.mapping_sour,',')+1,(((instr(t.mapping_sour,',',1,2)) - (instr(t.Mapping_Sour,',',1,1))) - 1)) switch_code,
           decode(to_char(substr(t.mapping_sour,(instr(t.mapping_sour,',',1,2) + 1),1)),0,'Trunk IN',1,'Trunk Out') trunk_type,
                      substr(t.mapping_sour,instr(t.mapping_sour,',',1,3)+1) Trunk_No,
           decode (substr(t.mapping_dest,1,INSTR(t.mapping_dest,',') -1),
                      'DECOV','DISCOVERY TEL',
                      'EDJV','ARIA PHONE',
                      'GLOBE','GLOBECOMM',
                      'INCLA','INCLARITY',
                      'IRQAT','ZAIN ATHEER',
                      'IRQOR','ZAIN IRAQNA',
                      'IRQKK','KOREK',
                      'IRQTEL','IRAQTEL',
                      'ITPC','ITPC',
                      'KURDT','KURD TEL',
                      'MEWLL','MEDIA TEL',
                      'MOBIT','MOBITEL',
                      'Noro','NAWROZ TEL',
                      'Vital','MAWTINY'                      
                      ) Trunk_Manager,
           decode(substr(t.mapping_dest,instr(t.Mapping_dest,',')+1),'SV301','IDD Partner','SV203','Interconnect Partner') Partner_Type
From mapping_list t,bill_comprehensive_info u
Where
       t.mapping_id='194' And
       substr(t.Mapping_Sour,instr(t.mapping_sour,',')+1,(((instr(t.mapping_sour,',',1,2)) - (instr(t.Mapping_Sour,',',1,1))) - 1))=u.post_billflag;