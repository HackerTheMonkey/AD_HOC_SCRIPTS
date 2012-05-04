
Select basefile,index1,isasn,isstat,apname,collectcfgpath From tbl_med_sec_accesspoint;

Select t.switch_count,t.col_suc_cycle,t.basefile,t.apid,t.Isstat From tbl_med_sec_system t;

Select t.col_suc_cycle,t.collect_name,t.collect_type,t.protocol_factory,t.Link_Count,
t.pri_link,t.col_dir_count,t.trans_mode,t.basefile,t.Index1,t.Id,t.apid,
t.Add_Switch_Name,t.Is_Start_Collect From tbl_med_sec_switch t;

Select t.* From tbl_med_sec_switch_link t;
Select remote_addr,remote_user,remote_pwd,local_addr From tbl_med_sec_switch_link;

Select t.check_sn,t.Module_Label,t.remote_dir,t.del_remote_file,t.File_Postfix
,t.Index1,t.Index2,t.basefile,t.swid,t.Id,t.Add_Dir_Name,t.unzip_file
,t.Is_Remove_Remote_File,t.Is_Keep_Remote_Path From tbl_med_sec_switch_col_dir t;

Select * From tbl_med_sec_common;