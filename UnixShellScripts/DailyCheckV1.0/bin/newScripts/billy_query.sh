#********************************************************
# This Program is used Transfer CC Interface Table Data
# To Rating Custinfo.
#********************************************************
. ~/.profile


sqlplus -s prm/mmprm@boss <<!! 

set serveroutput on size 1000000

select t.caller_manager, t.called_manager, to_char(t.start_time, 'yyyymmdd'), count(*)
from bill_s_inter t where t.serv_key = 'SMS'
and t.start_time >= to_date('20060601', 'yyyymmdd')
and t.start_time < to_date('20060608', 'yyyymmdd')
group by t.caller_manager, t.called_manager, to_char(t.start_time, 'yyyymmdd');

select t.caller_manager, t.called_manager, to_char(t.start_time, 'yyyymmdd'), count(*)
from bill_s_inter t where t.serv_key = 'SMS'
and t.start_time >= to_date('20060608', 'yyyymmdd')
and t.start_time < to_date('20060615', 'yyyymmdd')
group by t.caller_manager, t.called_manager, to_char(t.start_time, 'yyyymmdd');

select t.caller_manager, t.called_manager, to_char(t.start_time, 'yyyymmdd'), count(*)
from bill_s_inter t where t.serv_key = 'SMS'
and t.start_time >= to_date('20060615', 'yyyymmdd')
and t.start_time < to_date('20060622', 'yyyymmdd')
group by t.caller_manager, t.called_manager, to_char(t.start_time, 'yyyymmdd');

select t.caller_manager, t.called_manager, to_char(t.start_time, 'yyyymmdd'), count(*)
from bill_s_inter t where t.serv_key = 'SMS'
and t.start_time >= to_date('20060515', 'yyyymmdd')
and t.start_time < to_date('20060522', 'yyyymmdd')
group by t.caller_manager, t.called_manager, to_char(t.start_time, 'yyyymmdd');



#select t.caller_manager, t.called_manager, to_char(t.start_time, 'yyyymmdd'), count(*)
#from bill_s_inter t where t.serv_key = 'SMS'
#and t.start_time >= to_date('20060516', 'yyyymmdd')
#and t.start_time < to_date('20060622', 'yyyymmdd')
#group by t.caller_manager, t.called_manager, to_char(t.start_time, 'yyyymmdd'); 
/

quit
!!

