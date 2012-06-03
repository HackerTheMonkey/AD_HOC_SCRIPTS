/*
	Create a temp table as a staging area where duplicates are to be checked and corrected before
	inserting these codes into the scrules..DimUserLoadHierarchy
*/
select * into scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg1 from scrules..DimUserLoadHierarchy where 1=2;
/*
	Check for the identical duplicate codes
*/
select row_number() over (partition by LevelName, ParentLevelName order by LevelName, ParentLevelName) as "row_number", t.* into scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg2 from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg1 t;
drop table scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg1;
select * from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg2;
/*
	1- Backup the identical duplicates
	2- Remove the identical duplicates
*/
select * into scrules..tmp_hk_scrules_DimUserLoadHierarchy_dups from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg2 where row_number > 1;
delete from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg2 where row_number > 1;
/*
	Check the LevelName duplicates
*/
select row_number() over (partition by LevelName order by LevelName) as "row_num", t.* into scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg2 t;
drop table scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg2;
/*
	1- Backup the LevelName duplicates after comparision with the current settings
	2- Remove the LevelName duplicates by comparision
*/
select * from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 t where t.row_num > 1;
select * from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 t where t.LevelName = 'Summer2011 Smart+ Online';
select * from scload..tmp_hk_DimUserLevelParent t where t.LevelId = (select LevelId from scload..tmp_hk_DimUserLevel_d5 where LevelLongName like 'Summer2011 Smart+ Online');
select * from scload..tmp_hk_DimUserLevel_d5 where LevelId='7559';
select * from scrules..DimUserLoadLevels where LevelLongName='Other';



select * from scload..tmp_hk_DimUserLevelParent g
inner join scload..tmp_hk_DimUserLevel_d5 h on h.LevelId = g.parentLevelid
where LevelId = (select LevelId from scload..tmp_hk_DimUserLevel_d5 where LevelLongName='Autumn2011 Extra+');

/*
	backup list
	
*/

select * from scrules..tmp_hk_scrules_DimUserLoadHierarchy_dups t where t.DUplicationType like 'Level%';

insert into scrules..tmp_hk_scrules_DimUserLoadHierarchy_dups ([row_number],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],[DuplicationType])
select [row_num],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],'LevelDuplication' as "DuplicationType"
from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where row_num='2' and LevelName='Autumn2011 Extra+' and ParentLevelName='Extra+';

insert into  scrules..tmp_hk_scrules_DimUserLoadHierarchy_dups ([row_number],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],[DuplicationType])
select [row_num],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],'LevelDuplication' as "DuplicationType"
from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where row_num='2' and LevelName='Employees Smart+' and ParentLevelName='Smart+';
-- The following level didn't have any old parent that is currently loaded into the system, but its still duplicated 
--so we need to confirm which one of the mapping to go into the engine, so here we are including both levels as we can't decide which one to choose
insert into  scrules..tmp_hk_scrules_DimUserLoadHierarchy_dups ([row_number],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],[DuplicationType])
select [row_num],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],'LevelDuplication' as "DuplicationType"
from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where LevelName='Feb2011 DTV130';
-- For this level, there are three different mappings, I think it should be Adult but still need to confirm it
insert into  scrules..tmp_hk_scrules_DimUserLoadHierarchy_dups ([row_number],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],[DuplicationType])
select [row_num],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],'LevelDuplication' as "DuplicationType"
from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where LevelName='Other';

insert into  scrules..tmp_hk_scrules_DimUserLoadHierarchy_dups ([row_number],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],[DuplicationType])
select [row_num],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],'LevelDuplication' as "DuplicationType"
from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where row_num='2' and LevelName='Summer2011 Extra+ Online' and ParentLevelName='Extra+';

insert into  scrules..tmp_hk_scrules_DimUserLoadHierarchy_dups ([row_number],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],[DuplicationType])
select [row_num],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],'LevelDuplication' as "DuplicationType"
from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where row_num='2' and LevelName='Summer2011 Smart+ DSA' and ParentLevelName='Smart+';

insert into  scrules..tmp_hk_scrules_DimUserLoadHierarchy_dups ([row_number],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],[DuplicationType])
select [row_num],[DimensionId],[LevelName],[RollupId],[ParentLevelName],[StartDate],'LevelDuplication' as "DuplicationType"
from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where row_num='2' and LevelName='Summer2011 Smart+ Online' and ParentLevelName='Smart+';

/*
	Delete the duplicates
*/
delete
from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where row_num='2' and LevelName='Autumn2011 Extra+' and ParentLevelName='Extra+';

delete from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where row_num='2' and LevelName='Employees Smart+' and ParentLevelName='Smart+';
-- The following level didn't have any old parent that is currently loaded into the system, but its still duplicated 
--so we need to confirm which one of the mapping to go into the engine, so here we are including both levels as we can't decide which one to choose
delete
from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where LevelName='Feb2011 DTV130';
-- For this level, there are three different mappings, I think it should be Adult but still need to confirm it
delete from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where LevelName='Other';

delete from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where row_num='2' and LevelName='Summer2011 Extra+ Online' and ParentLevelName='Extra+';

delete from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where row_num='2' and LevelName='Summer2011 Smart+ DSA' and ParentLevelName='Smart+';

delete from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3 where row_num='2' and LevelName='Summer2011 Smart+ Online' and ParentLevelName='Smart+';

/*
	Check the table before final loading
*/
insert into scrules..DimUserLoadHierarchy
([DimensionId]
      ,[LevelName]
      ,[RollupId]
      ,[ParentLevelName]
      ,[StartDate])
select [DimensionId]
      ,[LevelName]
      ,[RollupId]
      ,[ParentLevelName]
      ,[StartDate] from scrules..tmp_hk_scrules_DimUserLoadHierarchy_stg3;
select * from scrules..DimUserLoadHierarchy;

select * from scrules..DimUserLoadCodes t where t.DimensionId='5' and len(rtrim(LevelLongName)) <len(LevelLongName);
update scrules..DimUserLoadCodes set LongName=LTRIM(LongName);
delete from scrules..DimUserLoadCodes where DimensionId='5';
select COUNT(1) from scrules..DimUserLoadCodes where DimensionId='5';