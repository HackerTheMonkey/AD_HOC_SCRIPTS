--Inter Voice Sum
select substr(t.bill_date,1,6), t.trunkin_mgr,t.trunkout_mgr,sum(t.total_item),sum(t.timelong) 
  from prm.accumulate_record_day t
 where t.net_name = 'WL001'
   and t.toll_tra = 'VOICE'
	 and t.bill_date not like '200808%'
group by substr(t.bill_date,1,6), t.trunkin_mgr,trunkout_mgr
minus 
select to_char(a.billingcycle),a.intrunk_partner,a.outtrunk_partner,sum(a.total_amount),sum(a.duration)
 from prm_sum_intervoice a
where a.billingcycle <> '200808'
group by a.billingcycle,a.intrunk_partner,a.outtrunk_partner;


--Inter SMS
--because of number_prix problem
select substr(t.bill_date,1,6), t.caller_mgr,t.called_mgr,sum(t.total_item)
  from prm.accumulate_record_day t
 where t.net_name = 'WL001'
   and t.toll_tra = 'SMS'
	 and t.bill_date not like '200808%'
group by substr(t.bill_date,1,6), t.caller_mgr,t.called_mgr
minus 
select to_char(a.billingcycle),a.calling_partner,a.called_partner,sum(a.total_amount)
 from prm_sum_intersms a
where a.billingcycle <> '200808'
group by a.billingcycle,a.calling_partner,a.called_partner;

--IDD Voice

select substr(t.bill_date,1,6), t.trunkin_mgr,t.trunkout_mgr,sum(t.total_item),sum(t.timelong) 
  from prm.accumulate_record_day t
 where t.net_name = 'WL002'
   and t.toll_tra = 'VOICE'
	 and t.bill_date not like '200808%'
group by substr(t.bill_date,1,6), t.trunkin_mgr,trunkout_mgr
minus 
select to_char(a.billingcycle),a.intrunk_partner,a.outtrunk_partner,sum(a.total_amount),sum(a.duration)
 from prm_sum_iddvoice a
where a.billingcycle <> '200808'
group by a.billingcycle,a.intrunk_partner,a.outtrunk_partner;


--IDD SMS
select substr(t.bill_date,1,6),decode(t.called_svr,'',t.connect_type,''),decode(t.caller_svr,'',t.connect_type,''),sum(t.total_item)
  from prm.accumulate_record_day t
	 where t.net_name = 'WL002'
   and t.toll_tra = 'SMS'
	 and t.bill_date not like '200808%'
	group by substr(t.bill_date,1,6),t.caller_svr,t.called_svr,t.connect_type
minus 
select to_char(a.billingcycle),a.calling_hregion,a.called_vregion,sum(a.total_amount)
 from prm_sum_iddsms a
where a.billingcycle <> '200808'
group by a.billingcycle,a.calling_hregion,a.called_vregion,a.cdr_type;

--SPCP
select substr(t.bill_date,1,6),t.sp_code,t.serv_code,sum(t.service_fee)
 from prm.VI_ACCUMULATE_SPCP_RECORD t
where substr(t.bill_date,1,6) <> '200808'
group by substr(t.bill_date,1,6),t.sp_code,t.serv_code
minus
select to_char(a.billingcycle),a.sp_code,a.service_code,sum(a.settle_fee)
 from  prm_sum_spcp a
where a.billingcycle <> '200808'
group by a.billingcycle,a.sp_code,a.service_code;

