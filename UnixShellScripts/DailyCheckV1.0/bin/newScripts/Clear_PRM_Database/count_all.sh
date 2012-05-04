#********************************************************
# This Program is used Transfer CC Interface Table Data
# To Rating Custinfo.
#********************************************************
. ~/.profile


sqlplus -s prm/mmprm@boss <<!! 

set serveroutput on size 1000000

select count(*) inter from bill_s_inter where to_char(start_time,'yyyymm') <='200604';
#select count(*) spcp from bill_s_spcp where billingcycle_code='200604'; 
#select count(*) idd from bill_s_idd where to_char(start_time,'yyyymm') <= '200604';
#select count(*) roaming from bill_s_roaming where to_char(date_s,'yyyymm') <= '200604';

/

quit
!!