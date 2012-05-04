#********************************************************
# This Program is used Transfer CC Interface Table Data
# To Rating Custinfo.
#********************************************************
. ~/.profile


sqlplus -s prm/mmprm@boss <<!! 

set serveroutput on size 1000000

select count(*) inter from bill_s_inter where to_char(start_time,'yyyymm') <='200611';
select count(*) spcp from bill_s_spcp where billingcycle_code='200611'; 
select count(*) idd from bill_s_idd where to_char(start_time,'yyyymm') <= '200611';
select count(*) roaming from bill_s_roaming where to_char(date_s,'yyyymm') <= '200611';

/

quit
!!
#sqlplus -s sendsms/sendsms123xx@sendsms<<END
#var sms_id number;
#var err varchar2(100);
#exec send_single_sms('PRM','9647701103622','count all script finshed',0,1,:sms_id,:err);
#quit
#END
