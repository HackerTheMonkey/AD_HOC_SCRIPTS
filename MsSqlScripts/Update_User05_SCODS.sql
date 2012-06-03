/*
	Update ServicePackageSnapshot
*/
select * from scods..ODSServicePackageSnapshot
--update scods..ODSServicePackageSnapshot set User05 = ActivationDate
where FeatureCode like '40-%' and SnapshotDate >= '08-01-2011';

/*
	Update ServicePackageDelta
*/
select * from scods..ODSServicePackageDelta
--update scods..ODSServicePackageSnapshot set User05 = ActivationDate
where FeatureCode like '40-%' and SnapshotDate >= '08-01-2011';

/*
	Update CustomerSnapshot
*/
select * from scods..ODSCustomerSnapshot
--update scods..ODSCustomerSnapshot set User05 = ActivationDate
where SalesPersonCode like '40-%' and SnapshotDate >= '08-01-2011';

/*
	Update the part of the data for which SalesPersonCode is null	
*/
select * from SCODS..ODSCustomerSnapshot
--update SCODS..ODSCustomerSnapshot set User05 = ActivationDate
where SalesPersonCode is null and BillingSubSystemId = '30' and RegionCode like '40-%' and SnapshotDate >= '08-01-2011';

-- make sure that there are no records with RegionCode being null
select COUNT(1) from SCODS..ODSCustomerSnapshot 
where SalesPersonCode is null and BillingSubSystemId = '30' and RegionCode is null and SnapshotDate >= '08-01-2011';


/*
	Update CustomerDelta
*/
select * from scods..ODSCustomerDelta
--update scods..ODSCustomerDelta set User05 = ActivationDate
where SalesPersonCode like '40-%' and SnapshotDate >= '08-01-2011';

/*
	Update the part of the data for which SalesPersonCode is null	
*/
select * from SCODS..ODSCustomerDelta
--update SCODS..ODSCustomerDelta set User05 = ActivationDate
where SalesPersonCode is null and BillingSubSystemId = '30' and RegionCode like '40-%' and SnapshotDate >= '08-01-2011';

-- make sure that there are no records with RegionCode being null
select COUNT(1) from SCODS..ODSCustomerDelta 
where SalesPersonCode is null and BillingSubSystemId = '30' and RegionCode is null and SnapshotDate >= '08-01-2011';

