select a.caller||','||a.total_occupy_time||','||a.total_count_calls||','||a.trunkin||','||a.switch_code from temp1 a
   where 
     a.trunkin in (select b.trunk_no from bs_trunk_info b where b.trunk_type='Trunk IN' and b.trunk_manager='ZAIN IRAQNA') and
     a.switch_code in (select b.switch_code from bs_trunk_info b where b.trunk_type='Trunk IN' and b.trunk_manager='ZAIN IRAQNA') and
     a.total_count_calls > 10 and
     not exists (select 1 from temp2 c where c.called=a.caller) and
     exists (select 1 from bs_trunk_info d where d.trunk_no=a.trunkin and d.switch_code=a.switch_code);