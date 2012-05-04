sqlplus -s "prm/mmprm@boss1"<<END
set serveroutput on size 1000000
select count(*) "No of Calls",trunkin,sum(h.occupy_timelong)/60 "No of Min" from bill_s_inter h group by h.trunkin;
END