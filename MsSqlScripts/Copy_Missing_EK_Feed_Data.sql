/*
	backup the EK data import tables
*/
select * into  [SCODS-EK]..tmp_odscustomerimport_bak_20100120 from [SCODS-EK]..odscustomerimport
select * into  [SCODS-EK]..tmp_ODSServicePackageImport_bak_20100120 from [SCODS-EK]..ODSServicePackageImport
select * into  [SCODS-EK]..tmp_ODSCampaignMapping_bak_20100120 from [SCODS-EK]..ODSCampaignMapping
select * into  [SCODS-EK]..tmp_ODSFeatureMapping_bak_20100120 from [SCODS-EK]..ODSFeatureMapping
select * into  [SCODS-EK]..tmp_ODSRatePlanMapping_bak_20100120 from [SCODS-EK]..ODSRatePlanMapping


select count(1) from [SCODS-EK]..odscustomerimport;
select COUNT(1) from [SCODS-EK]..tmp_odscustomerimport_bak_20100120;

select COUNT(1) from [SCODS-EK]..ODSServicePackageImport;
select count(1) from [SCODS-EK]..tmp_ODSServicePackageImport_bak_20100120

select COUNT(1) from [SCODS-EK]..ODSCampaignMapping;
select COUNT(1) from [SCODS-EK]..tmp_ODSCampaignMapping_bak_20100120;

select COUNT(1) from [SCODS-EK]..ODSFeatureMapping;
select COUNT(1) from [SCODS-EK]..tmp_ODSFeatureMapping_bak_20100120;

select COUNT(1) from [SCODS-EK]..ODSRatePlanMapping;
select COUNT(1) from [SCODS-EK]..tmp_ODSRatePlanMapping_bak_20100120;

/*
	Insert the missing EK data into the ODSServicePackageSnapshot
*/
select COUNT(1) from
(select * from [SCODS-EK]..ODSServicePackageImport except select * from [SCODS-EK]..tmp_ODSServicePackageImport_bak_20100120) a;

select COUNT(1) from [SCODS-EK]..ODSServicePackageSnapshot where SnapshotDate = '01-19-2012';--980,300 (old), 1,044,565 (new)
select COUNT(1) from [SCODS-EK]..tmp_ODSServicePackageImport_bak_20100120;

insert into [SCODS-EK]..ODSServicePackageSnapshot 
	select * from [SCODS-EK]..ODSServicePackageImport except select * from [SCODS-EK]..tmp_ODSServicePackageImport_bak_20100120;
	
/*
	Insert the missing EK data into the ODSCustomerSnapshot
*/
select COUNT(1) from
(select * from [SCODS-EK]..ODSCustomerImport except select * from [SCODS-EK]..tmp_odscustomerimport_bak_20100120) a;-- 36,646 (diff)

select COUNT(1) from [SCODS-EK]..ODSCustomerSnapshot where SnapshotDate = '01-19-2012';--517,453 (old), 1,044,565 (new)
select COUNT(1) from [SCODS-EK]..tmp_ODSCustomerImport_bak_20100120;

insert into [SCODS-EK]..ODSCustomerSnapshot 
	select * from [SCODS-EK]..ODSCustomerImport except select * from [SCODS-EK]..tmp_ODSCustomerImport_bak_20100120;