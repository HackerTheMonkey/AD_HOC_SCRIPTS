-- To check if the engine running status
use [SCRules];
select t.RunningFlag from SCRules..ControlApplication t where t.ApplicationID = '1';

select * from vAuditRTProcessMessage t where t.ProcessID not in (520) order by t.MessageKey desc;

update scrules..ControlApplication set runningflag='0' where applicationid='1';

USE [SCRules];
GO
	DECLARE @returnValue INT;
GO
	--EXEC @returnValue = [dbo].[CTL_LaunchSubscriber];
	SET @returnValue = '100';
GO
	SELECT 'returnValue' = @returnValue
GO

select max(DateKey) from scrules..auditCTBatch where ApplicationId='1' and StatusID='6' group by batchid;

select ChangeDate from scrules..GlobalDateSmall where DateKey = (select max(DateKey) as "DateKey" from scrules..auditCTBatch where ApplicationId='1' and StatusID='6' group by batchid);