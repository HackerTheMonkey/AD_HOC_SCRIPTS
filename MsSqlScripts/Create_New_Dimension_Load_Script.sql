/*
	Create a new load process for all the dimension data
*/

/*
	Create the DimUserLoadCodes load tables
*/
select * into SCLOAD..DimUserLoadCodes from SCRules..DimUserLoadCodes where 1=2;
/*
	Create the DimUserLoadLevels load tables
*/
select * into SCLOAD..DimUserLoadLevels from SCRules..DimUserLoadLevels where 2=1;
/*
	Create the DimUserLoadHierarchy load tables
*/
select * into SCLOAD..DimUserLoadHierarchy from SCRules..DimUserLoadHierarchy where 1=2;