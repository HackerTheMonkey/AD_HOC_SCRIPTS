Select * From tab;
Select * From MTC_JAN_08 t Where t.caller Like '964770%';
Truncate Table MTC_JAN_08;
Create Table MTC_JAN_08
(cdr_type varchar2(3),call_date Date,caller varchar2(50),called varchar2(50),imsi varchar2(50),imei varchar2(50),duration number,cellid varchar2(10));

Create Index idx_MTC_JAN_08_caller On MTC_JAN_08(Caller);
Create Index idx_MTC_JAN_08_called On MTC_JAN_08(called);
Create Index idx_MTC_JAN_08_date On MTC_JAN_08(call_date);
Create Index idx_MTC_JAN_08_imsi On MTC_JAN_08(imsi);
Create Index idx_MTC_JAN_08_imei On MTC_JAN_08(imei);
Create Index idx_MTC_JAN_08_cellid On MTC_JAN_08(cellid);


Select * From dba_data_files t Where t.tablespace_name='TBS_MTC_CDR_01' Order By t.file_name;
Select * From Dba_Free_Space t Where t.tablespace_name='TBS_MTC_CDR_01';


-- Create the tablespace
Create Tablespace TBS_MTC_CDR_01 Datafile '/mydata/oradata/tbs_mtc_cdr_01.dbf' Size 250M Autoextend On;
Drop Tablespace TBS_MTC_CDR_01 Including contents And Datafiles;






-- Create the datafiles

Set Serveroutput On;
Declare
       I Number;
       sqlStr varchar2(500);
Begin
      For I In 10..35
      Loop
          sqlStr := 'alter tablespace TBS_MTC_CDR_01 add datafile ''/mydata/oradata/tbs_mtc_cdr_'||I||'.dbf'' size 250M autoextend on';
          dbms_output.put_line(sqlStr);
          Execute Immediate sqlStr;
      End Loop;
End;
/         