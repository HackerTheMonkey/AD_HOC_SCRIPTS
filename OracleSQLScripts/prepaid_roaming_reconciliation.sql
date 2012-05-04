-- Get all the roaming IMSI's for JAN and FEB
 /*
   The total summation of the below report will show the number of roaming records during
   the designated period.
*/
-- total is 449816 call records (VOICE+SMS)
select count(*) from
(select imsi from prmnew.prm_tapinroam_vs_200901 a union all select imsi from prmnew.prm_tapinroam_vs_200902 b);


-- Put all the distinct IMSI's in one table
insert into prmnew.tmp_fraud_nums_1 a
       select imsi from prmnew.prm_tapinroam_vs_200901 a union select imsi from prmnew.prm_tapinroam_vs_200902 b; 
-- Get the total number of distinct prepaid and postpaid roamers
select * from prmnew.tmp_fraud_nums_1 a;
select count(distinct imsi) from prmnew.tmp_fraud_nums_1 a;--Total roamers are 9230                              
select count(*) from prmnew.tmp_fraud_nums_1 a;

-- Get all the postpaid subscribers' IMSI's
select * from prmnew.tmp_fraud_nums_1;
create table ccare.tmp_pos_imsi as select a.imsi from ccare.inf_subscriber_all a where a.prepaid_flag=1 and a.sub_state <> 'B02';
select * from ccare.inf_status;
select count(*) from ccare.tmp_pos_imsi;

-- Get a list of subscribers who activated the roaming service through BOSS system in JAN & FEB
select * from ccare.rul_business_code t where lower(t.busi_remark) like '%roam%';-- PPS_ROAM code is CB200
create table ccare.tmp_roam_boss_imsi as
select t.imsi from ccare.his_inf_businessinfo t where t.busi_type='CB200' and (t.busi_date >= '1-JAN-2009' and t.busi_date < sysdate);
select count(*) from ccare.tmp_roam_boss_imsi;

/* 
   now we have to exclude the postpaid roamers and the prepaid who are roaming as postpaid roamers from the whole roamers list to get
   the final list of PREPAID ROAMERS
*/
select * from prmnew.tmp_fraud_nums_1 a;-- All Roamers
select * from ccare.tmp_pos_imsi b;-- All postpaid numebrs IMSI's
select * from ccare.tmp_roam_boss_imsi c; -- All prepaid roaming as postpaid

-- Execlusion Query
   -- Postpaid roamers execlusion query
   select imsi from prmnew.tmp_fraud_nums_1 a minus select imsi from ccare.tmp_pos_imsi b;
   -- Prepaid Roamers execlusion query
   select imsi from (select imsi from prmnew.tmp_fraud_nums_1 a minus select imsi from ccare.tmp_pos_imsi b) d
   minus
   select imsi from ccare.tmp_roam_boss_imsi c;
   -- Table creation
   create table ccare.tmp_all_pre_roamers as
   (select imsi from (select imsi from prmnew.tmp_fraud_nums_1 a minus select imsi from ccare.tmp_pos_imsi b) d
   minus
   select imsi from ccare.tmp_roam_boss_imsi c); 
   -- Create a table that will contain all the prepaid roamers' IMSI's with thier SUB ID's
   create table ccare.tmp_all_pre_roam_subid as
   select sub_id from ccare.inf_subscriber_all t where t.imsi in (select * from ccare.tmp_all_pre_roamers);
   

-- Unify All the roaming tables in one view and all the IN CDRs (VOICE and SMS)in one view as well
create or replace view prmnew.tmp_roaming_cdr as
select * from prmnew.prm_tapinroam_vs_200901 union all select * from prmnew.prm_tapinroam_vs_200902;  

create or replace view rating.tmp_roaming_cdr_in as
select * from rating.cdr_pre_voice200901 union all select * from rating.cdr_pre_voice200902;

create or replace view rating.tmp_roaming_cdr_in_sms as
select * from rating.cdr_pre_sms200901 union all select * from rating.cdr_pre_sms200902;


-- Final Report
   -- Total Duration and Charge from the Tapin CDRs
  create table ccare.tmp_tapin_total as
  select t.IMSI,sum(t.DURATION) TOTAL_SECONDS,sum(t.CHARGE11 * t.EXCHANGERATE) total_charge_usd,to_char(t.STARTTIME,'yyyymmdd') CALL_DATE
  from prmnew.tmp_roaming_cdr t where t.IMSI in (select imsi from ccare.tmp_all_pre_roamers)
  group by t.imsi,to_char(t.STARTTIME,'yyyymmdd');
  
  select * from ccare.tmp_tapin_total t;
  
  -- Total Duration and Charge from the IN CDRs
  select * from prepaid_valid_charges@hakki_test;
  select * from prepaid_valid_charges_feb@hakki_test;
  create table ccare.tmp_all_pre_charges_subid as
         select * from prepaid_valid_charges@hakki_test union all select * from prepaid_valid_charges_feb@hakki_test;
  
  create table ccare.tmp_all_pre_charges_jan_feb as
  select b.imsi,a."day",a.total_seconds,a.total_fee 
  from ccare.tmp_all_pre_charges_subid a,ccare.inf_subscriber_all b
  where a.sub_id=b.sub_id;     
  
  -- report reconciliation steps
  select * from ccare.tmp_all_pre_charges_jan_feb t order by t.imsi;-- all prepaid roamers charges
  select * from ccare.tmp_tapin_total t order by t.imsi;
  -- calculate the losses basing on that we should pay more than what we got.
  select 
         a.imsi,
         a.call_date,
         a.total_seconds total_tap_sec,
         b.total_seconds total_in_sec,
         a.total_charge_usd total_tap_fee,
         b.total_fee total_in_fee
     from 
         ccare.tmp_tapin_total a,
         ccare.tmp_all_pre_charges_jan_feb b
     where
         a.imsi=b.imsi(+) and
         a.call_date=b."day"(+);
  --
  select sum(a.total_charge_usd) from ccare.tmp_tapin_total a;
  select sum(b.total_fee) from ccare.tmp_all_pre_charges_jan_feb b;
  
  -- Create a table that will contain the last result of the report
  create table ccare.tmp_final_roam_rep_01 as
  select 
         a.imsi,
         a.call_date,
         a.total_seconds total_tap_sec,
         b.total_seconds total_in_sec,
         a.total_charge_usd total_tap_fee,
         b.total_fee total_in_fee
     from 
         ccare.tmp_tapin_total a,
         ccare.tmp_all_pre_charges_jan_feb b
     where
         a.imsi=b.imsi(+) and
         a.call_date=b."day"(+);
   -- Create a new report that will include the operator name as well as the MSISDN
   
         
  
