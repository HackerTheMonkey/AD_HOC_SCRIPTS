-- Check the duplicate levels
select COUNT(*) from scrules..tmp_DimUserLoadLevels_stg;
select distinct LevelLongName, LevelTypeId from scrules..tmp_DimUserLoadLevels_stg;
/*
	Locate the normal identical duplicate LongLevelNames in the scrules..tmp_DimUserLoadLevels_stg and remove them
*/
select * from scrules..tmp_DimUserLoadLevels_stg2;
/*
	Save the identical duplicates in a table for later reference
*/
select * into scrules..tmp_DimUserLoadLevels_dups from scrules..tmp_DimUserLoadLevels_stg2 where ROW_NUMBER >1;
select * from scrules..tmp_DimUserLoadLevels_dups;
/*
	Delete the identical duplicates
*/
delete from scrules..tmp_DimUserLoadLevels_stg2 where ROW_NUMBER > 1;
/*
	Check the LevelLongName & LevelTypeId duplicates
*/
select row_number() over (partition by LevelLongName order by LevelLongName) as "row_number",t.* into scrules..tmp_DimUserLoadLevels_stg3 from scrules..tmp_DimUserLoadLevels_stg2 t;
drop table scrules..tmp_DimUserLoadLevels_stg2;
select * from scrules..tmp_DimUserLoadLevels_stg3 t where t.row_number > 1;
/*
	Get the outlier level information, the old and the new ones
*/
select * from scrules..tmp_DimUserLoadLevels_stg3 t where t.LevelLongName='Other';
/*
	Get the old information from the backup tables in regard to the LevelTypeId of the LevelLongName "Other"
*/
select * from scload..tmp_hk_DimUserLevel_d5 where LevelLongName='Other';
/*
	Delete the Level with the LevelTypeId of 2 as this is the old value in the system, though we need to check the rest
	of the levels who were childs of that level, what is going to happen to them after this level became a 3rd-layer level
	
	Here we also need to insert the duplicated code into the scrules..tmp_DimUserLoadLevels_dups table for later reference
*/
select * from scrules..tmp_DimUserLoadLevels_stg3 where LevelLongName='Other' and LevelTypeId='2';
insert into scrules..tmp_DimUserLoadLevels_dups select * from scrules..tmp_DimUserLoadLevels_stg3 where LevelLongName='Other' and LevelTypeId='2';
delete from scrules..tmp_DimUserLoadLevels_stg3 where LevelLongName='Other' and LevelTypeId='2'
/*
	insert the corrected codes into the scrules..DimUserLoadLevels
*/
select * from scrules..DimUserLoadLevels;
insert into scrules..DimUserLoadLevels ([DimensionId]
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
      ,[LevelUser05]) select [DimensionId]
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
      ,[LevelUser05] from scrules..tmp_DimUserLoadLevels_stg3;
