--report generation
--Inter invoice
select m.billingcycle_code,n.manager_id,m.account_code,m.cdr_total_num-n.cdr_total_num cdrnumber_diff,m.timelong-n.timelong timelong_diff,m.settle_rate-n.settle_rate rate_diff
from prm.vi_rp_irq_account_fee m,
     vi_rp_inter_invoice n
where m.billingcycle_code = n.billingcycle_code
  and m.manager_code = n.manager_code
	and m.account_code = n.account_code;
	
--Inter Report
select m.billingcycle_code,n.manager_id,m.account_code,m.cdr_total_num-n.cdr_total_num cdrnumber_diff,m.timelong-n.timelong timelong_diff,m.settle_rate-n.settle_rate rate_diff
from prm.vi_rp_irq_account_fee m,
     vi_rp_inter_report n
where m.billingcycle_code = n.billingcycle_code
  and m.manager_code = n.manager_code
	and m.account_code = n.account_code;	
	
--Inter Detail Report
select m.billingcycle_code,n.manager_id,m.cdr_type,m.cdr_total_num-n.cdr_total_num cdrnumber_diff,m.call_mins-m.call_mins duration_diff,m.settle_rate-n.settle_rate rate_diff
  from prm.vi_rp_inter m,
	     vi_rp_inter n
where m.billingcycle_code = n.billingcycle_code
  and m.manage_code = n.manager_code
	and m.cdr_type = n.cdr_type;

--Media Invoice
select m.billingcycle_code,n.manager,m.num-n.num cdrnum_diff,m.timelong-n.timelong duration_diff,m.rate,n.rate
  from prm.vi_rp_medya_invoice m,
	     vi_rp_medya_invoice n
 where m.billingcycle_code = n.billingcycle_code
   and m.net_name = n.net_name
	 and m.manager=  n.manager
	 and m.manager <> 'IRQAC';

--Media Report
select m.billingcycle_code,n.manager,m.num-n.num cdrnum_diff,m.timelong-n.timelong duration_diff,m.rate,n.rate
  from prm.vi_rp_medya_report m,
	     vi_rp_medya_report n
 where m.billingcycle_code = n.billingcycle_code
   and m.net_name = n.net_name
	 and m.manager=  n.manager
	 and m.manager <> 'IRQAC';
	 
	 
--IDD Voice Invoice
select m.BillingCycle,n.manager_id,m.InNoOfCalls-n.cdr_total_num cdrnum_diff,nvl(m.InMinutes-round(n.timelong/60,2),0) duration_diff,m.InRate,n.settle_rate
  from prm.vi_rp_idd_voice m,
	     vi_rp_idd_invoice n
where m.BillingCycle = n.billingcycle_code
  and m.manager_code = n.manager_code;
	     

--IDD Voice Report	
select m.BillingCycle,n.manager_id,nvl(m.OutNoOfCalls-n.cdr_total_num,0) cdrnum_diff,nvl(m.OutMinutes-round(n.timelong/60,2),0) duration_diff,m.outRate,n.settle_rate
  from prm.vi_rp_idd_voice m,
	     vi_rp_idd_report n
where m.BillingCycle = n.billingcycle_code
  and m.manager_code = n.manager_code;


--IDD SMS Invoice
select m.billingcycle_code,m.settle_item,m.connect_type,m.cdr_number-n.cdr_number cdrnum_diff,m.charge_rate-n.charge_rate rate_diff
  from prm.vi_rp_iddsms_invoice m ,
       vi_rp_iddsms_invoice n
	where m.billingcycle_code = n.billingcycle_code
	  and m.connect_type = n.connect_type;

--IDD SMS Reort
select m.billingcycle_code,m.settle_item,m.connect_type,m.cdr_number-n.cdr_number cdrnum_diff,m.charge_rate-n.charge_rate rate_diff
  from prm.vi_rp_iddsms_report m ,
       vi_rp_iddsms_report n
	where m.billingcycle_code = n.billingcycle_code
	  and m.connect_type = n.connect_type;



--SPCP
select m.billingcycle_code,m.manager_id,m.serv_code,m.rec_count - n.rec_count  cdrnum_diff
  from prm.vi_rp_spcp_standalone m,
	     vi_rp_spcp_standalone n
where m.billingcycle_code = n.billingcycle_code  
  and m.manager_code = n.manager_code
	and m.serv_code = n.serv_code
	and m.price = n.price;
	
select distinct a.manager_id,a.serv_code,a.billingcycle_code from
(select m.billingcycle_code,m.manager_id,m.serv_code,m.rec_count - n.rec_count  cdrnum_diff
  from prm.vi_rp_spcp_standalone m,
	     vi_rp_spcp_standalone n
where m.billingcycle_code = n.billingcycle_code  
  and m.manager_code = n.manager_code
	and m.serv_code = n.serv_code
	and m.price = n.price
	) a where a.cdrnum_diff <> 0;



--roam
select * from (
select m.tapfilename,m.recnum-n.recnum cdrnum_diff ,m.tapfee - n.tapfee fee_diff
  from prm.taplog m,
	     prm_sum_taproam n
 where m.tapfilename= n.tapfilename
   and m.tapfilename <> ' '
	 and substr(m.processtime,1,6) = to_char(n.dealtime,'yyyymm')) a
	  where a.cdrnum_diff > 0 or  a.fee_diff > 0;
select * from prm.taplog t where t.tapfilename = 'CDIRQACUSA1600694';
