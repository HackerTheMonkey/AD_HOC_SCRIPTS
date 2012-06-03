USE [SCODS-EK];
GO
SELECT a.index_id, name, avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID(N'ODSServicePackageSnapshot'),
     NULL, NULL, NULL) AS a
    JOIN sys.indexes AS b ON a.object_id = b.object_id AND a.index_id = b.index_id;
GO


USE [SCODS-CT];
GO
SELECT a.index_id, name, avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL,NULL, NULL, NULL) AS a
    JOIN sys.indexes AS b ON a.object_id = b.object_id AND a.index_id = b.index_id;
GO

use [SCODS-CT];
select name, (size * 8)/1024/1024 as "DB Size in GB" from sys.database_files;
use [SCODS-RC];
select name, (size * 8)/1024/1024 as "DB Size in GB" from sys.database_files;
use [SCODS-EK];
select name, (size * 8)/1024/1024 as "DB Size in GB" from sys.database_files;
use [SCLOAD];
select name, (size * 8)/1024/1024 as "DB Size in GB" from sys.database_files;
use [SCRULES];
select name, (size * 8)/1024/1024 as "DB Size in GB" from sys.database_files
use [SCODS];
select name, (size * 8)/1024/1024 as "DB Size in GB" from sys.database_files
use [screport];
select name, (size * 8)/1024/1024 as "DB Size in GB" from sys.database_files
use [blizoo];
select name, (size * 8)/1024/1024 as "DB Size in GB" from sys.database_files
-- Check the fragmentation information for CT
select b.name, a.object_id, a.index_id, a.index_type_desc, a.avg_fragmentation_in_percent, a.page_count, a.fragment_count
from sys.dm_db_index_physical_stats(DB_ID('SCODS-CT'), null, null, null, null) a
inner join sys.databases b on a.database_id = b.database_id
where OBJECT_NAME(a.object_id) is not null
order by a.avg_fragmentation_in_percent desc;
-- Check the fragmentation information for RC
select b.name, a.object_id, a.index_type_desc, a.avg_fragmentation_in_percent, a.page_count, a.fragment_count
from sys.dm_db_index_physical_stats(DB_ID('SCODS-RC'), null, null, null, null) a
inner join sys.databases b on a.database_id = b.database_id
where OBJECT_NAME(a.object_id) is not null
order by a.avg_fragmentation_in_percent desc;


-- Get all the indexes on all the tables in the SCODS-CT database
use [SCODS-CT];
--select a.name, OBJECT_NAME(a.object_id) as "TableName" from sys.indexes a inner join sys.tables b on a.object_id = b.object_id
--where a.name is not null;
select b.name as "DatabaseName", d.name as "TableName", c.name as "IndexName", a.index_type_desc, a.avg_fragmentation_in_percent, a.page_count, a.fragment_count
from sys.dm_db_index_physical_stats(DB_ID('SCODS-CT'), OBJECT_ID(N'SCODS-CT..ODSServicePackageSnapshot'), null, null, null) a
inner join sys.databases b on a.database_id = b.database_id
inner join sys.indexes c on a.object_id = c.object_id
inner join sys.tables d on a.object_id = d.object_id
where OBJECT_NAME(a.object_id) is not null
order by a.avg_fragmentation_in_percent desc;
-- Reorganize the indexes
use [SCODS-CT];
GO
--alter index PK_ODS_ServicePackage_Delta			on ODSServicePackageDelta			reorganize;
Go
--alter index PK__ODS_Control_Data__46E78A0C  on ODSControlData             reorganize;
go
--alter index PK_ODS_Customer_Delta           on ODSCustomerDelta           reorganize;
go
alter index PK_ODS_ServicePackage_Snapshot  on ODSServicePackageSnapshot  reorganize;
go
