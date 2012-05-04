select * from tbl_med_resource_lock t For Update;
Create Table tbl_med_resource_lock_bak As Select * From tbl_med_resource_lock;
Truncate Table tbl_med_resource_lock;
Drop Table tbl_med_resource_lock;
Alter Table tbl_med_resource_lock_bak Rename To tbl_med_resource_lockd;