select * from CDR_SMSP2P200704;
select * from CDR_VOICE200704;

--incoming International SMS:
select count(cdrtype) "IDD_SMS_INCOMING_1" from CDR_SMSP2P200704 a where cdrtype='SMSMT' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum not like '770%' or othertelnum not like '964%');

select count(cdrtype) "IDD_SMS_INCOMING_2" from CDR_SMSP2P200705 a where cdrtype='SMSMT' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum not like '770%' or othertelnum not like '964%');

--outgoing International SMS:
select count(cdrtype) "IDD_SMS_OUTGOING_1" from CDR_SMSP2P200704 a where cdrtype='SMSMO' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum not like '770%' or othertelnum like '964%');

select count(cdrtype) "IDD_SMS_OUTGOING_2" from CDR_SMSP2P200705 a where cdrtype='SMSMO' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum not like '770%' or othertelnum like '964%');

--incoming SMS
select count(cdrtype) "SMS_INCOMING_1" from CDR_SMSP2P200704 a where cdrtype='SMSMT' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum like '770%' or othertelnum like '964%');

select count(cdrtype) "SMS_INCOMING_2" from CDR_SMSP2P200705 a where cdrtype='SMSMT' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum like '770%' or othertelnum like '964%');

--outgoing SMS
select count(cdrtype) "SMS_OUTGOING_1" from CDR_SMSP2P200704 a where cdrtype='SMSMO' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum like '770%' or othertelnum like '964%');

select count(cdrtype) "SMS_OUTGOING_2" from CDR_SMSP2P200705 a where cdrtype='SMSMO' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum like '770%' or othertelnum like '964%');

--incoming International VOICE:
select count(cdrtype) "IDD_VOICE_INCOMING_1" from CDR_VOICE200704 a where cdrtype='CSMTC' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum not like '770%' or othertelnum not like '964%');

select count(cdrtype) "IDD_VOICE_INCOMING_2" from CDR_VOICE200705 a where cdrtype='CSMTC' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum not like '770%' or othertelnum not like '964%');

--outgoing International VOICE:
select count(cdrtype) "IDD_VOICE_OUTGOING_1" from CDR_VOICE200704 a where cdrtype='CSMOC' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum not like '770%' or othertelnum not like '964%');

select count(cdrtype) "IDD_VOICE_OUTGOING_2" from CDR_VOICE200705 a where cdrtype='CSMOC' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum not like '770%' or othertelnum not like '964%');

--incoming VOICE
select count(cdrtype) "VOICE_INVOMING_1" from CDR_VOICE200704 a where cdrtype='CSMTC' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum like '770%' or othertelnum like '964%');

select count(cdrtype) "VOICE_INVOMING_2" from CDR_VOICE200705 a where cdrtype='CSMTC' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum like '770%' or othertelnum like '964%');

--outgoing VOICE
select count(cdrtype) "VOICE_OUTGOING_1" from CDR_VOICE200704 a where cdrtype='CSMOC' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum like '770%' or othertelnum like '964%');

select count(cdrtype) "VOICE_OUTGOING_2" from CDR_VOICE200705 a where cdrtype='CSMOC' and MSISDN like '770%' 
and  to_char(starttime,'yyyymm')='200704' and (othertelnum like '770%' or othertelnum like '964%');



