-- Check all the SCODS-CT schema for any data prior to AUG-2011
declare @iRowCount int;
begin
	print '-----------------------------------------------------------------------------------------------------------------';
	
	-- Check the SCODS-CT tables
	select @iRowCount = (select COUNT(1) from [SCODS-CT]..ODSCustomerDelta t where t.SnapshotDate < '08-01-2011');
	print '[SCODS-CT]..ODSCustomerDelta: ' + cast(@iRowCount as varchar);
	select @iRowCount = (select COUNT(1) from [SCODS-CT]..ODSCustomerSnapshot t where t.SnapshotDate < '08-01-2011');
	print '[SCODS-CT]..ODSCustomerSnapshot: ' + cast(@iRowCount as varchar);
	select @iRowCount = (select COUNT(1) from [SCODS-CT]..ODSServicePackageDelta t where t.SnapshotDate < '08-01-2011');
	print '[SCODS-CT]..ODSServicePackageDelta: ' + cast(@iRowCount as varchar);
	select @iRowCount = (select COUNT(1) from [SCODS-CT]..ODSServicePackageSnapshot t where t.SnapshotDate < '08-01-2011');
	print '[SCODS-CT]..ODSServicePackageSnapshot: ' + cast(@iRowCount as varchar);
	
	print '-----------------------------------------------------------------------------------------------------------------';
	
	-- Check the SCODS-RC tables
	select @iRowCount = (select COUNT(1) from [SCODS-RC]..ODSCustomerDelta t where t.SnapshotDate < '08-01-2011');
	print '[SCODS-RC]..ODSCustomerDelta: ' + cast(@iRowCount as varchar);
	select @iRowCount = (select COUNT(1) from [SCODS-RC]..ODSCustomerSnapshot t where t.SnapshotDate < '08-01-2011');
	print '[SCODS-RC]..ODSCustomerSnapshot: ' + cast(@iRowCount as varchar);
	select @iRowCount = (select COUNT(1) from [SCODS-RC]..ODSServicePackageDelta t where t.SnapshotDate < '08-01-2011');
	print '[SCODS-RC]..ODSServicePackageDelta: ' + cast(@iRowCount as varchar);
	select @iRowCount = (select COUNT(1) from [SCODS-RC]..ODSServicePackageSnapshot t where t.SnapshotDate < '08-01-2011');
	print '[SCODS-RC]..ODSServicePackageSnapshot: ' + cast(@iRowCount as varchar);
	
	print '-----------------------------------------------------------------------------------------------------------------';
	
	-- Check the SCODS-EK tables
	select @iRowCount = (select COUNT(1) from [SCODS-EK]..ODSCustomerDelta t where t.SnapshotDate < '08-01-2011');
	print '[SCODS-EK]..ODSCustomerDelta: ' + cast(@iRowCount as varchar);
	select @iRowCount = (select COUNT(1) from [SCODS-EK]..ODSCustomerSnapshot t where t.SnapshotDate < '08-01-2011');
	print '[SCODS-EK]..ODSCustomerSnapshot: ' + cast(@iRowCount as varchar);
	select @iRowCount = (select COUNT(1) from [SCODS-EK]..ODSServicePackageDelta t where t.SnapshotDate < '08-01-2011');
	print '[SCODS-EK]..ODSServicePackageDelta: ' + cast(@iRowCount as varchar);
	select @iRowCount = (select COUNT(1) from [SCODS-EK]..ODSServicePackageSnapshot t where t.SnapshotDate < '08-01-2011');
	print '[SCODS-EK]..ODSServicePackageSnapshot: ' + cast(@iRowCount as varchar);
	
end;