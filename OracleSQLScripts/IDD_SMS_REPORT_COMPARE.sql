Select * From bill_s_idd;
Select * From tab;
Select * From BILL_S_IDD_SMS04_NEW;
Select * From BILL_S_IDD_SMS04_NEW_BAK;
Select Count(*) From BILL_S_IDD_SMS04_NEW_BAK a Where substr(a.caller,1,6) != '964770' And to_char(a.start_time,'yyyymmdd')='20070403';
Select Count(*) From BILL_S_IDD_SMS04_NEW_BAK a to_char(a.start_time,'yyyymmdd')='20070403' And a.caller;
Select Count(*) From BILL_S_IDD_SMS04_NEW_BAK a Where substr(a.caller,1,6) != '964770' And to_char(a.start_time,'yyyymmdd')='20070403';
Create Table m365_03_apr (caller Varchar2(50), called Varchar2(50));
Create Table m365_25_apr (caller Varchar2(50), called Varchar2(50));
Create Table m365_16_apr (caller Varchar2(50), called Varchar2(50));
Select * From m365_03_apr;

Select Count(*) From m365_03_apr;
Select caller,called From BILL_S_IDD_SMS04_NEW_BAK;
Select Count(*) From m365_03_apr;

Select * From BILL_S_IDD_SMS04_NEW_BAK;
a.caller Not In (Select caller From m365_03_apr) And to_char(a.Start_Time,'yyyymmdd')='20070403' And substr(a.caller,1,6) != '964770';

Select * From m365_25_apr;
Select * From m365_16_apr;
Select * From m365_03_apr;


--find the total number of records in the Mobile 365 CDRs
Select Count(*) From m365_03_apr;  -- total = 33959
Select Count(*) From m365_16_apr;  -- total = 32852
Select Count(*) From m365_25_apr;  -- total = 27114

--find the total number of records in PRM database
-- for 3/4/2007, total = 50946
Select Count(*) From bill_s_idd_sms04_new_bak a Where a.caller Like '964770%' And to_char(a.Start_Time,'yyyymmdd')='20070403';
-- for 16/4/2007, total = 46841
Select Count(*) From bill_s_idd_sms04_new_bak a Where a.caller Like '964770%' And to_char(a.Start_Time,'yyyymmdd')='20070416';
-- for 25/4/2007, total = 46696
Select Count(*) From bill_s_idd_sms04_new_bak a Where a.caller Like '964770%' And to_char(a.Start_Time,'yyyymmdd')='20070425';


--to find the number of records that exist in PRM but is not exist in Mobile365 CDRs

--for 3/4/2007, total = 22380
        Select Count(*) From BILL_S_IDD_SMS04_NEW_BAK a  Where
        a.caller In (Select caller From m365_03_apr) And a.called In (Select called From m365_03_apr) 
        And to_char(a.Start_Time,'yyyymmdd')='20070403';
--for 16/4/2007, total = 25559
        Select Count(*) From BILL_S_IDD_SMS04_NEW_BAK a  Where
        a.caller In (Select caller From m365_16_apr) And a.called In (Select called From m365_16_apr) 
        And to_char(a.Start_Time,'yyyymmdd')='20070416';
--for 25/4/2007, total = 21141
        Select Count(*) From BILL_S_IDD_SMS04_NEW_BAK a  Where
        a.caller In (Select caller From m365_25_apr) And a.called In (Select called From m365_25_apr) 
        And to_char(a.Start_Time,'yyyymmdd')='20070425';
        
-- to find the exact record details for the IDD sms

Select Count(*) From BILL_S_IDD_SMS04_NEW_BAK a,m365_16_apr b
Where (a.caller != b.caller And a.called != b.called) And to_char(a.Start_Time,'yyyymmdd')='20070416' And a.caller Like '964770%';


    


