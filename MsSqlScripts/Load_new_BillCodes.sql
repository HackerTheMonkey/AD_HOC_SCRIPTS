-- The following SQL is useful when loading and troubleshooting the loading process
-- of new BillCodes defined by blizoo into the scload staging area


-- Loading BillCodes defined by Blizoo into the dimensions table	
select count(1) from scload..DimProductLoadBillCodes where BillCode in ('30-10447');
select count(1) from SCLOAD..DimProductLoadHierarchy;
select count(1) from scload..DimProductLoadLevels;

-- Here we need to check that the billing sub system id is not 01, as it should be 1 instead
select * from scload..DimProductLoadBillCodes where BillingSystemCode is NULL or BillingSystemCode <> '01';
select BillingSubSystemCode from scload..DimProductLoadBillCodes
where BillingSubSystemCode is NULL or BillingSubSystemCode <> '0001';

-- Create temporary tables to hold the bill code data from the staging scload schema
select * into scload..tmp_hk_DimPrdLoadBillCodes_20120109 from scload..DimProductLoadBillCodes;
select * into scload..tmp_hk_DimPrdLoadHierarchy from scload..DimProductLoadHierarchy;
select * into scload..tmp_hk_DimPrdLoadLevels from scload..DimProductLoadLevels;

-- Check the original bill codes that were loaded by blizoo, these are saved into a backup table
select count(1) from scload..tmp_hk_DimPrdLoadBillCodes;--304
-- Check the codes that exist in the dprah or not
	select count(1) from scload..DimProductLoadBillCodes where BillCode in (select BillCode from scrules..DimProductReportingAllHistory);-- there is only one code that exist in dprah, blizoo
-- said that it a re-mapping of an old code


-- Investigate how the above code is re-mapped
/*
	The code in question seem the same as the old one defined in dprah
*/
select t.BillCode, g.BillCode, t.BillCodeLongName, t.ProductLevelLongName, g.BillCodeLongName, g.Gen02LongName
from scload..DimProductLoadBillCodes t inner join scrules..DimProductReportingAllHistory g
on t.BillCode = g.BillCode;--BillCode: 30-172837

select * from scrules..DimProductReportingAllHistory t where t.BillCode='30-172837';


-- two of them that were exist prior to the load

-- Check the remaining codes that were not loaded during the last loading process.
select count(1) from scload..DimProductLoadBillCodes;-- there are 29 not loaded codes
select * from scload..DimProductLoadBillCodes where BillCode in (select BillCode from scrules..DimProductReportingAllHistory);
--Check the proc log
select * from scrules..vAuditRtProcessMessage order by MessageKey desc;
-- Search the code repository
for file in $(find . -type f | grep -v svn | grep -v Scripts)
do
	grep -li "dimuserreportingallhistory" $file
done

-- Here I am investigating a loading problem which is when we run the RUL_PROD_100_LoadData proc
-- it defines the codes but then it leaves 29 codes without defining them and it doesn't generate
-- any proper error message and instead it exit gracefully.
SELECT
    	  lod.BillCode
    	, gbss.BillingSubSystemId
    	, lod.UserKey01
    	, lod.UserKey02
    	, lod.UserKey03
    	, lod.UserKey04
    	, lod.UserKey05
    	, refs.BillCode
    FROM scrules..DimProductLoadBillCodes Lod

    INNER JOIN scrules..ControlBillingSystem gbs
    ON lod.BillingSystemCode = gbs.BillingSystemCode

    INNER JOIN scrules..ControlBillingSubSystem gbss
    ON	lod.BillingSubSystemCode = gbss.BillingSubSystemCode
    AND	gbs.BillingSystemId = gbss.BillingSystemId

    LEFT OUTER JOIN scrules..DimProductBillCodeFactKey Refs
    ON	Lod.BillCode = Refs.BillCode
    AND gbss.BillingSubSystemId = Refs.BillingSubSystemId
    AND	lod.UserKey01 = Refs.UserKey01
    AND	lod.UserKey02 = Refs.UserKey02
    AND	lod.UserKey03 = Refs.UserKey03
    AND	lod.UserKey04 = Refs.UserKey04
    AND	lod.UserKey05 = Refs.UserKey05

    WHERE
    	Refs.BillCode IS NULL;
-- Get all the codes that are to be defined but they do exist in the scrules..DimProductBillCodeFactKey table
select * from scload..tmp_hk_DimPrdLoadBillCodes where BillCode 
in (select BillCode from scrules..DimProductBillCodeFactKey); --it seems that all of the codes are already defined
-- in the DimProductBillCodeFact key table, hence there is nothing to be inserted into that table as they all seem
-- to exist already

--
select count(a.BillCode, b.BillCodeFactKey) from
	scrules..DimProductLoadBillCodes a,
	DIMPRODUCTBILLCODEFACTKEY b
where a.BillCode = b.BillCode;

-- Get the StreamProcess key associated with the input @nProcessKey
select StreamProcessKey from scrules..AuditRTProcess where ProcessKey='107917';--107809
-- Get the value associated with a certain runtime parameter for a given StreamProcessKey
select * from scrules..AuditRTProcessStreamParms where 
StreamProcessKey=(select StreamProcessKey from scrules..AuditRTProcess where ProcessKey='107917') 
and lower(ParmName)='DateKey';
-- Check the BillCodes to be loaded
select * from scload..DimProductLoadBillCodes;
-- Get all the BillCodes with valid and defined ProductLevelLongName(s)
select count(1) from scload..DimProductLoadBillCodes a
left outer join scrules..DimProductLevel b on a.ProductLevelLongName = b.LevelLongName;
-- Check if the BillCodes that are about to be loaded and extracted from the input tables do have
-- valid and defined product levels;
-- get the unique levels for the BillCodes to be defined
select distinct ProductLevelLongName from scload..tmp_hk_DimPrdLoadBillCodes;
select count(1) from scload..tmp_hk_DimPrdLoadBillCodes a left outer join scrules..DimProductLevel b
on a.ProductLevelLongName = b.LevelLongName where b.LevelLongName is null;
-- Check of the product levels associtaed with the BillCodes are defined or not
select count(1) from scload..tmp_hk_DimPrdLoadBillCodes a left outer join scrules..DimProductLevel b
on a.ProductLevelLongName = b.LevelLongName where b.LevelLongName is null;

select b.LevelLongName, a.* from scload..DimProductLoadBillCodes a left outer join scrules..DimProductLevel b
on a.ProductLevelLongName = b.LevelLongName where b.LevelLongName is null;

select COUNT(*) from scload..DimProductLoadBillCodes;
select COUNT(*) from scrules..DimProductLoadBillCodes;
select * into scload..tmp_hk_DimPrdLoadBillCodes_20111207 from SCLoad..DimProductLoadBillCodes;
-- Get the unique product level names and check if there are any BillCodes that are marked to DELETE
select distinct t.ProductLevelLongName from scload..DimProductLoadBillCodes t;
select t.ProductLevelLongName, count(1) as "LevelsCount" from scload..tmp_hk_DimPrdLoadBillCodes t 
group by t.ProductLevelLongName order by "LevelsCount" desc;
-- Fix the UserKeyX 0 length problem
select * from scload..DimProductLoadBillCodes t where t.UserKey01 <> '0';
update scload..DimProductLoadBillCodes
set
	UserKey01 = '0',
	UserKey02 = '0',
	UserKey03 = '0',
	UserKey04 = '0',
	UserKey05 = '0'
where
	UserKey01 <> '0' or
	UserKey02 <> '0' or
	UserKey03 <> '0' or
	UserKey04 <> '0' or
	UserKey05 <> '0';
-- Get the unique product level names from the DimProductReportingAllHistory for all the loaded
-- codes
select t.ProductLevelLongName, count(1) as "LevelsCount" from scload..tmp_hk_DimPrdLoadBillCodes t
inner join scrules..DimProductReportingAllHistory dprah on t.BillCode = dprah.BillCode
group by t.ProductLevelLongName order by "LevelsCount" desc;
-- Compare the previous report obtained from the above query with the orginal product level names
-- obtained from the original data entered by blizoo.
select a.ProductLevelLongName, b.ProductLevelLongName, a.LevelsCount, b.LevelsCount
from
	(select t.ProductLevelLongName, count(1) as "LevelsCount" from scload..tmp_hk_DimPrdLoadBillCodes_20111207 t
inner join scrules..DimProductReportingAllHistory dprah on t.BillCode = dprah.BillCode
group by t.ProductLevelLongName) a left outer join
	(select t.ProductLevelLongName, count(1) as "LevelsCount" from scload..tmp_hk_DimPrdLoadBillCodes_20111207 t 
group by t.ProductLevelLongName) b on a.ProductLevelLongName = b.ProductLevelLongName
;

for filename in $(find . -type f | grep -v svn | grep Procedure)
do
	grep -il "RUL_CUST_0009_ImportAllTables" $filename
done

/*
	During the load of the new bill codes for the 12-DEC-2011, I have noticed that there
	were two codes that were exist in the dprah and they seem to be remapped again, hence
	I need to find these codes and inform blizoo about them.
*/

/*
	Get the ProcessKey of the last successful engine run, this
	ProcessKey is used by the following procedure in order to
	obtain the most up to date values of the runtime parameters
	that the engine store into the database.
*/
select distinct t.ProcessKey, t.MessageKey from scrules..vAuditRTProcessMessage t 
where t.StatusName='Successful' order by t.MessageKey desc;

/*
	Run the proc that is part of the engine to load the new bill codes
*/
USE [SCLoad]

GO
DECLARE     @return_value int

EXEC  @return_value = [dbo].[RUL_PROD_0100_LoadData]

            @nProcessKey = 144061,
            @vLoadingdate = '20120401' -- This is the date that will serve as a postfix to the temporary backup tables
            
SELECT      'Return Value' = @return_value

GO

select * from scload..tmp_hk_DimPrdLoadBillCodes_20120325 t where t.isAlreadyExist='1';
select * from scload..DimProductLoadBillCodes;
drop table scload..tmp_hk_DimPrdLoadBillCodes_20120325;
update scload..DimProductLoadBillCodes set BillingSubSystemCode='0001' where BillingSubSystemCode <> '0001';
select * from scrules..vAuditRTProcessMessage order by MessageKey desc;

/*
	Load any newly defined user dimension codes
*/
USE [SCLoad]

GO
DECLARE     @return_value int

EXEC  @return_value = [dbo].[RUL_USER_0100_LoadData]

            @nProcessKey = 144061,
            @vLoadingdate = '20120328'-- Guess that this is not needed, might need to revise the code for this proc and get this field deleted      
            
SELECT      'Return Value' = @return_value

GO

/*
	Here we just want to check if the user codes have been loaded
	or not yet
*/
select COUNT(1) from SCRules..DimUserLoadCodes;
select COUNT(1) from SCRules..DimUserLoadLevels;
select Count(1) from SCRules..DimUserLoadHierarchy;

select * from scload..DimUserLoadCodes;

insert into scload..DimUserLoadCodes
	select * from scrules..DimUserLoadCodes;
	
truncate table scrules..DimUserLoadCodes;	

select * into scload..DimUserLoadCodes_bak_20120328 from scload..DimUserLoadCodes;