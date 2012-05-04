
Select g.First_Name, g.Contact_Person, g.Office_Tel, g.Home_Tel,g.Acctid, g.Msisdn,g.imsi,g.iccid,g.Create_Date,g.ACTIVATION_DATE,g.dept_name,g.oper_name,g.Status,g.BILL_CYCLE_TYPE,g.Duning_Flag,f.Deposit,f.Tot_Bil_Amt,f.Tot_Os_Amt as Open_Amt,
            Credit_Limit
From (Select To_Char(e.Cust_Id) Custid, e.First_Name, e.Contact_Person, e.Office_Tel, e.Home_Tel, To_Char(a.Sub_Id) Subid,
                            To_Char(c.Acct_Id) Acctid, a.Msisdn,a.imsi,a.iccid, a.Local_Id Location_Id, a.Create_Date, Substr(b.Remark, 1, 10) Status,
                            s.change_date as ACTIVATION_DATE,Decode(c.BILL_CYCLE_TYPE,'01','REAL') BILL_CYCLE_TYPE,a.dept,a.oper_id,q.dept_name,r.oper_name,
                            Decode(a.Dun_Flag, '1', 'DUN and Suspend', '2', 'Dun but Not Suspend', '3', 'Not Dun and Not Suspend') Duning_Flag,
                            Orign_Credit Credit_Limit, Credit_Limit - Orign_Credit Adv_Amt
             From ccare.Inf_Subscriber_All a, ccare.Inf_Status b, ccare.Inf_Acct c, ccare.Inf_Acct_Relation d, ccare.Inf_Customer_All e,
             TOPENG.INF_DEPT q,TOPENG.INF_OPER r,ccare.his_sub_state_change s
             Where a.Sub_State = b.Status_Id And a.Sub_Id = d.Sub_Id And c.Acct_Id = d.Acct_Id And a.Cust_Id = e.Cust_Id
             and a.dept=q.dept_id
             and a.oper_id=r.oper_id
             and a.oper_id <>9
                         And a.prepaid_flag=1 And c.converge_flag=1
                        And c.Bill_Cycle_Type = '01'
           --And a.sub_state ='B01' 
           and s.SUB_ID=a.sub_id
           and s.NEW_SUB_STATUS='B01'
           and s.change_date like (sysdate - 1)    
             ) g,
        (Select distinct Cust_Id, Sub_Id, Acct_Id, Msisdn,                       
            Sum(Decode(Trans_Type, 'DEP', Abs(Open_Amt), 0)) Deposit,
            Sum(Decode(Trans_Type, 'BLL', Invoice_Amt, 0)) Tot_Bil_Amt,
            Sum(Decode(Trans_Type, 'BLL', Open_Amt, 0)) Tot_Os_Amt
            From billing.Receivables
            Where Trans_Type In ('BLL', 'DEP')
            Group By Cust_Id, Sub_Id, Acct_Id, Msisdn) f           
Where g.Acctid = f.Acct_Id(+) And g.Msisdn = f.Msisdn(+);
--and g.msisdn IN ('07704825338');


