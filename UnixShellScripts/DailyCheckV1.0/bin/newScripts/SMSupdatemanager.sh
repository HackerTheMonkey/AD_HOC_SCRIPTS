#********************************************************
# This Program is used Transfer CC Interface Table Data
# To Rating Custinfo.
#********************************************************
. ~/.profile


sqlplus -s prm/mmprm@boss <<!! 

set serveroutput on size 1000000

begin
	
	update bill_s_inter t set t.called_manager='IRQAT' where t.toll_type = 'SMS' 
	and to_char(t.start_time,'yyyymmdd') >= '20060501' 
	and to_char(t.start_time,'yyyymmdd') < '20060601' 
	and (t.called like '07802%' or t.called like '07801%' or t.called like '07803%' );
	commit;
	
	update bill_s_inter t set t.called_manager='IRQOR' where t.toll_type = 'SMS' 
	and to_char(t.start_time,'yyyymmdd') >= '20060501' 
	and to_char(t.start_time,'yyyymmdd') <= '20060601' 
	and (t.called like '07901%' or t.called like '07902%' or t.called like '07903%' );
	commit;	

	update bill_s_inter t set t.called_manager='IRQAT' where t.toll_type = 'SMS' 
	and to_char(t.start_time,'yyyymmdd') >= '20060401' 
	and to_char(t.start_time,'yyyymmdd') < '20060501' 
	and (t.called like '07802%' or t.called like '07801%' or t.called like '07803%' );
	commit;
	
	update bill_s_inter t set t.called_manager='IRQOR' where t.toll_type = 'SMS' 
	and to_char(t.start_time,'yyyymmdd') >= '20060401' 
	and to_char(t.start_time,'yyyymmdd') <= '20060501' 
	and (t.called like '07901%' or t.called like '07902%' or t.called like '07903%' );
	commit;
	
	update bill_s_inter t set t.called_manager='IRQAT' where t.toll_type = 'SMS' 
	and to_char(t.start_time,'yyyymmdd') >= '20060601' 
	and to_char(t.start_time,'yyyymmdd') < '20060701' 
	and (t.called like '07802%' or t.called like '07801%' or t.called like '07803%' );
	commit;
	
	update bill_s_inter t set t.called_manager='IRQOR' where t.toll_type = 'SMS' 
	and to_char(t.start_time,'yyyymmdd') >= '20060601' 
	and to_char(t.start_time,'yyyymmdd') <= '20060701' 
	and (t.called like '07901%' or t.called like '07902%' or t.called like '07903%' );
	commit;	
end;
/

quit
!!

