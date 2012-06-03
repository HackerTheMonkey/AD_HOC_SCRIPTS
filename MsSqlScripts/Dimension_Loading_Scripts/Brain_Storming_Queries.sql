-- Get the number of the child levels
select COUNT(1) as "number_of_childs" from scrules..DimUserLevelParent;--1300
-- Get the number of the distinct parents
select COUNT(distinct t.ParentLevelId) as "distinct_parents" from scrules..DimUserLevelParent t;--341

-- Get the count of all the levels that we have defined into the system
/*
	This query tells us that parents could be childs and at the
	same time, childs could be parents so there is a multi-level
	hierarchy in here.
*/
with all_parents_childs as
(select distinct t.LevelId from scrules..DimUserLevelParent t
union all
select distinct ParentLevelId from scrules..DimUserLevelParent)
select COUNT(distinct LevelId) from all_parents_childs;
/*
	Get a list of all the childs that are at the same time are
	parents of some other childs, this proves that we have a multi
	level hierarichal system here	
*/
select distinct LevelId from scrules..DimUserLevelParent where LevelId in (select distinct ParentLevelId from scrules..DimUserLevelParent);--328

select distinct LevelId from scrules..DimUserLevelParent 
intersect 
select distinct ParentLevelId from scrules..DimUserLevelParent;--328
/*
	Get the top-layer levels, i.e. the levels that don't have
	any parents in the parent-child relationship table
*/
with top_layer_levels as
(select LevelId, LevelLongName from scrules..DimUserLevel 
where LevelId not in (select LevelId from scrules..DimUserLevelParent))
select * from top_layer_levels t where LOWER(t.LevelLongName) like '%promo%';
/*
	Here we need to get all the second-layer levels, which means that the levels
	that their immediate parents are the top-layer levels
*/
with 
	top_layer_levels as
		(select LevelId, LevelLongName from scrules..DimUserLevel where LevelId not in (select LevelId from scrules..DimUserLevelParent))
select b.LevelId, b.LevelLongName from scrules..DimUserLevelParent a inner join scrules..DimUserLevel b on a.LevelId = b.LevelId
where ParentLevelId in (select LevelId from top_layer_levels where LOWER(LevelLongName) like '%promo%');
/*
	Here we need to write a query that will output all of the 3 levels that we have in the
	User Codes mapping heirarchy, it should include the following columns:
	+ First_Level_ID
	+ First_Level_LongName
	+ Second_Level_ID
	+ Second_Level_LongName
	+ Third_Level_Id
	+ Third_Level_LongName
*/
with 
	first_layer_levels(FirstLevelId, FirstLevelLongName) as
	(
		select LevelId, LevelLongName from scrules..DimUserLevel a where a.LevelId not in (select LevelId from scrules..DimUserLevelParent)
	),
	second_layer_levels(SecondLevelId, SecondLevelLongName, SecondLevelParentId) as
	(
		select a.LevelId, LevelLongName, b.ParentLevelId from scrules..DimUserLevel a inner join scrules..DimUserLevelParent b
		on a.LevelId = b.LevelId where b.ParentLevelId in (select FirstLevelId from first_layer_levels)
	),
	third_layer_levels(ThirdLevelId, ThirdLevelLongName, ThirdLevelParentId) as
	(
		select a.LevelId, LevelLongName, b.ParentLevelId from scrules..DimUserLevel a inner join scrules..DimUserLevelParent b
		on a.LevelId = b.LevelId where b.ParentLevelId in (select SecondLevelId from second_layer_levels)		
	),
	fourth_layer_levels(FourthLevelId, FourthLevelLongName, FourthLevelParentId) as
	(
		select a.LevelId, LevelLongName, b.ParentLevelId from scrules..DimUserLevel a inner join scrules..DimUserLevelParent b
		on a.LevelId = b.LevelId where b.ParentLevelId in (select ThirdLevelId from third_layer_levels)		
	),
	fifth_layer_levels(FifthLevelId, FifthhLevelLongName, FifthLevelParentId) as
	(
		select a.LevelId, LevelLongName, b.ParentLevelId from scrules..DimUserLevel a inner join scrules..DimUserLevelParent b
		on a.LevelId = b.LevelId where b.ParentLevelId in (select FourthLevelId from fourth_layer_levels)		
	),
	sixth_layer_levels(SixthLevelId, SixthLevelLongName, SixthLevelParentId) as
	(
		select a.LevelId, LevelLongName, b.ParentLevelId from scrules..DimUserLevel a inner join scrules..DimUserLevelParent b
		on a.LevelId = b.LevelId where b.ParentLevelId in (select FifthLevelId from fifth_layer_levels)		
	)	
		
	select 
		a.FirstLevelLongName, b.SecondLevelLongName, c.ThirdLevelLongName, d.FourthLevelLongName, e.FifthhLevelLongName, f.SixthLevelLongName
	from
		first_layer_levels a
	full outer join
		second_layer_levels b
	on a.FirstLevelId = b.SecondLevelParentId
	full outer join
		third_layer_levels c
	on b.SecondLevelId = c.ThirdLevelParentId
	full outer join fourth_layer_levels d
	on c.ThirdLevelId = d.FourthLevelParentId
	full outer join fifth_layer_levels e
	on d.FourthLevelId = e.FifthLevelParentId
	full outer join sixth_layer_levels f
	on e.FifthLevelId = f.SixthLevelParentId
	where
		LOWER(a.FirstLevelLongName) like '%reg%'
		--and c.ThirdLevelLongName is null
	;
/*
	Get the distinct types of the first-layer levels
*/                                                                                                                                                     
select distinct LevelTypeId from scrules..DimUserLevel a where a.LevelId not in (select LevelId from scrules..DimUserLevelParent);
/*
	Get the distinct level types for all the second-layer levels
*/
select distinct LevelTypeId from scrules..DimUserLevel a inner join scrules..DimUserLevelParent b
on a.LevelId = b.LevelId where b.ParentLevelId in (select LevelId from scrules..DimUserLevel a where a.LevelId not in (select LevelId from scrules..DimUserLevelParent));
/*
	Get the distinct level types of all the third-layer levels
*/
select distinct a.LevelTypeId from scrules..DimUserLevel a inner join scrules..DimUserLevelParent b
on a.LevelId = b.LevelId where b.ParentLevelId in (
select a.LevelId from scrules..DimUserLevel a inner join scrules..DimUserLevelParent b
on a.LevelId = b.LevelId where b.ParentLevelId in (select LevelId from scrules..DimUserLevel a where a.LevelId not in (select LevelId from scrules..DimUserLevelParent))
);
/*
	Get all of the codes that are defined into the system and their levels.
*/
select DimensionId, DimensionName, UserCode, t.UserLongName as "UserCodeLongName", Gen01LongName as "FirstLevelLongName", Gen02LongName as "SecondLevelLongName", Gen03LongName as "ThirdLevelLongName" 
from scrules..DimUserReportingAllHistory t;
/*
	Here we need to discover the relation between the UserCodes, FactKeys and the FactKeyInstances as in whether the relation is
	one to many or a many to many relationship.
*/

/*
	When re-loading the Promotion Dimension Keys, we have to keep the outlier codes intact, we have two ways of
	finding the outlier codes, the following two queries should return back the same count otherwise we have a problem
	in the consistency of our data.
*/

-- First way
select COUNT(1) from scrules..DimUserReportingAllHistory t where t.DimensionId = '5' and UserLongName like 'New Promotion Code' and Gen02LongName like 'Unmapped%';
-- Second Way
select COUNT(2) from scrules..DimUserFactInstance a inner join scrules..DimUserFactKey b on a.UserFactKey = b.UserFactKey where a.LongName like 'New%' and b.DimensionId='5';

/*
	Here are the steps that we should follow when refreshing (reloading) a particular
	User Dimension, here we are reloading the Promotion Dimensions (Levels, Hierarchies and Codes)
*/

--1) Backup the current outlier codes

select b.BillingSubSystemId, b.UserCode, b.UserKey01, b.UserKey02, b.UserKey03, b.UserKey04, b.UserKey05, b.DimensionId, a.*
into scrules..tmp_outlier_codes_bak
from scrules..DimUserFactInstance a inner join scrules..DimUserFactKey b 
on a.UserFactKey = b.UserFactKey where a.LongName like 'New%' and b.DimensionId='5';

select * from scrules..tmp_outlier_codes_bak;

--2) Backup the dimension key prior to the deletion
/*
	Backup & Delete the SCRULES..DimUserInstanceLevel (restored)
*/
select c.BillingSubSystemId, a.* /*into scload..tmp_hk_DimUserInstanceLevel_d5*/ from scrules..DimUserInstanceLevel a
inner join scrules..DimUserFactInstance b on a.UserKey = b.UserKey
inner join scrules..DimUserFactKey c on b.UserFactKey = c.UserFactKey
where b.DimensionKey = '5';

delete from a
from scrules..DimUserInstanceLevel a
inner join scrules..DimUserFactInstance b on a.UserKey = b.UserKey
inner join scrules..DimUserFactKey c on b.UserFactKey = c.UserFactKey
where b.DimensionKey = '5';

/*
	Backup and delete the SCRULES..DIMUserFactInstance (restored)
*/
select b.BillingSubSystemId, a.* /*into scload..tmp_hk_DimUserFactInstance_d5*/ from scrules..DimUserFactInstance a
inner join SCRules..DimUserFactKey b on a.UserFactKey = b.UserFactKey
where a.DimensionKey = '5';

delete from a
from scrules..DimUserFactInstance a
inner join SCRules..DimUserFactKey b on a.UserFactKey = b.UserFactKey
where a.DimensionKey = '5';
/*
	Backup and Delete from SCRULES..DIMUserFactKey (restored)
*/
select a.* /*into scload..tmp_hk_DimUserFactKey_d5*/ from scrules..DimUserFactKey a
left outer join scrules..DimUserFactInstance b on a.UserFactKey = b.UserFactKey
where a.DimensionId = 5 /*and b.LongName is null*/;

delete from a
from scrules..DimUserFactKey a
left outer join scrules..DimUserFactInstance b on a.UserFactKey = b.UserFactKey
where a.DimensionId = 5 and b.LongName is null;


/*
	Backup and Delete from SCRULES..DimUserLevelParent (restored)
*/
select * /*into scload..tmp_hk_DimUserLevelParent*/ from scrules..DimUserLevelParent a where a.DimensionKey = '5';

delete from a
from scrules..DimUserLevelParent a where a.DimensionKey = '5';



/*
	Backup and Delete from the SCRULES..DimUserLevel (restored)
*/
select * /*into scload..tmp_hk_DimUserLevel_d5*/ from scrules..DimUserLevel t where t.DimensionId = '5';

delete from t
from scrules..DimUserLevel t where t.DimensionId = '5';