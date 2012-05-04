Select * From his_inf_businessinfo t Where t.busi_type='CY044' And to_char(t.busi_date,'yyyymm')='200802';
Select * From his_inf_businessinfo;
Select * From rul_business_code;


-- SIM Replacement report
Select t.busi_local_id,Count(t.msisdn) From his_inf_businessinfo t
Where to_char(t.busi_date,'yyyymm')='200809' And t.busi_type='CB020'
Group By t.busi_local_id;

-- Release from pool subscribers report
Select t.busi_local_id,Count(t.msisdn) From his_inf_businessinfo t
Where to_char(t.busi_date,'yyyymm')='200809' And t.busi_type='CY044'
Group By t.busi_local_id;

-- subscribers released from pool but they have recharged
Select t.busi_local_id,Count(t.msisdn) From his_inf_businessinfo t
Where to_char(t.busi_date,'yyyymm')='200801' And t.busi_type='CY044' And
Exists (Select * From billing.inf_bill_topup_01 a Where a.msisdn=t.msisdn)
Group By t.busi_local_id;

-- subscribers released from pool but they have not been recharged
Select t.busi_local_id,Count(t.msisdn) From his_inf_businessinfo t
Where to_char(t.busi_date,'yyyymm')='200801' And t.busi_type='CY044' And
Not Exists (Select * From billing.inf_bill_topup_01 a Where a.msisdn=t.msisdn)
Group By t.busi_local_id;

Create Or Replace View bs_transaction_info As
Select * From billing.inf_bill_topup_01 Union All Select * From billing.inf_bill_topup_02 t Where t.trade_time < '16-FEB-08';
Select * From bs_transaction_info;

-- subscribers released from pool but recharged after 15 days from the end of the month in which they have released from the pool state
Select t.busi_local_id,Count(t.msisdn) From his_inf_businessinfo t
Where to_char(t.busi_date,'yyyymm')='200801' And t.busi_type='CY044' And
Exists (Select * From (Select * From billing.inf_bill_topup_01 Union All Select * From billing.inf_bill_topup_02 t Where t.trade_time < '16-FEB-08') a Where a.msisdn=t.msisdn)
Group By t.busi_local_id;

-- subscribers released from pool but not recharged even after 15 days from the end of the month in which they have released from the pool state
Select t.busi_local_id,Count(t.msisdn) From his_inf_businessinfo t
Where to_char(t.busi_date,'yyyymm')='200801' And t.busi_type='CY044' And
Not Exists (Select * From (Select * From billing.inf_bill_topup_01 Union All Select * From billing.inf_bill_topup_02 t Where t.trade_time < '16-FEB-08') a Where a.msisdn=t.msisdn)
Group By t.busi_local_id;
