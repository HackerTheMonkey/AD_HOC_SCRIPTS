#********************************************************
# This Program is used Transfer CC Interface Table Data
# To Rating Custinfo.
#********************************************************
. ~/.profile


sqlplus -s prm/mmprm@boss <<!! 

set serveroutput on size 1000000

--query the caller number
select substr(t.caller,1,7), count(*) from bill_s_inter t where t.toll_type='SMS' and 
t.caller_manager is null
and t.start_time > sysdate - 1
group by substr(t.caller,1,7);
/

quit
!!

