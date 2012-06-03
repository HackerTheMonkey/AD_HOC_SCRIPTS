/*
	This script is used to reload (refresh) a particular user dimension
*/
DECLARE @vDimensionId varchar;
select @vDimensionId = t.DimensionId from scrules..DimUserDimension t where t.DimensionName = 'Promotion';
/*
	STEP 001: Backup the outlier codes into a temporary table for later re-insertion
	
	Note: outlier codes are the codes that belong to a particular dimension and they considered
	to be "New Codes" and they are not attached to a final level but instead they are attached
	to an unmapped level
*/
select 
	b.BillingSubSystemId, 
	b.UserCode, 
	b.UserKey01, 
	b.UserKey02, 
	b.UserKey03, 
	b.UserKey04, 
	b.UserKey05, 
	b.DimensionId, 
	a.*
into scrules..tmp_outlier_codes_bak_d5
from 
	scrules..DimUserFactInstance a 
inner join 
	scrules..DimUserFactKey b 
on 
	a.UserFactKey = b.UserFactKey 
where 
	a.LongName = 'New Promotion Code' 
	and b.DimensionId = @vDimensionId;
	
/*
	STEP 02: Delete all the levels and the hierarchies from the SCRULES tables as these are going to
	be reloaded once again from the data that will be populated in the SCRULES load tables.
	
	Note: The data need to be backed up prior to the deletion
*/


/*
	Backup & Delete the SCRULES..DimUserInstanceLevel
*/
select 
	c.BillingSubSystemId, 
	a.* 
--into scload..tmp_hk_DimUserInstanceLevel_d5
from 
	scrules..DimUserInstanceLevel a
inner join	
	scrules..DimUserFactInstance b on a.UserKey = b.UserKey
inner join 
	scrules..DimUserFactKey c on b.UserFactKey = c.UserFactKey
where 
	b.DimensionKey = @vDimensionId;


delete from a
from 
	scrules..DimUserInstanceLevel a
inner join 
	scrules..DimUserFactInstance b 
on 
	a.UserKey = b.UserKey
inner join 
	scrules..DimUserFactKey c 
on 
	b.UserFactKey = c.UserFactKey
where 
	b.DimensionKey = @vDimensionId;

/*
	Backup and delete the SCRULES..DIMUserFactInstance
*/
select 
	b.BillingSubSystemId, 
	a.* 
--into scload..tmp_hk_DimUserFactInstance_d5 
from 
	scrules..DimUserFactInstance a
inner join 
	SCRules..DimUserFactKey b 
on 
	a.UserFactKey = b.UserFactKey
where 
	a.DimensionKey = @vDimensionId;

delete from a
from 
	scrules..DimUserFactInstance a
inner join 
	SCRules..DimUserFactKey b 
on 
	a.UserFactKey = b.UserFactKey
where 
	a.DimensionKey = @vDimensionId;


/*
	Backup and Delete from SCRULES..DIMUserFactKey
*/
select 
	a.* 
--into scload..tmp_hk_DimUserFactKey_d5 
from 
	scrules..DimUserFactKey a
left outer join 
	scrules..DimUserFactInstance b 
on 
	a.UserFactKey = b.UserFactKey
where 
	a.DimensionId = @vDimensionId /*and b.LongName is null*/;

delete from a
from 
	scrules..DimUserFactKey a
left outer join 
	scrules..DimUserFactInstance b 
on 
	a.UserFactKey = b.UserFactKey
where 
	a.DimensionId = @vDimensionId and b.LongName is null;

/*
	Backup and Delete from SCRULES..DimUserLevelParent
*/
select * 
--into scload..tmp_hk_DimUserLevelParent 
from
	scrules..DimUserLevelParent a 
where 
	a.DimensionKey = @vDimensionId;

delete from a
from 
	scrules..DimUserLevelParent a 
where 
	a.DimensionKey = @vDimensionId;

/*
	Backup and Delete from the SCRULES..DimUserLevel
*/
select * 
--into scload..tmp_hk_DimUserLevel_d5 
from 
	scrules..DimUserLevel t 
where 
	t.DimensionId = @vDimensionId;

delete from t 
from 
	scrules..DimUserLevel t 
where 
	t.DimensionId = @vDimensionId;

/*
	STEP03: Reload all the data sent by blizoo into the SCRULES load tables
*/

/*
	Load the promotion dimension levels into the scrules..DimUserLoadLevels
*/
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','2Play','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','3Play','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Adult','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','ATV','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','ATVStart','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','business','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Discounts','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','DTV130','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','DTV40','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','DTV60','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','DTV80','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Extra','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Extra+','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','HBO','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','HDTV','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','HDTVlux','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','HDTVsport','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','HDTVworld','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Maxpack','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Net10','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Net15','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Net150','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Net24','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Net35','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Net50','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Other','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Premium','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Premium+','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Smart','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Smart+','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Start','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Start+','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Voice','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','WiFi','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','ATV ','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','DTV80 ','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Net150 ','2',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','MON','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2010 ATV','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2010 DTV40','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2010 DTV80 ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2010 Extra','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2010 Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2010 Premium ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2010 Premium+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2010 Smart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2010 Smart+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 2Play','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 3Play New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 ATVStart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 DTV130 New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 DTV130 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 DTV40 New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 DTV60','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 DTV60 New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 DTV60 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 DTV80','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 DTV80 New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 DTV80 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Extra','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Extra New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Extra Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Extra+ New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Extra+ Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 HBO 3x5','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 HDTV  3x5','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 HDTVlux 3x5','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 HDTVsport 3x5','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 HDTVworld 3x5','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net15','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net15 New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net15 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net150','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net24 New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net24 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net35','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net35 New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net35 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net50','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net50 New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net50 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Premium','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Premium New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Premium Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Smart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Smart New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Smart Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Smart+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Smart+ New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Smart+ Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Start','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Start New ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Start+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Birthday2011 3Play','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Birthday2011 Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Birthday2011 Net10','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Birthday2011 Net15','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Birthday2011 Net24','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Birthday2011 Net35','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Birthday2011 Smart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Birthday2011 Start','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo 2Play','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo 3Play','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo 3Play New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo Adult','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo Adult 3x5','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo ATV','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo Call100','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo CallFree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo DTV40','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo DTV60  ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo DTV80','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo HBO 4x6','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo HBO Old','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Blizoo HDTV 6mfree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo Net15','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo Net24','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo Net35','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo Net50','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo WiFi','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010 3Play','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010 ATV Petrich','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010 Call75','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010 DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010 DTV130 HD+HBO','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010 DTV130 HDTV','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010 DTV130 Old','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010 DTV40','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010 DTV80','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010 DTV80 Old','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HBO','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HBO 18mfree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HBO 24mfree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HBO 2mfree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HBO 3mfree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HBO 6mfree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HDTV 18mfree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HDTV 18mfree ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HDTV 2mfree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HDTV 6mfree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HDTVlux 18mfree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HDTVlux Employees','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HDTVsport ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HDTVsport 18mfree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HDTVsport Employees','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HDTVworld 18mfree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HDTVworld Employees','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2010 Extra ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2010 Extra Web50','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2010 Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2010 Premium','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2010 Premium+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2010 Smart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2010 Smart+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 2Play','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 DTV130 DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 DTV40','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 DTV60','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 DTV60 DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 DTV80','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Extra','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Net15','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Net150','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Net35','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Net50','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Smart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Smart DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Smart+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Start+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Disabled ATV','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','DTV130 SunnyBeach','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees 3Play','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees 3Play Adult','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees DTV60','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees DTV80','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees Extra','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees Extra ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees Premium','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees Premium ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees Smart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees Smart ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees Smart+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired 2Play','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired 3Play','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired ATV','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired CallFree','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired Maxpack','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired Net10','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired Net12','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired Net35','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired Net50','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2010 Premium+ Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 Extra','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 Extra Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 Extra+ Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 Premium','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 Premium Online ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 Premium+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 Smart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 Smart Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 Smart+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 Smart+ Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest DTV130 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest DTV40','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest DTV60','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest DTV60 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest DTV80','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest DTV80 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Extra','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Extra 3x50','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Extra Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Net15 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Net24 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Net35 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Net50 Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Premium  ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Premium Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Smart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Smart Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','General Discounts','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Net15 SunnyBeach','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Partners ATV','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Partners DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Partners DTV80','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Partners Extra','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Partners Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Partners Premium','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Partners Premium+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Partners Smart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Partners Smart+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK 3Play','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK ATV','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK DTV40','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK DTV60','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK DTV80','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK Extra','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK HBO','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK Net15','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK Net24','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK Net35','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK Net50','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK Premium','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK Smart ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo 2Play','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo Addict','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo DTV130 ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo DTV60','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo DTV80','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo Magnetic','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo Net20','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo Net40','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo Net60','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo Plan150','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo Plan26','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo Plan70','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo POTS','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 DTV130 Loyal','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 DTV60','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 DTV80','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Extra','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Extra ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Extra DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Extra Loyal','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Extra Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Extra+ DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Extra+ Loyal','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Extra+ Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Net15','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Net24','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Net35','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Premium','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Premium ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Premium DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Premium Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Smart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Smart DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Smart Loyal','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Smart Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Smart+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Smart+ DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Smart+ Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Start','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Start DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SunnyBeach ATV ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Other','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','VIP','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employee','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Extra DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Extra+ DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Start+ DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Smart+ DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 DTV80 DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 (ATV+FV)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Speed DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK DTV80 ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Net24 ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Blizoo Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest DTV60 ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest DTV60 Online ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest DTV80 ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest DTV80 Online ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 DTV130 ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo ATV ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Other ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo (ATV+FV)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo (DTV+FV)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Extra Online ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Start New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo DTV60','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Net15 Online ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Extra ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo Premium','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Premium Online ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Premium','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Premium Online ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK 3Play ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo Call75','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK ATVStart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','SoHo FV','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 (DTV+FV)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 Net24','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo HDTV','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo HBO ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 HBO','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Smart ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Start','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Premium','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011 LAN150','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired  DTV130 Old','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired  (ATV+BB)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Birthday2011  (ATV+BB)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo  (ATV+BB)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011  (BB+FV)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011  (BB+FV)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011  DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired  (DTV+BB) ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010  (DTV+FV)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010  (DTV+BB)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo  (DTV+BB)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011  ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010  (ATV+FV)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2011  2Play New','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 (BB+FV)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired (DTV+BB)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired (ATV+FV)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired (ATV+BB)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Expired 3Play  Old','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Premium DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','BLZ2010 3Play ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Disabled','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 DTV130 ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest DTV130 ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Autumn2010 DTV80','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HBO PZK','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HBO Christams2010','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HBO Christams2010DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Bonus HBO ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees Net50','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees Net50 ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Employees DTV130 ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK012012 DTV60','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK012012 DTV80','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK012012 DTV130','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK012012 (DTV+FV)','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK012012 Speed ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK012012 Start+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK012012 Smart+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Extra+ Online ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Christmas2011 Speed+ DSA','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK012012 Extra','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK012012 Start','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK012012 Smart','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK012012 Extra+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 DTV60 Loyal','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 DTV80 Loyal','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 Premium Loyal','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Summer2011 3Play Loyal','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','DTV80 SunnyBeach','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Net35 SunnyBeach','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','ATV SunnyBeach','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Net24 SunnyBeach','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Net50 SunnyBeach','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Net50SunnyBeach','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Feb2011 DTV80 ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo HDTV Group','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Extra+ Online ','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Extra+ 3x50','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Smart+','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','Fest Smart+ Online','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','PZK Smart +','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');
insert into scrules..DimUserLevel (DimensionId,LevelLongName,LevelTypeId,LevelCode,LevelShortName,LevelSortOrder,RevCountFlag,UnitCountFlag,InsertDefaultFlag,LevelUser01,LevelUser02,LevelUser03,LevelUser04,LevelUser05) values ('5','blizoo HBO analog','3',NULL, NULL,'1','1','1','0','0','0','0','0','0');

/*
	Load the promotion dimension codes into the scrules..DimUserLoadCodes	
*/
-- Check the file named PromotionCodesLoading.sql as its too large to be included here
/*
	Load the promotion dimension heirarchies
*/
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','2Play','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','3Play','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Adult','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','ATV','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','ATVStart','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','business','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Discounts','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','DTV130','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','DTV40','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','DTV60','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','DTV80','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Extra','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Extra+','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','HBO','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','HDTV','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','HDTVlux','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','HDTVsport','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','HDTVworld','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Maxpack','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Net10','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Net15','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Net150','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Net24','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Net35','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Net50','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Other','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Premium','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Premium+','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Smart','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Smart+','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Start','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Start+','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Voice','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','WiFi','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','ATV ','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','DTV80 ','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Net150 ','1','All Promotion Codes', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 2Play','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo 2Play','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 2Play','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired 2Play','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 (ATV+FV)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo (ATV+FV)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo (DTV+FV)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 (DTV+FV)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired  DTV130 Old','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired  (ATV+BB)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Birthday2011  (ATV+BB)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo  (ATV+BB)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011  (BB+FV)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011  (BB+FV)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011  DSA','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired  (DTV+BB) ','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010  (DTV+FV)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010  (DTV+BB)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo  (DTV+BB)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011  ','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010  (ATV+FV)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011  2Play New','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 (BB+FV)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired (DTV+BB)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired (ATV+FV)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired (ATV+BB)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK012012 (DTV+FV)','1','2Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 3Play New','1','3Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Birthday2011 3Play','1','3Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo 3Play','1','3Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo 3Play New','1','3Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010 3Play','1','3Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees 3Play','1','3Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired 3Play','1','3Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK 3Play','1','3Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK 3Play ','1','3Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired 3Play  Old','1','3Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010 3Play ','1','3Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 3Play Loyal','1','3Play', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo Adult','1','Adult', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo Adult 3x5','1','Adult', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Other','1','Adult', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2010 ATV','1','ATV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo ATV','1','ATV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010 ATV Petrich','1','ATV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Disabled ATV','1','ATV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired ATV','1','ATV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Partners ATV','1','ATV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK ATV','1','ATV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SunnyBeach ATV ','1','ATV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','ATV SunnyBeach','1','ATV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 ATVStart','1','ATVStart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK ATVStart','1','ATVStart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo 2Play','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo Addict','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo DTV130 ','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo DTV60','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo DTV80','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo Magnetic','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo Net20','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo Net40','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo Net60','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo Plan150','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo Plan26','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo Plan70','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo POTS','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','SoHo FV','1','business', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','General Discounts','1','Discounts', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','VIP','1','Discounts', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employee','1','Discounts', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Disabled','1','Discounts', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 DTV130','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 DTV130 New','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 DTV130 Online','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo DTV130','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010 DTV130','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010 DTV130 HD+HBO','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010 DTV130 HDTV','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010 DTV130 Old','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 DTV130','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 DTV130 DSA','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','DTV130 SunnyBeach','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees DTV130','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired DTV130','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest DTV130','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest DTV130 Online','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Partners DTV130','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK DTV130','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 DTV130','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 DTV130 Loyal','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 DTV130 ','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 DTV130 ','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest DTV130 ','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus DTV130','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees DTV130 ','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK012012 DTV130','1','DTV130', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2010 DTV40','1','DTV40', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 DTV40 New','1','DTV40', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo DTV40','1','DTV40', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010 DTV40','1','DTV40', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 DTV40','1','DTV40', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest DTV40','1','DTV40', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK DTV40','1','DTV40', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 DTV60','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 DTV60 New','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 DTV60 Online','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo DTV60  ','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 DTV60','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 DTV60 DSA','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees DTV60','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest DTV60','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest DTV60 Online','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK DTV60','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 DTV60','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest DTV60 ','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest DTV60 Online ','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo DTV60','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK012012 DTV60','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 DTV60 Loyal','1','DTV60', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2010 DTV80 ','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 DTV80','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 DTV80 New','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 DTV80 Online','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo DTV80','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010 DTV80','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010 DTV80 Old','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 DTV80','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees DTV80','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest DTV80','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest DTV80 Online','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Partners DTV80','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK DTV80','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 DTV80','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 DTV80 DSA','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK DTV80 ','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest DTV80 ','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest DTV80 Online ','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2010 DTV80','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 DTV130','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK012012 DTV80','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 DTV80 Loyal','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','DTV80 SunnyBeach','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 DTV80 ','1','DTV80', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2010 Extra','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Extra','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Extra New','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Extra Online','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Extra+','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2010 Extra ','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2010 Extra Web50','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Extra','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees Extra','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees Extra ','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 Extra','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 Extra Online','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Extra','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Extra 3x50','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Extra Online','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Partners Extra','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK Extra','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Extra','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Extra ','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Extra DSA','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Extra Loyal','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Extra Online','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Extra+ Online','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Extra DSA','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Extra Online ','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Extra ','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK012012 Extra','1','Extra', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2010 Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Extra+ New','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Extra+ Online','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Birthday2011 Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2010 Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees 3Play Adult','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 Extra+ Online','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Partners Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Extra+ DSA','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Extra+ Loyal','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Extra+ Online','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Extra+ DSA','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Blizoo Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Extra+ Online ','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK012012 Extra+','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Extra+ Online ','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Extra+ 3x50','1','Extra+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 HBO 3x5','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo HBO 4x6','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo HBO Old','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HBO','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HBO 18mfree','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HBO 24mfree','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HBO 2mfree','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HBO 3mfree','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HBO 6mfree','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK HBO','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo HBO ','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 HBO','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HBO PZK','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HBO Christams2010','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HBO Christams2010DSA','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HBO ','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo HBO analog','1','HBO', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 HDTV  3x5','1','HDTV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Blizoo HDTV 6mfree','1','HDTV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HDTV 18mfree','1','HDTV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HDTV 18mfree ','1','HDTV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HDTV 2mfree','1','HDTV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HDTV 6mfree','1','HDTV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo HDTV','1','HDTV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo HDTV Group','1','HDTV', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 HDTVlux 3x5','1','HDTVlux', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HDTVlux 18mfree','1','HDTVlux', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HDTVlux Employees','1','HDTVlux', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 HDTVsport 3x5','1','HDTVsport', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HDTVsport ','1','HDTVsport', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HDTVsport 18mfree','1','HDTVsport', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HDTVsport Employees','1','HDTVsport', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 HDTVworld 3x5','1','HDTVworld', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HDTVworld 18mfree','1','HDTVworld', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Bonus HDTVworld Employees','1','HDTVworld', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired Maxpack','1','Maxpack', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Birthday2011 Net10','1','Net10', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired Net10','1','Net10', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net15','1','Net15', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net15 New','1','Net15', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net15 Online','1','Net15', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Birthday2011 Net15','1','Net15', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo Net15','1','Net15', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Net15','1','Net15', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired Net12','1','Net15', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Net15 Online','1','Net15', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Net15 SunnyBeach','1','Net15', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK Net15','1','Net15', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Net15','1','Net15', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Net15 Online ','1','Net15', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net150','1','Net150', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Net150','1','Net150', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net24 New','1','Net24', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net24 Online','1','Net24', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Birthday2011 Net24','1','Net24', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo Net24','1','Net24', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Net24 Online','1','Net24', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK Net24','1','Net24', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Net24','1','Net24', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Net24 ','1','Net24', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net24','1','Net24', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Net24 SunnyBeach','1','Net24', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net35','1','Net35', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net35 New','1','Net35', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net35 Online','1','Net35', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Birthday2011 Net35','1','Net35', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo Net35','1','Net35', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Net35','1','Net35', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired Net35','1','Net35', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Net35 Online','1','Net35', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK Net35','1','Net35', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Net35','1','Net35', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Net35 SunnyBeach','1','Net35', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net50','1','Net50', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net50 New','1','Net50', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net50 Online','1','Net50', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo Net50','1','Net50', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Net50','1','Net50', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired Net50','1','Net50', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Net50 Online','1','Net50', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK Net50','1','Net50', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees Net50','1','Net50', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees Net50 ','1','Net50', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Net50 SunnyBeach','1','Net50', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Net50SunnyBeach','1','Net50', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','MON','1','Other', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired','1','Other', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK','1','Other', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Other','1','Other', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Other ','1','Other', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2010 Premium ','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Premium','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Premium New','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Premium Online','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2010 Premium','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees Premium','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees Premium ','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 Premium','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 Premium Online ','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Premium  ','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Premium Online','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Partners Premium','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK Premium','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Premium','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Premium ','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Premium DSA','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Premium Online','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo Premium','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Premium Online ','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Premium','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Premium Online ','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Premium','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Premium DSA','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Premium Loyal','1','Premium', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2010 Premium+','1','Premium+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2010 Premium+','1','Premium+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2010 Premium+ Online','1','Premium+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 Premium+','1','Premium+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Partners Premium+','1','Premium+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2010 Smart','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Smart','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Smart New','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Smart Online','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Birthday2011 Smart','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2010 Smart','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Smart','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Smart DSA','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees Smart','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees Smart ','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees Smart+','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 Smart','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 Smart Online','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Smart','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Smart Online','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Partners Smart','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK Smart ','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Smart','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Smart DSA','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Smart Loyal','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Smart Online','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Smart+ DSA','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Smart+ Online','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Smart ','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK012012 Smart','1','Smart', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2010 Smart+','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Smart+','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Smart+ New','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Smart+ Online','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2010 Smart+','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Smart+','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Employees Smart+','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 Smart+','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Feb2011 Smart+ Online','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Partners Smart+','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Smart+','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Smart+ DSA','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Smart+ Online','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Smart+ DSA','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK012012 Smart+','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Smart+','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Fest Smart+ Online','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK Smart +','1','Smart+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Start','1','Start', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Start New ','1','Start', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Birthday2011 Start','1','Start', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Start','1','Start', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Summer2011 Start DSA','1','Start', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Speed DSA','1','Start', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Start New','1','Start', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Start','1','Start', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK012012 Speed ','1','Start', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Speed+ DSA','1','Start', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK012012 Start','1','Start', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Start+','1','Start+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Start+','1','Start+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Start+ DSA','1','Start+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK012012 Start+','1','Start+', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo Call100','1','Voice', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo CallFree','1','Voice', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','BLZ2010 Call75','1','Voice', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Expired CallFree','1','Voice', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo Call75','1','Voice', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo WiFi','1','WiFi', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','blizoo ATV ','1','ATV ', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','PZK DTV80','1','DTV80 ', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 Net150','1','Net150 ', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Christmas2011 Net150','1','Net150 ', '2010-09-01 00:00:00')
insert into scrules..DimUserLoadHierarchy (DimensionId,LevelName,RollupId,ParentLevelName,StartDate) values('5','Autumn2011 LAN150','1','Net150 ', '2010-09-01 00:00:00')

/*
	re-insert the outlier codes backed up in STEP01
*/
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
select '5'
      ,[BillingSystemCode]
      ,[BillingSubSystemCode]
      ,a.[UserCode]
      ,a.[UserKey01]
      ,a.[UserKey02]
      ,a.[UserKey03]
      ,a.[UserKey04]
      ,a.[UserKey05]
      ,[StartDate]
      ,[RollupName]
      ,[ShortName]
      ,[LongName]
      ,a.[UnitCountFlag]
      ,a.[RevCountFlag]
      ,b.Gen02LongName as "LevelLongName"
      ,[User01]
      ,[User02]
      ,[User03]
      ,[User04]
      ,[User05]
      ,[User06]
      ,[User07]
      ,[User08]
      ,[User09]
      ,[User10] from scrules..tmp_outlier_codes_bak_d5 a
inner join scrules..DimUserReportingAllHistory b
on a.UserCode = b.UserCode and b.DimensionId='5';