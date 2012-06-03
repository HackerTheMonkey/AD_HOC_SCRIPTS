declare @dODSSnapshotDate date;
declare @deleteFromDate date;
declare @deleteToDate = date;

set @deleteFromDate = '07-01-2011';-- mm-dd-yyyy
set @deleteToDate = '07-31-2011';-- mm-dd-yyyy

set @dODSSnapshotDate = @deleteFromDate;

while @dODSSnapshotDate <= @deleteToDate
begin
	/*
		Write the deletion code in here.
	*/
	set @dODSSnapshotDate = dateadd(dd, 1, @dODSSnapshotDate);
end