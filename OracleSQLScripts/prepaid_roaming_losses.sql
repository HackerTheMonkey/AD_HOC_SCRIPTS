-- Generic Queries
select * from ccare.tmp_pre_fraud_apr1 t;
select * from prmnew.tmp_roam t;
-- All Losses due to that IN did not charge the subscribers
select distinct imsi from ccare.tmp_pre_fraud_apr1 t where t.total_in_fee is null;
-- All prepaid subs that IN did not charge them
select distinct imsi from ccare.tmp_pre_fraud_apr1 a where a.total_in_fee is null
minus
select imsi from prmnew.tmp_roam b;
-- All postpaid subs that IN did not charge them and they are prepaid in billing
select distinct imsi from ccare.tmp_pre_fraud_apr1 c where c.total_in_fee is null
minus
(select distinct imsi from ccare.tmp_pre_fraud_apr1 a where a.total_in_fee is null
minus
select imsi from prmnew.tmp_roam b);
-- All Loses due to prepaid
select sum(t.total_tap_fee) from ccare.tmp_pre_fraud_apr1 t where t.total_in_fee is null and t.imsi in
(select distinct imsi from ccare.tmp_pre_fraud_apr1 a where a.total_in_fee is null
minus
select imsi from prmnew.tmp_roam b);
-- All loses due to postpaid
select sum(t.total_tap_fee) from ccare.tmp_pre_fraud_apr1 t where t.total_in_fee is null and t.imsi in
(select distinct imsi from ccare.tmp_pre_fraud_apr1 c where c.total_in_fee is null
minus
(select distinct imsi from ccare.tmp_pre_fraud_apr1 a where a.total_in_fee is null
minus
select imsi from prmnew.tmp_roam b));
-- All prepaid subscribers with their roaming partners
select v.imsi,to_char(v.starttime,'yyyymmdd') call_date,v.homemanager,v.camel_service_address,v.camel_service_level,v.camel_service_key
       from 
               prmnew.prm_tapinroam_vs_200904 v 
       where 
       v.imsi in (select distinct imsi from ccare.tmp_pre_fraud_apr1 a where a.total_in_fee is null minus select imsi from prmnew.tmp_roam b)
       group by
             v.imsi,to_char(v.starttime,'yyyymmdd'),v.homemanager,v.camel_service_address,v.camel_service_level,v.camel_service_key
