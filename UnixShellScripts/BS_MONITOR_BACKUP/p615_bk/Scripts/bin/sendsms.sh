sqlplus -s USRHASANEIN/billing@sendsms<<END
var sms_id number;
var error varchar2(100);
exec sendsms.send_single_sms('ASIACELL','$2','$2',0,1,5000,:sms_id,:error)
quit
END