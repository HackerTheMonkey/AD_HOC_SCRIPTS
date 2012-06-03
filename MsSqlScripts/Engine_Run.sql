--insert the CT or any other feeds loaded that you don’t want
--to run into a back up table 
 
insert into   scods..tmp_sh_OdsControlData_20120101InitBU
select ods.*
from scods..ODSControlData ods
left outer join scods..tmp_sh_OdsControlData_20120101InitBU bu
on bu.billingsubsystemid = ods.BillingSubSystemId
and bu.snapshotdate = ods.SnapshotDate
and bu.datafiletypeid = ods.DataFileTypeId
where
bu.snapshotdate is null
 
--delete the dates that are > the last day you want to run at that time
select * from scods..ODSControlData where SnapshotDate = '03-27-2012';
delete from scods..ODSControlData where SnapshotDate = '03-27-2012';
 
 
--insert records from the master backup table into scods
--to run the engine for those days
insert into   scods..ODSControlData
select bu.*
from scods..tmp_sh_OdsControlData_20120101InitBU bu
left outer join scods..ODSControlData ods
on bu.billingsubsystemid = ods.BillingSubSystemId
and bu.snapshotdate = ods.SnapshotDate
and bu.datafiletypeid = ods.DataFileTypeId
where
ods.SnapshotDate is null
and bu.snapshotdate between '02/18/2012' and '02/24/2012';

select max(SnapshotDate) from scods..ODSControlData;

/*
	Update the running flag if there is a need to resume
	the run after it fails.
*/
Update SCRules..ControlApplication
SET RunningFlag = 0
WHERE ApplicationID = 1 --subscriber 


/*
	Here is the script to kick-off the engine procedure
*/
USE [SCRules]
GO

DECLARE     @return_value int

EXEC  @return_value = [dbo].[CTL_LaunchSubscriber]

SELECT      'Return Value' = @return_value

Go