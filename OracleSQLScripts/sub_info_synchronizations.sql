-- get all the Suspected IMSIs with their correct MSISDNs
select b.imsi,a.msisdn from tmp_has a,tmp_has1 b where a.imsi=b.imsi;
-- get all the MSISDNs with wrong IMSIs
select msisdn,imsi from inf_subscriber_all t 
where  
       t.imsi in (select b.imsi from tmp_has a,tmp_has1 b where a.imsi=b.imsi) and
       t.msisdn not in (select a.msisdn from tmp_has a,tmp_has1 b where a.imsi=b.imsi) and
       t.sub_state <> 'B02';
-- Get their count       
select count(*) from (select msisdn,imsi from inf_subscriber_all t 
where  t.imsi in (select b.imsi from tmp_has a,tmp_has1 b where a.imsi=b.imsi) and
       t.msisdn not in (select a.msisdn from tmp_has a,tmp_has1 b where a.imsi=b.imsi) and
       t.sub_state <> 'B02');-- 07710000010 - 07710004999
