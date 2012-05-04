--get the account information for a given msisdn
select * from inf_ac_balance t Where t.acct_id=(Select h.acct_id From ccare.inf_acct_relation h Where h.sub_id=
(Select t.sub_id From ccare.inf_subscriber_all t Where t.msisdn='07704925522'));

Select * From user_col_comments t Where lower(t.column_name) Like '%total%';
Select * From INF_SUB_TOTAL_FEE t Where t.acct_id='8520000086182';


