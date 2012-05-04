--- Sunchronizing HLR subscribers lock state with Billing System Database
--- Action Plan

--1- Create the required tables to contain the different subscribers lock state
create table SAB_IN_LCK  (imsi varchar2(50),msisdn varchar2(50),SAB_IN_LCK  varchar2(6));
create table SAB_OUT_LCK (imsi varchar2(50),msisdn varchar2(50),SAB_OUT_LCK varchar2(6));
create table GSM_IN_LCK  (imsi varchar2(50),msisdn varchar2(50),GSM_IN_LCK  varchar2(6));
create table GSM_OUT_LCK (imsi varchar2(50),msisdn varchar2(50),GSM_OUT_LCK varchar2(6));
create table GPRS_LCK    (imsi varchar2(50),msisdn varchar2(50),GPRS_LCK    varchar2(6));

--2- Update all the tables to set the lock flag to true
Update sab_in_lck t Set t.sab_in_lck_status='true';
Update sab_out_lck t Set t.sab_out_lck_status='true';
Update gsm_in_lck t Set t.gsm_in_lck_status='true';
Update gsm_out_lck t Set t.gsm_out_lck_status='true';
Update gprs_lck t Set t.gprs_lck_status='true';

--3- Create the table that will contain the distinct IMSI/MSISDN values
Create Table distinct_imsi As
    Select Distinct imsi From
    (
        Select * From sab_in_lck a
        Union
        Select * From sab_out_lck b
        Union
        Select * From gsm_in_lck c
        Union
        Select * From gsm_out_lck d
        Union
        Select * From gprs_lck e
    );
    
Select count(*) From distinct_imsi;

--4- Create the normalized table that will contain the final mined data
Create Table HLR_SUB_LCK_ST As
Select
            a.imsi,
            decode(b.sab_in_lck_status,'true','true','','false') sab_in_lck_status,
            decode(c.sab_out_lck_status,'true','true','','false') sab_out_lck_status,
            decode(d.gsm_in_lck_status,'true','true','','false') gsm_in_lck_status,
            decode(e.gsm_out_lck_status,'true','true','','false') gsm_out_lck,
            decode(f.gprs_lck_status,'true','true','','false') gprs_lck_status
From
            distinct_imsi a,
            sab_in_lck b,
            sab_out_lck c,
            gsm_in_lck d,
            gsm_out_lck e,
            gprs_lck f
Where
            a.imsi=b.imsi(+) And
            a.imsi=c.imsi(+) And
            a.imsi=d.imsi(+) And
            a.imsi=e.imsi(+) And
            a.imsi=f.imsi(+);
            
--5- Total qeury without the need to craete tables (using IMSI) (count=20,575)
Create Table HLR_SUB_LCK_ST As
Select
            a.imsi,
            a.msisdn,
            decode(b.sab_in_lck_status,'true','true','','false') sab_in_lck_status,
            decode(c.sab_out_lck_status,'true','true','','false') sab_out_lck_status,
            decode(d.gsm_in_lck_status,'true','true','','false') gsm_in_lck_status,
            decode(e.gsm_out_lck_status,'true','true','','false') gsm_out_lck,
            decode(f.gprs_lck_status,'true','true','','false') gprs_lck_status
From
              (Select Distinct imsi,msisdn From
                (
                    Select * From sab_in_lck a
                    Union
                    Select * From sab_out_lck b
                    Union
                    Select * From gsm_in_lck c
                    Union
                    Select * From gsm_out_lck d
                    Union
                    Select * From gprs_lck e
                ) 
            )a,
            sab_in_lck b,
            sab_out_lck c,
            gsm_in_lck d,
            gsm_out_lck e,
            gprs_lck f
Where
            a.imsi=b.imsi(+) And
            a.imsi=c.imsi(+) And
            a.imsi=d.imsi(+) And
            a.imsi=e.imsi(+) And
            a.imsi=f.imsi(+);          
            

--6- refresh the subscriber's status in BOSS DB
Update inf_subscriber_all t Set t.sub_state='B01'
       Where t.msisdnin (Select msisdn From HLR_SUB_LCK_ST);
       
--7- get the msisdn's that need to provision SAB IN LCK
Select msisdn From HLR_SUB_LCK_ST t Where t.sab_in_lck_status='false';
--8- get the msisdn's that need to provision SAB OUT LCK
Select msisdn From HLR_SUB_LCK_ST t Where t.sab_out_lck_status='false';
--9- get the msisdn's that need to provision GPRS LOCK 
Select msisdn From HLR_SUB_LCK_ST t Where t.gprs_lck_status='false';
--10- get the msisdn's that need to de-provision GSM IN LOCK
Select msisdn From HLR_SUB_LCK_ST t Where t.gsm_in_lck_status='true';
--11- get the msisdn's that need to de-provision GSM OUT LOCK
Select msisdn From HLR_SUB_LCK_ST t Where t.gsm_out_lck='true';
