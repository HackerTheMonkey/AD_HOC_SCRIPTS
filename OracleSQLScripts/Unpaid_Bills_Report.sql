

Select g.Custid, g.First_Name, g.Contact_Person, g.Office_Tel, g.Home_Tel, g.Subid, g.Acctid, g.Msisdn, g.Location_Id,
			 g.Create_Date, g.Status, g.Last_Mod_Date, g.Duning_Flag, g.Plan, f.Deposit, Jan07bil, Jan07bal, Feb07bil,
			 Feb07bal, Mar07bil, Mar07bal, Apr07bil, Apr07bal, May07bil, May07bal, Jun07bil, Jun07bal, Jul07bil, Jul07bal,
			 Aug07bil, Aug07bal, Sep07bil, Sep07bal,Oct07bil,Oct07bal,Nov07bil,Nov07bal,Dec07bil,Dec07bal,
			 -- from above Line you can add New Month 
			 Tot_Bil_Amt, Tot_Os_Amt Open_Amt, Credit_Limit, Adv_Amt
From (Select To_Char(e.Cust_Id) Custid, e.First_Name, e.Contact_Person, e.Office_Tel, e.Home_Tel, To_Char(a.Sub_Id) Subid,
							To_Char(c.Acct_Id) Acctid, a.Msisdn, a.Local_Id Location_Id, a.Create_Date, Substr(b.Remark, 1, 10) Status,
							a.Mod_Date Last_Mod_Date,
							Decode(a.Dun_Flag, '1', 'DUN and Suspend', '2', 'Dun but Not Suspend', '3', 'Not Dun and Not Suspend') Duning_Flag,
							Orign_Credit Credit_Limit, Credit_Limit - Orign_Credit Adv_Amt, y.Prod_Name Plan
			 From Inf_Subscriber_All a, Inf_Status b, Inf_Acct c, Inf_Acct_Relation d, Inf_Customer_All e, Inf_Products x,
						Pdm_Prodtab y
			 Where a.Sub_State = b.Status_Id And a.Sub_Id = d.Sub_Id And c.Acct_Id = d.Acct_Id And a.Cust_Id = e.Cust_Id And
						 x.Product_Id = y.Prod_Id And x.Sub_Id = a.Sub_Id And x.Product_Type = '1' And a.prepaid_flag=1 And c.converge_flag=1
						--and c.sub_id = a.sub_id
						 And c.Bill_Cycle_Type = '01'
           --And a.msisdn='07704615055'
           --  And a.sub_state In ('B01','B03','B04')
            --And a.sub_state ='B02'
			 
			 ) g,
		 (Select Cust_Id, Sub_Id, Acct_Id, Msisdn,
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'JAN-07', Invoice_Amt, 0), 0)) "JAN07BIL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'JAN-07', Open_Amt, 0), 0)) "JAN07BAL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'FEB-07', Invoice_Amt, 0), 0)) "FEB07BIL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'FEB-07', Open_Amt, 0), 0)) "FEB07BAL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'MAR-07', Invoice_Amt, 0), 0)) "MAR07BIL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'MAR-07', Open_Amt, 0), 0)) "MAR07BAL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'APR-07', Invoice_Amt, 0), 0)) "APR07BIL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'APR-07', Open_Amt, 0), 0)) "APR07BAL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'MAY-07', Invoice_Amt, 0), 0)) "MAY07BIL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'MAY-07', Open_Amt, 0), 0)) "MAY07BAL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'JUN-07', Invoice_Amt, 0), 0)) "JUN07BIL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'JUN-07', Open_Amt, 0), 0)) "JUN07BAL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'JUL-07', Invoice_Amt, 0), 0)) "JUL07BIL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'JUL-07', Open_Amt, 0), 0)) "JUL07BAL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'AUG-07', Invoice_Amt, 0), 0)) "AUG07BIL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'AUG-07', Open_Amt, 0), 0)) "AUG07BAL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'SEP-07', Invoice_Amt, 0), 0)) "SEP07BIL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'SEP-07', Open_Amt, 0), 0)) "SEP07BAL",
							Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'OCT-07', Invoice_Amt, 0), 0)) "OCT07BIL",
              Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'OCT-07', Open_Amt, 0), 0)) "OCT07BAL",
              Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'NOV-07', Invoice_Amt, 0), 0)) "NOV07BIL", 
              Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'NOV-07', Open_Amt, 0), 0)) "NOV07BAL",     
             
              Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'DEC-07', Invoice_Amt, 0), 0)) "DEC07BIL", 
              Sum(Decode(Trans_Type, 'BLL', Decode(Substr(Invoice_Date, 4), 'DEC-07', Open_Amt, 0), 0)) "DEC07BAL", 
              -- You Can Add Nov [ Invoice Amount ;Open Amount ] in above Line
							
							Sum(Decode(Trans_Type, 'DEP', Abs(Open_Amt), 0)) Deposit,
							Sum(Decode(Trans_Type, 'BLL', Invoice_Amt, 0)) Tot_Bil_Amt,
							Sum(Decode(Trans_Type, 'BLL', Open_Amt, 0)) Tot_Os_Amt
			 From Receivables
			 Where Trans_Type In ('BLL', 'DEP')
			 Group By Cust_Id, Sub_Id, Acct_Id, Msisdn) f
Where g.Acctid = f.Acct_Id(+) And g.Msisdn = f.Msisdn(+)

