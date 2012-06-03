use [hasdb01];
-- Check the sizes of the database files
select name, (size * 8) as "DB Size in KB" from sys.database_files;
-- Create new tables and then populate them with data
GO
create table FirstTable
(
	ID int,
	FirstName varchar(100),
	LastName varchar(100),
	City varchar(100)
);
GO
create clustered index [IX_FirstTable_ID] on FirstTable
(
	[ID] ASC
) on [PRIMARY];
-- Create the second table
create table SecondTable
(
	ID int,
	FirstName varchar(100),
	LastName varchar(100),
	City varchar(100)
);
create clustered index [IX_SecondTable_ID] on SecondTable
(
	[ID] ASC
) on [PRIMARY];
-- Populates the tables with data
Go
insert into FirstTable
select top 100000 ROW_NUMBER() over (order by a.name), 'hasanein', 'khafaji', 'London' 
from sys.all_objects a cross join sys.all_objects b;
Go
insert into SecondTable
select top 100000 ROW_NUMBER() over (order by a.name), 'hasanein', 'khafaji', 'London' 
from sys.all_objects a cross join sys.all_objects b;
Go
-- Drop the tables
drop table FirstTable;
drop table SecondTable;
-- Check the sizes of the database again
select name, (size * 8)/1024 as "DB Size in MB" from sys.database_files;
-- Shrink Database
dbcc shrinkdatabase ('hasdb01');
-- Check the fragmentation information
select b.name, OBJECT_NAME(a.object_id), a.fragment_count, a.avg_fragmentation_in_percent
from sys.dm_db_index_physical_stats(null, null, null, null, null) a
inner join sys.databases b on a.database_id = b.database_id
where OBJECT_NAME(a.object_id) is not null and b.name='hasdb01'
order by a.avg_fragmentation_in_percent desc;
-- Truncate the tables
truncate table FirstTable;
truncate table SecondTable;
-- Rebuild The indexes
alter index [IX_SecondTable_ID] on SecondTable rebuild;
alter index [IX_FirstTable_ID] on FirstTable rebuild;
-- reorganize the indexes
alter index [IX_SecondTable_ID] on SecondTable reorganize;
alter index [IX_FirstTable_ID] on FirstTable reorganize;
-- Drop and Recreate the indexes
drop index IX_SecondTable_ID on SecondTable;
create clustered index [IX_SecondTable_ID] on SecondTable
(
	[ID] ASC
) on [PRIMARY];