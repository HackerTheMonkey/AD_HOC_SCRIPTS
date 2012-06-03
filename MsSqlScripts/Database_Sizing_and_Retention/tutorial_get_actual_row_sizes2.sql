
use [SCODS-CT];
/*
	Get a list if the biggest tables in this particular database
*/
select top 10 * from ODSServicePackageSnapshot;

select top 10 
	LoadDate, 
	datalength(LoadDate) "LoadDate_Size", 
	BillingSubSystemId,
	datalength(BillingSubSystemId) "BillingSubSystemID_Size", 
	AccountNumber,
	DATALENGTH(AccountNumber) "AccountNumber_Size",
	DATALENGTH(1)
from ODSServicePackageSnapshot;

exec sp_spaceused 'ODSServicePackageSnapshot';

select object_name(object_id), name, max_length, precision name from sys.all_columns t where OBJECT_NAME(object_id) = 'ODSServicePackageSnapshot';

/*
	59403064 KB
*/
with rowSizes as
(select
	isnull(datalength(LoadDate), 0) +
	isnull(datalength(ExtractDate), 0) +
	isnull(datalength(SnapshotDate), 0) +
	isnull(datalength(BillingSubSystemId), 0) +
	isnull(datalength(AccountNumber), 0) +
	isnull(datalength(ServiceNumber), 0) +
	isnull(datalength(FeatureNumber), 0) +
	isnull(datalength(CustomerId), 0) +
	isnull(datalength(StatusCode), 0) +
	isnull(datalength(Quantity), 0) +
	isnull(datalength(ActivatingReasonCode), 0) +
	isnull(datalength(ActivatingReasonTypeId), 0) +
	isnull(datalength(DeactivatingReasonCode), 0) +
	isnull(datalength(DeactivatingReasonTypeId), 0) +
	isnull(datalength(IsRevenueFlag), 0) +
	isnull(datalength(ActivationDate), 0) +
	isnull(datalength(DeactivationDate), 0) +
	isnull(datalength(SuspendDate), 0) +
	isnull(datalength(FeatureCode), 0) +
	isnull(datalength(SalesPersonCode), 0) +
	isnull(datalength(CSRCode), 0) +
	isnull(datalength(SegmentCode), 0) +
	isnull(datalength(RegionCode), 0) +
	isnull(datalength(EquipmentCode), 0) +
	isnull(datalength(CampaignCode), 0) +
	isnull(datalength(BundleCode), 0) +
	isnull(datalength(RatePlanCode), 0) +
	isnull(datalength(ChargeRate), 0) +
	isnull(datalength(RegulatedNonRegulatedFlag), 0) +
	isnull(datalength(CableNode), 0) +
	isnull(datalength(HeadEnd), 0) +
	isnull(datalength(PrizmCode), 0) +
	isnull(datalength(AccessLineTypeIndicator), 0) +
	isnull(datalength(User01), 0) +
	isnull(datalength(User02), 0) +
	isnull(datalength(User03), 0) +
	isnull(datalength(User04), 0) +
	isnull(datalength(User05), 0) +
	isnull(datalength(User06), 0) +
	isnull(datalength(User07), 0) +
	isnull(datalength(User08), 0) +
	isnull(datalength(User09), 0) +
	isnull(datalength(User10), 0) +
	isnull(datalength(User11), 0) +
	isnull(datalength(User12), 0) +
	isnull(datalength(User13), 0) +
	isnull(datalength(User14), 0) +
	isnull(datalength(User15), 0) +
	isnull(datalength(User16), 0) +
	isnull(datalength(User17), 0) +
	isnull(datalength(User18), 0) +
	isnull(datalength(User19), 0) +
	isnull(datalength(User20), 0) +
	isnull(datalength(User21), 0) +
	isnull(datalength(User22), 0) +
	isnull(datalength(User23), 0) +
	isnull(datalength(User24), 0) +
	isnull(datalength(User25), 0) as "RowSize",
	t.*
from [SCODS-CT]..ODSServicePackageSnapshot t
where t.SnapshotDate = '08-08-2011'
)
select SUM(RowSize)/1024/1024 from rowSizes;