#********************************************************
# This Program is used Transfer CC Interface Table Data  
# To Rating Custinfo.                                    
#********************************************************
. ~/.profile                                             
                                                         
                                                         
sqlplus -s prm/mmprm@boss <<!!                           
                                                         
set serveroutput on size 1000000

delete from  bill_s_inter where to_char( start_time,'yyyymm') <= '200608' and rownum<1000000;                        
commit;

/

quit
!!

