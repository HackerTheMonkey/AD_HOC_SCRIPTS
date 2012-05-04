Select * From medi_ask_fail t Where t.order_time >= '30-AUG-08' And t.Order_Time < Sysdate;
Select * From medi_func;

Select func_code,ret_info,Count(*) From
(
Select b.func_code,a.msisdn,a.order_time,a.command,a.ret_info,a.ret_code From 
       medi_ask_fail a,
       medi_func b
Where 
      a.order_time >= '30-AUG-08' And
      a.Order_Time < Sysdate And
      b.func_id=a.func_id
) t Group By t.func_code,t.ret_info;

Select t.msisdn,t.imsi,func_code,ret_info,Count(*) From
(
Select b.func_code,a.imsi,a.msisdn,a.order_time,a.command,a.ret_info,a.ret_code From 
       medi_ask_fail a,
       medi_func b
Where 
      a.order_time >= '30-AUG-08' And
      a.Order_Time < Sysdate And
      b.func_id=a.func_id
) t 
Where t.ret_info='Subscriber not defined' And t.func_code='MODIMSI'
Group By t.msisdn,t.func_code,t.ret_info,t.imsi;