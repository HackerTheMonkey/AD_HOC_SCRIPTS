#********************************************************
# This Program is used Transfer CC Interface Table Data
# To Rating Custinfo.
#********************************************************
. ~/.profile


sqlplus -s prm/mmprm@boss <<!! 

set serveroutput on size 1000000


	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;		
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;				
	
	
	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'	
	and rownum< 1000000;
	commit;

	delete bill_s_inter t 
	where (t.caller like '9647702%' or t.caller like '9647703%' or t.caller like '9647704%' or t.caller like '9647701%')
	and (t.called like '9647702%' or t.called like '9647703%' or t.called like '9647704%' or t.called like '9647701%')
	and t.toll_type = 'SMS'
	and rownum< 1000000;
	commit;															
/

quit
!!
