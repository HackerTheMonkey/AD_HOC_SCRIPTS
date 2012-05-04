-- IDD SMS
Select *
From Accumulate_Record_Day t
Where t.Accumulate_Day Like '2008020%' And t.Net_Name = 'WL002' And t.Toll_Tra = 'SMS';
Select
 Decode(t.Caller_Svr, 'SV307', 'SMSMT'), Decode(t.Called_Svr, 'SV307', 'SMSMO'), t.Toll_Type, Sum(t.Total_Item),
 t.Charge_Rate, Sum(t.Charge_Rate * t.Total_Item)
From Accumulate_Record_Day t
Where t.bill_date Like '200802%' And t.Toll_Tra = 'SMS' And t.Toll_Type In ('ZONE1', 'ZONE2', 'ZONE3', 'ZONE4')
Group By t.Toll_Type, t.Caller_Svr, t.Called_Svr, t.Charge_Rate
Order By t.Called_Svr, t.Caller_Svr, t.Toll_Type, t.Charge_Rate;

--IDD VOICE

Select t.Toll_Tra, t.Trunkin_Mgr, t.trunkin_svr,t.Trunkout_Mgr,t.trunkout_svr, Sum(t.Total_Item),sum(t.total_toll_fee)
From Accumulate_Record_Day t							
Where t.Bill_Date Like '200802%' And t.Net_Name = 'WL002' And t.toll_tra='VOICE'							
Group By t.Toll_Tra, t.Trunkin_Mgr, t.trunkin_svr,t.Trunkout_Mgr,t.trunkout_svr;


--Inter VOICE
Select t.Toll_Tra, t.Trunkin_Mgr, t.trunkin_svr,t.Trunkout_Mgr,t.trunkout_svr, Sum(t.Total_Item)							
From Accumulate_Record_Day t							
Where t.Bill_Date Like '200802%' And t.Net_Name = 'WL001' And t.toll_tra='VOICE'							
Group By t.Toll_Tra, t.Trunkin_Mgr, t.trunkin_svr,t.Trunkout_Mgr,t.trunkout_svr;

--Inter SMS
Select t.Toll_Tra, t.caller_mgr,t.called_mgr,Sum(t.total_item)								
From Accumulate_Record_Day t								
Where t.Bill_Date Like '200802%' And t.Net_Name = 'WL001' And t.toll_tra='SMS'								
Group By t.Toll_Tra, t.caller_mgr,t.called_mgr;

--SPCP
Select
 t.Sp_Code, t.Serv_Code, b.Service_Name, b.Price, Sum(t.Service_Fee)/b.Price As "RecNo", Sum(t.Service_Fee)
From accumulate_spcp_record t, Dsmp_Product_View b
Where t.bill_date Like '200803%' And
			t.Serv_Code In (100122200, 100180800, 100180800, 100181000, 100179100, 100179300, 100180400, 100181200) And
			t.Service_Fee > 0 And t.Serv_Code = b.Serv_Id And
			To_Date(t.bill_date, 'YYYYMMDDHH24MISS') >= b.Effect_Time And
			To_Date(t.bill_date, 'YYYYMMDDHH24MISS') <= b.Expire_Time
Group By t.Sp_Code, t.Serv_Code, b.Service_Name ,b.Price
Order By t.Sp_Code, t.Serv_Code, b.Service_Name ,b.Price

--Roaming
Select Decode(t.Taptype, '1', 'RoamOUT', 'RoamIN') As "Tap Type", k.Manager_Id, k.Manager_En_Name, Count(t.Manage_Code) as "No. of TAP Files",
			 Sum(t.Tapfee) As "Sum of Fee"
From Taplog t, Manager_Info k
Where t.Processtime Like '200804%' And t.Manage_Code = k.Manager_Id And k.settle_type='WL004'
Group By t.Taptype, k.Manager_Id, k.Manager_En_Name
Order By t.Taptype, k.Manager_Id, k.Manager_En_Name;
