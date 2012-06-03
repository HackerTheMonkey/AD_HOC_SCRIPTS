/*
	This ad-hoc T-SQL script is used to generate a statistical report to serve for the database retention
	of Blizoo project
*/

/*
	1) Get the unique number of subscribers (i.e. services or customers)
*/
with unique_subscribers as
(select distinct BillingSubSystemId, AccountNumber, ServiceNumber from SCRules..StateServiceDimension t)
select count(1) from unique_subscribers;

/*
	2) Get the average number of features per each subscriber
*/

-- Get the number of features per a single subscriber
select sum(a.NoOfFeaturesPerSub) / COUNT(1) as "AverageFeaturesPerSub" from
(select BillingSubSystemId, AccountNumber, ServiceNumber, count(1) as "NoOfFeaturesPerSub" 
from SCRules..STATEFEATUREDIMENSION group by BillingSubSystemId, AccountNumber, ServiceNumber) a;

/*
	3) Get the percentage of the number of subscribers who undergo a change in
	   thier state per day
*/
with 
	changing_subs as
		(select distinct BillingSubSystemId, AccountNumber, ServiceNumber, SnapshotDate as "ChangeDate" from [SCODS-CT]..ODSServicePackageDelta
		union
		select distinct BillingSubSystemId, AccountNumber, ServiceNumber, SnapshotDate as "ChangeDate" from [SCODS-RC]..ODSServicePackageDelta
		union
		select distinct BillingSubSystemId, AccountNumber, ServiceNumber, SnapshotDate as "ChangeDate" from [SCODS-EK]..ODSServicePackageDelta
		),	
	total_changing_subs as
	(select ChangeDate, COUNT(1) as "NumberOfChangingSubs" from changing_subs group by ChangeDate)
select (CAST(avg(NumberOfChangingSubs) as float) / CAST(1320783 as float)) * 100 as "PercentageOfChangingSubs" from total_changing_subs;

/*
	4) Get the anticipated monthly growth in the number of subscribers each day
*/

-- Get the count of new subscribers per each month
with subscribers_creation_date as
(select BillingSubSystemId, AccountNumber, ServiceNumber, MIN(DateKeyActivation) as "CreationDateKey" 
from SCRules..StateServiceDimension a
group by BillingSubSystemId, AccountNumber, ServiceNumber)
select b.CalendarYearMonth, COUNT(1) as "NumberOfSubs" from 
subscribers_creation_date a inner join SCRules..GlobalDateSmall b on a.CreationDateKey = b.DateKey 
group by b.CalendarYearMonth order by b.CalendarYearMonth desc;


-- Calculate the percentage of growth
-- Estimated to be 3%

/*
	5) For each database, we need to obtain a list of the largest tables in that database, 
	so later on we can breakdown our analysis on it for each single table.
*/

/*
	6) For each table in the list, obtained from each database, we need to calculate the following information:
	
	a - Number of columns in the table
	b - Number of rows in the table
	c - Total Number of Bytes in that table
	d - The estimated (or exact) bytes/row
	e - Calculate (compute) the populations/month, this varies depending on the nature of the table in question
*/

-- Get the list of the large tables in the database
use [scods-ek];
select c.name, a.name, sum(b.rows) as "rows_count"
 from
	sys.tables a
inner join
	sys.partitions b on a.object_id = b.object_id
inner join
	sys.schemas c on a.schema_id = c.schema_id
group by
	c.name, a.name
order by sum(b.rows) desc;

select top 100 * from payment_types

-- a) Get the number of columns in a given table
use [scods-rc];
select object_name(object_id), name, max_length, precision name 
from sys.all_columns t where OBJECT_NAME(object_id) = 'MergeODSServicePackageDelta-CR';

use [scods-ek];
exec sp_spaceused 'ODSServicePackageSnapshot';
exec sp_spaceused 'ODSCustomerSnapshot';
exec sp_spaceused 'ODSServicePackageLoadNew';
exec sp_spaceused 'ODSServicePackageLoadOld';
exec sp_spaceused 'ODSServicePackageImport';
exec sp_spaceused 'ODSCustomerLoadNew';
exec sp_spaceused 'ODSCustomerLoadOld';
exec sp_spaceused 'ODSCustomerImport';
exec sp_spaceused 'ODSServicePackageDelta';
exec sp_spaceused 'ODSCustomerDelta';
exec sp_spaceused 'ODSRatePlanMapping';

use [scods-ct];
exec sp_spaceused 'documents_services';


select COUNT(1) from (select distinct BillingSubSystemId, HouseKey from scods..CableHouse) a;
select COUNT(1) from scods..CableHouse;