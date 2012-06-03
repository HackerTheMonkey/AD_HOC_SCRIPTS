
--1) Backup the current outlier codes

select b.BillingSubSystemId, b.UserCode, b.UserKey01, b.UserKey02, b.UserKey03, b.UserKey04, b.UserKey05, b.DimensionId, a.*
--into scrules..tmp_outlier_codes_bak_d5
from scrules..DimUserFactInstance a inner join scrules..DimUserFactKey b 
on a.UserFactKey = b.UserFactKey where a.LongName = 'New Promotion Code' and b.DimensionId='5';

--2) Backup the dimension key prior to the deletion
/*
	Backup & Delete the SCRULES..DimUserInstanceLevel
*/
select c.BillingSubSystemId, a.* into scload..tmp_hk_DimUserInstanceLevel_d5 from scrules..DimUserInstanceLevel a
inner join scrules..DimUserFactInstance b on a.UserKey = b.UserKey
inner join scrules..DimUserFactKey c on b.UserFactKey = c.UserFactKey
where b.DimensionKey = '7';

delete from a
from scrules..DimUserInstanceLevel a
inner join scrules..DimUserFactInstance b on a.UserKey = b.UserKey
inner join scrules..DimUserFactKey c on b.UserFactKey = c.UserFactKey
where b.DimensionKey = '7';
/*
	Backup and delete the SCRULES..DIMUserFactInstance
*/
select b.BillingSubSystemId, a.* into scload..tmp_hk_DimUserFactInstance_d5 from scrules..DimUserFactInstance a
inner join SCRules..DimUserFactKey b on a.UserFactKey = b.UserFactKey
where a.DimensionKey = '7';

delete from a
from scrules..DimUserFactInstance a
inner join SCRules..DimUserFactKey b on a.UserFactKey = b.UserFactKey
where a.DimensionKey = '7';
/*
	Backup and Delete from SCRULES..DIMUserFactKey
*/
select a.* into scload..tmp_hk_DimUserFactKey_d5 from scrules..DimUserFactKey a
left outer join scrules..DimUserFactInstance b on a.UserFactKey = b.UserFactKey
where a.DimensionId = 7 /*and b.LongName is null*/;

delete from a
from scrules..DimUserFactKey a
left outer join scrules..DimUserFactInstance b on a.UserFactKey = b.UserFactKey
where a.DimensionId = 7 and b.LongName is null;
/*
	Backup and Delete from SCRULES..DimUserLevelParent
*/
select * into scload..tmp_hk_DimUserLevelParent from scrules..DimUserLevelParent a where a.DimensionKey = '7';

delete from a
from scrules..DimUserLevelParent a where a.DimensionKey = '7';	

/*
	Backup and Delete from the SCRULES..DimUserLevel
*/
select * into scload..tmp_hk_DimUserLevel_d5 from scrules..DimUserLevel t where t.DimensionId = '7';

delete from t from scrules..DimUserLevel t where t.DimensionId = '7';

--3) Load all the data sent by blizo into the engine, i.e. region/code/level
/*
	Load the region dimension levels into the scrules..DimUserLoadLevels
*/
insert into scrules..DimUserLoadLevels select * from scload..LoadRegionLevels;
/*
	Load the region dimension codes into the scrules..DimUserLoadCodes	
*/
insert into scrules..DimUserLoadCodes select * from scload..LoadRegionCodes;
/*
	Load the region dimension heirarchies
*/
insert into scrules..DimUserLoadHierarchy select * from SCLoad..LoadRegionHierarchies;
/*
	re-insert the outlier codes
*/
insert into scrules..DimUserLoadCodes select * from scrules..tmp_outlier_codes_bak_d7;