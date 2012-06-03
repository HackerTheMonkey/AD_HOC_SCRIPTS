/*
	This ad-hoc script is to be used for fixing some user dimensions mapping
	that have been asked by the client which involves updating and deleting
	some levels.
*/

/*
	Kazanlyk is not a village but a city
*/

-- Check all the levels related to this particular city
select * from SCRules..DimUserLevel where lower(LevelLongName) like '%KAZANLUK%';

-- Get the IDs of the levels that they want to delete
select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%village%KAZANLUK%';

-- Check if there is any user dim codes (i.e. any UserKey(s)) mapped to the redundant levels to be deleted
select * from scrules..DimUserInstanceLevel where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%village%KAZANLUK%');

-- Delete the redundant levels

-- delete from the DimUserLevel
select * from scrules..DimUserLevel where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%village%KAZANLUK%');

delete from scrules..DimUserLevel where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%village%KAZANLUK%');

-- delete from the DimUserLevelParent
select * from scrules..DimUserLevelParent where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%village%KAZANLUK%');

delete from scrules..DimUserLevelParent where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%village%KAZANLUK%');

-------------------------------------------------------------------------------------------------------

/*
	the village of Zhitnitsa existed twice with two different typings
*/

-- Check all the levels related to this particular city
select * from SCRules..DimUserLevel where lower(LevelLongName) like '%VILLAGE%GRANARY%';

-- Get the IDs of the levels that they want to delete
select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%%VILLAGE%GRANARY%';

-- Check if there is any user dim codes (i.e. any UserKey(s)) mapped to the redundant levels to be deleted
select * from scrules..DimUserInstanceLevel where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%VILLAGE%GRANARY%');

-- Delete the redundant levels

-- delete from the DimUserLevel
delete from scrules..DimUserLevel where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%VILLAGE%GRANARY%');

-- delete from the DimUserLevelParent
delete from scrules..DimUserLevelParent where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%VILLAGE%GRANARY%');

--------------------------------------------------------------------------------------------------------------

/*
	village Stamboliyski and Stamboliyski city are one and the same place. It's a city
*/

-- Check all the levels related to this particular city
select * from SCRules..DimUserLevel where lower(LevelLongName) like '%VILLAGE%STAMBOLIYSKI%';

-- Get the IDs of the levels that they want to delete
select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%VILLAGE%STAMBOLIYSKI%';

-- Check if there is any user dim codes (i.e. any UserKey(s)) mapped to the redundant levels to be deleted
select * from scrules..DimUserInstanceLevel where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%VILLAGE%STAMBOLIYSKI%');

-- Delete the redundant levels

-- delete from the DimUserLevel
delete from scrules..DimUserLevel where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%VILLAGE%STAMBOLIYSKI%');

-- delete from the DimUserLevelParent
delete from scrules..DimUserLevelParent where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%VILLAGE%STAMBOLIYSKI%');

--------------------------------------------------------------------------------------------------------------

/*
	Debar is not village but quarter in village Parvomay
*/

-- Check all the levels related to this particular city
select * from SCRules..DimUserLevel where lower(LevelLongName) like 'DISTRICT. DEBAR (DISTRICT. DEBAR (PARVOMAY))';

-- Get the IDs of the levels that they want to delete
select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%DISTRICT%DEBAR%';

-- Check if there is any user dim codes (i.e. any UserKey(s)) mapped to the redundant levels to be deleted
select * from scrules..DimUserInstanceLevel where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like '%DISTRICT. DEBAR (DISTRICT. DEBAR (PARVOMAY))');

-- Delete the redundant levels

-- delete from the DimUserLevel
delete from scrules..DimUserLevel where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like 'DISTRICT. DEBAR (DISTRICT. DEBAR (PARVOMAY))');

-- delete from the DimUserLevelParent
delete from scrules..DimUserLevelParent where LevelId in 
(select LevelId from SCRules..DimUserLevel where lower(LevelLongName) like 'DISTRICT. DEBAR (DISTRICT. DEBAR (PARVOMAY))');