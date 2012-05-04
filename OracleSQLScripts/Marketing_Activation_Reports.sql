-- GPRS Activations
Create Table tmp_gprs_activations As
Select t.imsi,t.msisdn,t.func_id,t.ret_info,t.Ask_Date From Int_Ask t Where t.ask_date >= '1-SEP-08' And t.Ask_Date < '1-OCT-08' And t.func_id='OPENGPRS' And t.ret_info='Operation is successful';
-- MMS Activations Report
Create Table tmp_mms_activations As
Select t.imsi,t.msisdn,t.func_id,t.ret_info,t.Ask_Date From Int_Ask t Where t.ask_date > '4-JAN-08' And t.func_id='OPENMMS' And t.ret_info='Operation is successful';
-- MCN Activation Report
Create Table tmp_mcn_activations As
Select t.imsi,t.msisdn,t.func_id,t.ret_info,t.Ask_Date From Int_Ask t Where t.ask_date > '4-JAN-08' And t.func_id='OPENMCN' And t.ret_info='Operation is successful';
-- SIM Replacement Report
Create Table tmp_sim_activations As
Select t.imsi,t.msisdn,t.func_id,t.ret_info,t.Ask_Date From Int_Ask t Where t.ask_date > '4-JAN-08' And t.func_id='MODIMSI' And t.ret_info='Operation is successful';
-- Release from Black List report
Create Table tmp_black_list_activations As
Select t.imsi,t.msisdn,t.func_id,t.ret_info,t.Ask_Date From Int_Ask t Where t.ask_date > '4-JAN-08' And t.func_id='RELEASEPPSBLACKLST' And t.ret_info='Operation is successful';
-- Mobile Suspension Report
Create Table tmp_suspension_activations As
Select t.imsi,t.msisdn,t.func_id,t.ret_info,t.Ask_Date From Int_Ask t Where t.ask_date > '4-JAN-08' And t.func_id='SABLCK' And t.ret_info='Operation is successful';
-- Mobile Reconnection Report
Create Table tmp_reconnection_activations As
Select t.imsi,t.msisdn,t.func_id,t.ret_info,t.Ask_Date From Int_Ask t Where t.ask_date > '4-JAN-08' And t.func_id='SABUNLCK' And t.ret_info='Operation is successful';