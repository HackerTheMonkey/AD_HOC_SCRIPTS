/*
	This script is used to load the new region dimensions as an incremental update
	to the already existing data, in this particular instance we are going to only load
	the differences between the load and the engine tables as we don't need them all.
*/

/*
	STEP 01: LOAD THE NEW LEVELS
*/
truncate table scrules..DimUserLoadLevels;

insert into scrules..DimUserLoadLevels
(      [DimensionId]
      ,[LevelLongName]
      ,[LevelTypeId]
      ,[LevelCode]
      ,[LevelShortName]
      ,[LevelSortOrder]
      ,[RevCountFlag]
      ,[UnitCountFlag]
      ,[InsertDefaultFlag]
      ,[LevelUser01]
      ,[LevelUser02]
      ,[LevelUser03]
      ,[LevelUser04]
      ,[LevelUser05])
select 
	   '7' as DimensionId
      ,[LevelLongName]
      ,[LevelTypeId]
      ,[LevelCode]
      ,[LevelShortName]
      ,[LevelSortOrder]
      ,[RevCountFlag]
      ,[UnitCountFlag]
      ,[InsertDefaultFlag]
      ,[LevelUser01]
      ,[LevelUser02]
      ,[LevelUser03]
      ,[LevelUser04]
      ,[LevelUser05] from scload..LoadRegionLevels t 
where 
	t.LevelLongName not in (select LevelLongName from scrules..DimUserLevel);
	
/*
	STEP 02: LOAD THE NEW CODES
	Note: As these codes are already exist in the engine tables but they are updated, so
	here we are going to load them into the SCRULES load tables so when the engine runs it
	will update the existing records with the new information contained within these codes
*/	
truncate table scrules..DimUserLoadCodes;

insert into scrules..DimUserLoadCodes
	   ([DimensionId]
      ,[BillingSystemCode]
      ,[BillingSubSystemCode]
      ,[UserCode]
      ,[UserKey01]
      ,[UserKey02]
      ,[UserKey03]
      ,[UserKey04]
      ,[UserKey05]
      ,[StartDate]
      ,[RollupName]
      ,[ShortName]
      ,[LongName]
      ,[UnitCountFlag]
      ,[RevCountFlag]
      ,[LevelLongName]
      ,[User01]
      ,[User02]
      ,[User03]
      ,[User04]
      ,[User05]
      ,[User06]
      ,[User07]
      ,[User08]
      ,[User09]
      ,[User10]) 
select '7' as "DimensionId"
      ,[BillingSystemCode]
      ,[BillingSubSystemCode]
      ,[Code] as "UserCode"
      ,[UserKey01]
      ,[UserKey02]
      ,[UserKey03]
      ,[UserKey04]
      ,[UserKey05]
      ,[StartDate]
      ,[RollupName]
      ,[ShortName]
      ,[LongName]
      ,[UnitCountFlag]
      ,[RevCountFlag]
      ,[LevelLongName]
      ,[User01]
      ,[User02]
      ,[User03]
      ,[User04]
      ,[User05]
      ,[User06]
      ,[User07]
      ,[User08]
      ,[User09]
      ,[User10] 
from scload..LoadRegionCodes t;

select * from scload..LoadRegionCodes;

/*
	STEP 03: LOAD HIERARCHY
*/
truncate table scrules..DimUserLoadHierarchy;

with diff_region_hierarchies as
(select LevelName, ParentLevelName from scload..LoadRegionHierarchies t
except
select b.LevelLongName, c.LevelLongName  from scrules..DimUserLevelParent 
a inner join scrules..DimUserLevel b on a.LevelId = b.LevelId
inner join scrules..DimUserLevel c on a.ParentLevelId = c.LevelId)

insert into scrules..DimUserLoadHierarchy
	([DimensionId]
	,[LevelName]
	,[RollupId]
	,[ParentLevelName]
	,[StartDate])
select '7' as "DimensionId"
      ,[LevelName]
      ,[RollupId]
      ,[ParentLevelName]
      ,[StartDate] from scload..LoadRegionHierarchies t where t.LevelName in (select LevelName from diff_region_hierarchies)
and t.ParentLevelName in (select ParentLevelName from diff_region_hierarchies);


select * from SCRules..DimUserLoadLevels;
select * from scrules..DimUserLoadHierarchy;
select * from SCRules..DimUserLoadCodes;
