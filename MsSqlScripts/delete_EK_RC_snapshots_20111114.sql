-- Delete the snapshot data for RC for the 14-NOV-2011
delete from [scods-rc]..[ODSservicepackageSnapshot] where cast(snapshotdate as date) = '2011-12-15';
delete from [scods-rc]..[ODSCustomerSnapshot] where cast(snapshotdate as date) = '2011-12-15';
-- Delete the snapshot data for EK for the 14-NOV-2011
delete from [scods-ek]..[ODSservicepackageSnapshot] where cast(snapshotdate as date) = '2011-11-23';
delete from [scods-ek]..[ODSCustomerSnapshot] where cast(snapshotdate as date) = '2011-11-23';
-- Delete the snapshot data for CT for the 23-NOV-2011
delete from [scods-ct]..[ODSservicepackageSnapshot] where cast(snapshotdate as date) = '2011-11-23';
delete from [scods-ct]..[ODSCustomerSnapshot] where cast(snapshotdate as date) = '2011-11-23';


for file in "$(find . -type f | grep -v svn | grep Procedure)"
do
	grep -il "ODSservicepackageSnapshot" "$(echo "$file")"
done

declare @dSnapshotDate date;
select @dSnapshotDate = '12-15-2011';
-- Get the count for the RC snapshots
GO
use [SCODS-RC];
GO
select COUNT(1) from [SCODS-RC]..ODSServicePackageSnapshot t where t.SnapshotDate = @dSnapshotDate;