select g.local_id,h.Description "General Ledger",Sum(t.fee_amt) "Total Amount" from 
       inf_month_charge_bill_07 t,
       inf_subscriber_all g,
       glaccount h,
       inf_acct a,
       inf_acct_relation b
Where 
to_char(t.entry_date,'yyyymm')='200807' And
t.sub_id=g.sub_id And
t.gl_code=h.glacode And
g.sub_id=b.sub_id And
b.acct_id=a.acct_id And
a.bill_cycle_type <> '22'
Group By g.local_id,h.Description;

----------------------------------------------------------------------------------------------------------------------


Select h.Local_Id,g.Description "General Ledger",Sum(t.fee_amt) "Total Amount"
       From 
            inf_usage_bill_07 t,glaccount g,ccare.inf_subscriber_all h
       Where 
             to_char(t.entry_date,'yyyymm')='200807' And
             t.bill_cycle_type='01' And
             t.gl_code=g.glacode And
             t.sub_id=h.sub_id
             --And g.description='Airtime - Postpaid'
     Group By h.Local_Id,g.Description
     Order By h.Local_Id;

--------------------------------------------------------------------------------------------------------------------------

--new query by ranj huawei 
Select b.local_id,Sum(t.Fee_Amt),gl.description
From Inf_Month_Charge_Bill_07 t, Inf_Subscriber_All b,glaccount gl
Where 
t.Bill_Cycle_Id = '20080701' And 
t.Gl_Code = '41302' And
gl.glacode = '41302' And
t.sub_id = b.sub_id
Group By b.local_id,gl.Description;

Select s.local_id,Sum(t.charge) From  receivables_detail t,inf_subscriber_all s 
Where t.glacode = '41401' And t.bill_cycle_id ='20080701' And  t.sub_id = s.sub_id Group By s.local_id    ;