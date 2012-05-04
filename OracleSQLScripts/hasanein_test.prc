create or replace procedure hasanein_test
is
       file_handler_01 UTL_FILE.File_Type;-- define the file handler
       cursor FRAUD_REPORT is -- the cursor that will contain the report query
              select a.caller||','||a.total_occupy_time||','||a.total_count_calls||','||a.trunkin||','||a.switch_code As report from temp1 a
               where
                 a.trunkin in (select b.trunk_no from bs_trunk_info b where b.trunk_type='Trunk IN' and b.trunk_manager='ZAIN ATHEER') and
                 a.switch_code in (select b.switch_code from bs_trunk_info b where b.trunk_type='Trunk IN' and b.trunk_manager='ZAIN ATHEER') and
                 a.total_count_calls > 10 and
                 not exists (select 1 from temp2 c where c.called=a.caller) and
                 exists (select 1 from bs_trunk_info d where d.trunk_no=a.trunkin and d.switch_code=a.switch_code);
       /*
         define the record that will contain one row at a time from the cursor contents
       */
       IRAQNA_FRAUD_REPORT_REC FRAUD_REPORT%rowtype;
       -- define a variable to contain the current date
       currentDate Date := Sysdate;
Begin
      -- set the output buffer to unlimited
      dbms_output.enable(null);
      -- open the output file
      file_handler_01 := utl_file.fopen('TEST_DIR','KOREK_FRAUD_REPORT_'||To_char(CurrentDate,'yyyymmdd')||'.csv','A');
      UTL_FILE.put_line(file_handler_01,'caller,duration,no_of_calls,trunk_in,GT_Address');
      -- open the cursor
      Open FRAUD_REPORT;
        Loop
        Exit When FRAUD_REPORT%Notfound; -- exit when there will be no more records to read from the cursor
             -- fetch data from the cursor
             Fetch FRAUD_REPORT Into IRAQNA_FRAUD_REPORT_REC;
             -- write data to the file
             UTL_FILE.put_line(file_handler_01,IRAQNA_FRAUD_REPORT_REC.REPORT);
        End Loop;
      -- close the cursor
      Close FRAUD_REPORT;
      -- close the output file
      utl_file.fclose(file_handler_01);
end;
/
