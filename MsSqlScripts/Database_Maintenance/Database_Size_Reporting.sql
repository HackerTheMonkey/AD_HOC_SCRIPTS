SET NOCOUNT ON;
declare @databaseList table(id int identity, databaseName varchar(50));
declare @os_hdd_free_space table(drive varchar(1), mb_free varchar(50));
declare @iDBsCount int;
declare @hdd_drive_free_space varchar(50);
declare @nSQL char(8000);
set nocount on;
begin			
	-- Set the default list of the database to gather statistics for
	insert into @databaseList (databaseName) values ('[SCODS-CT]');
	insert into @databaseList (databaseName) values ('[SCODS-RC]');
	insert into @databaseList (databaseName) values ('[SCODS-EK]');
	insert into @databaseList (databaseName) values ('[SCLOAD]');
	insert into @databaseList (databaseName) values ('[SCREPORT]');
	insert into @databaseList (databaseName) values ('[SCODS]');
	-- Get the fixed drives free space for the server
	print '';
	print '####################################################### OS HDD Free Space ########################################################';
	print '';
	insert into @os_hdd_free_space exec master..xp_fixeddrives;
	
	select @hdd_drive_free_space = mb_free from @os_hdd_free_space where drive='C';
	print 'C: ' + ltrim(str(cast(@hdd_drive_free_space as numeric) / 1024, 15, 3)) + ' GB free space';
	
	select @hdd_drive_free_space = mb_free from @os_hdd_free_space where drive='D';
	print 'D: ' + ltrim(str(cast(@hdd_drive_free_space as numeric) / 1024, 15, 3)) + ' GB free space';
	
	select @hdd_drive_free_space = mb_free from @os_hdd_free_space where drive='E';
	print 'E: ' + ltrim(str(cast(@hdd_drive_free_space as numeric) / 1024, 15, 3)) + ' GB free space';
	
	print '';
	-- Loop over the databases and generate the reports
	select @iDBsCount = COUNT(1) from @databaseList;
	while @iDBsCount > 0
	begin
		declare @vCurrentDatabase varchar(50);
		select @vCurrentDatabase = databaseName from @databaseList where id=@iDBsCount;
		-- Switch context and get the statistics
		select @nSQL = 'use ' + @vCurrentDatabase + ';
		declare @databaseSize dec(15, 3);
		declare @allocatedPages dec(15, 3);
		declare @unallocatedPages dec(15, 3);
		declare @percentageAvailable dec(15, 3);
		declare @table_sizes table(id int identity, name varchar(100), rows varchar(100), reserved varchar(100), data varchar(100), index_size varchar(100), unused varchar(100));
		declare @logSize bigint;
		declare @indexList table(id int identity, tableName varchar(100), indexName varchar(100), fragmentationPercentage varchar(100));
		-- Get the database size as well as the log size
		select 
			@databaseSize = STR(sum(convert(bigint,case when status & 64 = 0 then size else 0 end))),
			@logSize = STR(sum(convert(bigint,case when status & 64 <> 0 then size else 0 end)))
		from
			sys.sysfiles;
		-- Get the allocated pages
		select @allocatedPages = sum(a.total_pages) from sys.partitions p join sys.allocation_units a on p.partition_id = a.container_id
		left join sys.internal_tables it on p.object_id = it.object_id;
		-- Calculate the percentage of the available space in the DB
		select @unallocatedPages = @databaseSize - @allocatedPages;
		-- Calculate the percentage of the available space
		select @percentageAvailable = (@unallocatedPages / @databaseSize) * 100;						
		-- Print the report		
		print ''####################################################### '' + db_name() + '' ########################################################'';
		print '''';
		print ''Database Size Report'';
		print ''----------------------'';
		print ''DatabaseSize: '' + ltrim(str(@databaseSize * 8 / 1048576, 15, 3)) + ''GB'';
		print ''LogSize: '' + ltrim(str((@logSize * 8 / 1048576),15,3)) + '' GB'';
		print ''PercentageAvailable: '' + ltrim(str((@percentageAvailable),15,3)) + ''%'';
		
		-- Check the table sizes and the number of rows and print them out
		declare @iCounter int;
		declare @tableName varchar(100);
		declare @tableNoOfRows varchar(100);
		declare @tableSize varchar(100);
		declare @NoOfTables int;
		select @iCounter = 1;
		if substring(DB_NAME(), 0, 6) = ''SCODS''
		begin
			-- Get the tables statistics
			insert into @table_sizes (name, rows, reserved , data, index_size, unused) exec sp_spaceused ''ODSServicePackageSnapshot'';
			insert into @table_sizes (name, rows, reserved , data, index_size, unused) exec sp_spaceused ''ODSCustomerSnapshot'';
			-- Print a separator
			print '''';
			print ''Tables Size Report'';
			print ''----------------------'';
			-- iterate and print out
			select @NoOfTables = count(1) from @table_sizes;
			while @iCounter <= @NoOfTables
			begin
				select @tableName = name, @tableNoOfRows = rows, @tableSize = reserved from @table_sizes where id = @iCounter;
				print ''TableName: '' + @tableName + '', Size: '' + ltrim(str(cast(substring(@tableSize, 0, PATINDEX(''%KB'', @tableSize)) as numeric)/1024, 15, 3)) + '' MB, #Rows: '' + @tableNoOfRows;
				
				-- Increment the counter variable
				select @iCounter = @iCounter + 1;
			end;			
		end;
		else if DB_NAME() = ''SCREPORT''
		begin
			-- Get the tables statistics
			insert into @table_sizes (name, rows, reserved , data, index_size, unused) exec sp_spaceused ''FactMonthlyFeatureDetail'';
			insert into @table_sizes (name, rows, reserved , data, index_size, unused) exec sp_spaceused ''FactActivityFeatureDetail'';
			insert into @table_sizes (name, rows, reserved , data, index_size, unused) exec sp_spaceused ''FactMonthlyServiceDetail'';
			insert into @table_sizes (name, rows, reserved , data, index_size, unused) exec sp_spaceused ''FactActivityServiceDetail'';
			-- Print a separator
			print '''';
			print ''Tables Size Report'';
			print ''----------------------'';
			-- iterate and print out
			select @NoOfTables = count(1) from @table_sizes;
			while @iCounter <= @NoOfTables
			begin
				select @tableName = name, @tableNoOfRows = rows, @tableSize = reserved from @table_sizes where id = @iCounter;
				print ''TableName: '' + @tableName + '', Size: '' + ltrim(str(cast(substring(@tableSize, 0, PATINDEX(''%KB'', @tableSize)) as numeric)/1024, 15, 3)) + '' MB, #Rows: '' + @tableNoOfRows;
				
				-- Increment the counter variable
				select @iCounter = @iCounter + 1;
			end;			
		end;
		
		print '''';
		print '''';		
		';				
		exec(@nSQL);
		-- decrement the count
		select @iDBsCount = @iDBsCount - 1;
	end;
end;