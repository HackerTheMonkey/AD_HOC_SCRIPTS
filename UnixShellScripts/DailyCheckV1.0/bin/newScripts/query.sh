#********************************************************
# This Program is used Transfer CC Interface Table Data
# To Rating Custinfo.
#********************************************************
. ~/.profile


sqlplus -s prm/mmprm@boss <<!! 

set serveroutput on size 1000000

select t.caller, t.called from bill_s_inter t where t.toll_type='SMS' and 
(
(t.caller like '964770%' or t.caller like '964780%' or t.caller like '964790%' )and t.caller_manager is null
)
and t.start_time > sysdate - 1
and rownum<300;
# where to_char(t.start_time, 'yyyymmdd')='20060620' and t.serv_key='SMS' and t.caller='964770%' and t.called='964780%';
 
/

quit
!!

