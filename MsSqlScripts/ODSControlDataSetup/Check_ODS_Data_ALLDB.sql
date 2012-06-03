declare @nSnapshotDate date;
declare @iCount int;
select @nSnapshotDate = '01-16-2012';

select @iCount = count(1) from [SCODS-RC]..ODSServicePackageDelta t where t.SnapshotDate = @nSnapshotDate;
print '[SCODS-RC]..ODSServicePackageDelta: ' + ltrim(str(@iCount));
select @iCount = count(1) from [SCODS-RC]..ODSServicePackageSnapshot t where t.SnapshotDate = @nSnapshotDate;
print '[SCODS-RC]..ODSServicePackageSnapshot: ' + ltrim(str(@iCount));
select @iCount = count(1) from [SCODS-RC]..ODSCustomerDelta t where t.SnapshotDate = @nSnapshotDate;
print '[SCODS-RC]..ODSCustomerDelta: ' + ltrim(str(@iCount));
select @iCount = count(1) from [SCODS-RC]..ODSCustomerSnapshot t where t.SnapshotDate = @nSnapshotDate;
print '[SCODS-RC]..ODSCustomerSnapshot: ' + ltrim(str(@iCount));

select @iCount = count(1) from [SCODS-EK]..ODSServicePackageDelta t where t.SnapshotDate = @nSnapshotDate;
print '[SCODS-EK]..ODSServicePackageDelta: ' + ltrim(str(@iCount));
select @iCount = count(1) from [SCODS-EK]..ODSServicePackageSnapshot t where t.SnapshotDate = @nSnapshotDate;
print '[SCODS-EK]..ODSServicePackageSnapshot: ' + ltrim(str(@iCount));
select @iCount = count(1) from [SCODS-EK]..ODSCustomerDelta t where t.SnapshotDate = @nSnapshotDate;
print '[SCODS-EK]..ODSCustomerDelta: ' + ltrim(str(@iCount));
select @iCount = count(1) from [SCODS-EK]..ODSCustomerSnapshot t where t.SnapshotDate = @nSnapshotDate;
print '[SCODS-EK]..ODSCustomerSnapshot: ' + ltrim(str(@iCount));

select @iCount = count(1) from [SCODS-CT]..ODSServicePackageDelta t where t.SnapshotDate = @nSnapshotDate;
print '[SCODS-CT]..ODSServicePackageDelta: ' + ltrim(str(@iCount));
select @iCount = count(1) from [SCODS-CT]..ODSServicePackageSnapshot t where t.SnapshotDate = @nSnapshotDate;
print '[SCODS-CT]..ODSServicePackageSnapshot: ' + ltrim(str(@iCount));
select @iCount = count(1) from [SCODS-CT]..ODSCustomerDelta t where t.SnapshotDate = @nSnapshotDate;
print '[SCODS-CT]..ODSCustomerDelta: ' + ltrim(str(@iCount));
select @iCount = count(1) from [SCODS-CT]..ODSCustomerSnapshot t where t.SnapshotDate = @nSnapshotDate;
print '[SCODS-CT]..ODSCustomerSnapshot: ' + ltrim(str(@iCount));



