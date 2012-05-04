. ~/.profile


sqlplus -s prm/mmprm@boss <<!! 

set serveroutput on size 1000000

	update bill_s_inter t set t.caller_manager='IRQAT' where t.toll_type = 'SMS' 
	and to_char(t.start_time,'yyyymmdd') >= '20060701' 
	and t.caller like '964780%'
	and t.caller_manager<>'IRQAT'
	and rownum<5000000;
	commit;

	update bill_s_inter t set t.caller_manager='IRQOR' where t.toll_type = 'SMS' 
	and to_char(t.start_time,'yyyymmdd') >= '20060701' 
	and  t.caller like '964790%'
	and t.caller_manager<>'IRQOR'
	and rownum<5000000;
	commit;
	
	update bill_s_inter t set t.caller_manager='IRQAC' where t.toll_type = 'SMS' 
	and to_char(t.start_time,'yyyymmdd') >= '20060701' 
	and  t.caller like '964770%'
	and t.caller_manager<>'IRQAC'
	and rownum<5000000;
	commit;
	
	delete from bill_s_inter t where t.toll_type = 'SMS'
	and to_char(t.start_time,'yyyymmdd') >= '20060601'
	and  t.caller like '964770%' and  t.called like '964770%';
	commit;
	
	delete from bill_s_inter t where t.toll_type = 'SMS'
	and to_char(t.start_time,'yyyymmdd') >= '20060601'
	and  t.caller like '964780%' and t.called like '964780%';
	commit;
	
	delete from bill_s_inter t where t.toll_type = 'SMS'
	and to_char(t.start_time,'yyyymmdd') >= '20060601'
	and  t.caller like '964790%' and t.called like '964790%';
	commit;		
	
/

quit
!!