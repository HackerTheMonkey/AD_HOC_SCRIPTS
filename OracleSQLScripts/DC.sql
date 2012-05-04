--DC SQL Queries

--to find the subscribers that their credit limit is greater than one thousand dollars
Select a.acct_id,a.cust_id,a.credit_limit,a.Local_Id,b.group_name From dc_acct_credit_alarm a,dc_base_group b
Where (a.group_id = b.group_id) And a.credit_limit > 1000;

-- to find the number of roaming postpaid subscribers
Select * From dc_acct_credit_alarm a Where 
a.group_id=(Select group_id From dc_base_group Where group_name='Roaming Group');

-- SMS Notifier Queries
-------------------------------------------------------------------------------------------------
Select Distinct (msisdn),t.local_id From inf_subscriber_all t,inf_acct v,inf_acct_relation r 
Where sub_state In ('B01','B04') And v.acct_id = r.acct_id 
And r.sub_id = t.sub_id And v.bill_cycle_type='22' Order By msisdn;

Select Distinct local_id From inf_subscriber_all;

Select Distinct (msisdn),t.local_id From inf_subscriber_all 
t,inf_acct v,inf_acct_relation r Where sub_state In ('B01','B04') 
And msisdn ='07704615001' And v.acct_id = r.acct_id And r.sub_id = t.sub_id 
And v.bill_cycle_type='22' Order By msisdn;
---------------------------------------------------------------------------------------------------

