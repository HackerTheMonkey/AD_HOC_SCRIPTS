-- To check if the newly loaded codes that are marked as to_delete, analog or digital
-- existed before or they are completely new codes
With newcodes as
(
select BillCode from scload..tmp_hk_DimPrdLoadBillCodes_20120104 t 
where LOWER(t.ProductLevelLongName) like '%delete%' or LOWER(t.ProductLevelLongName) like '%analog%'
or LOWER(t.ProductLevelLongName) like '%digital%'
)
select 'SCODS-RC' as "DB_NAME", min(SnapshotDate) as "MinSnapshotDate", t.FeatureCode from [scods-rc]..ODSServicePackageSnapshot t 
where t.FeatureCode in (select * from newcodes) group by t.FeatureCode
union all
select 'SCODS-EK' as "DB_NAME", min(SnapshotDate) as "MinSnapshotDate", t.FeatureCode from [scods-ek]..ODSServicePackageSnapshot t 
where t.FeatureCode in (select * from newcodes) group by t.FeatureCode
union all
select 'SCODS-CT' as "DB_NAME", min(SnapshotDate) as "MinSnapshotDate", t.FeatureCode from [scods-ct]..ODSServicePackageSnapshot t 
where t.FeatureCode in (select * from newcodes) group by t.FeatureCode;

-- Get all the 36 codes that were existed before in the system and has been updated
-- during the bill codes loading at 4th JAN 2012
	with already_existed_codes as
	(select 'SCODS-RC' as "DB_NAME", min(SnapshotDate) as "MinSnapshotDate", t.FeatureCode from [scods-rc]..ODSServicePackageSnapshot t 
	where t.FeatureCode in (select BillCode from scload..tmp_hk_DimPrdLoadBillCodes_20120104) group by t.FeatureCode having min(SnapshotDate) < '01-04-2012'
	union all
	select 'SCODS-EK' as "DB_NAME", min(SnapshotDate) as "MinSnapshotDate", t.FeatureCode from [scods-ek]..ODSServicePackageSnapshot t 
	where t.FeatureCode in (select BillCode from scload..tmp_hk_DimPrdLoadBillCodes_20120104) group by t.FeatureCode having min(SnapshotDate) < '01-04-2012')
	select * from already_existed_codes t order by t.MinSnapshotDate desc;
--union all
--select 'SCODS-CT' as "DB_NAME", min(SnapshotDate) as "MinSnapshotDate", t.FeatureCode from [scods-ct]..ODSServicePackageSnapshot t 
--where t.FeatureCode in (select BillCode from scload..tmp_hk_DimPrdLoadBillCodes_20120104) group by t.FeatureCode having min(SnapshotDate) < '01-04-2012';