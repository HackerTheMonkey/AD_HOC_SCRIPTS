#********************************************************
# This Program is used Transfer CC Interface Table Data
# To Rating Custinfo.
#********************************************************
. ~/.profile


sqlplus -s prm/mmprm@boss <<!! 

set serveroutput on size 1000000

select to_char(t.start_time,'yyyymmdd'),count(*) from bill_s_inter t 
where to_char(t.start_time,'yyyymmdd')>='20060810' 
and to_char(t.start_time,'yyyymmdd')<='20060815'
and (t.trunkin_manager='EDJV' or t.trunkout_manager='EDJV')
group by to_char(t.start_time,'yyyymmdd');

                                                        
	
															
	        												
/

quit
!!

