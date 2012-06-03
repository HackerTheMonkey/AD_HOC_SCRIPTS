use [scods];
-- Initialize the list of indexes to reorganize
set nocount on;
declare @indexList table(id int identity, tableName varchar(100), indexName varchar(100));
declare @vDatabaseName varchar(50);
insert into @indexList
select 
	OBJECT_NAME(t.object_id), 
	i.name
from 
	sys.dm_db_index_physical_stats(DB_ID('scods'), null, null, null, null) t
inner join 
	sys.indexes i 
on 
	t.index_id = i.index_id and 
	t.object_id = i.object_id
where 
	i.name is not null and 
	t.avg_fragmentation_in_percent >= 20
order by 
	t.avg_fragmentation_in_percent desc;

-- Loop over the indexes and reorganize them
declare @iCount int;
select @iCount = COUNT(1) from @indexList;
if @iCount <> 0
begin
while @iCount > 0	
	begin			
		declare @indexName varchar(100);
		declare @tableName varchar(100);
		select @indexName = indexName, @tableName = tableName from @indexList where id = @iCount;
		print 'Reorganizing ' + @indexName + '...';
		print ('alter index ' + @indexName + ' on ' + @tableName + ' reorganize');
		select @iCount = @iCount - 1;
	end
end
else
	print 'No indexes to reorganize';