#!/usr/bin/ksh
has1=`rexec p650_db1 df -mvg|grep /ora91log|awk '{print $5}'`
has2=`rexec p650_db2 df -mvg|grep /ora92log|awk '{print $5}'`

has3="'""DB1 log is "$has1" ""DB2 log is "$has2"'"


sqlplus -s sendsms/sendsms123xx@sendsms<<END
var sms_id number;
var error varchar2(100);
exec send_single_sms('Conn. Check','9647701103622',$has3,0,1,:sms_id,:error);
quit
END