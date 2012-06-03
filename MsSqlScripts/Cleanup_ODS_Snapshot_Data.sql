USE [SCODS];
GO
/****** Object:  StoredProcedure [dbo].[DELETE_FEEDS_HK]    Script Date: 09/09/2011 02:46:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].DELETE_FEEDS_HK
	@dSnapshotDate date
AS
--========================================================================================================================================
-- Description:
--
-- Change History: 

-- HK20111222: This script is used to clean up the snapshot data from the SCODS, RC, EK and CT
-- databases for the snapshot, delta and contorl tables.

--=========================================================================================================================================
set NOCOUNT ON;
declare @tablesList table(id INT IDENTITY, tableName varchar(50), databaseName varchar(50));
declare @iTablesCount integer;
declare @vTableName varchar(50);
declare @vDatabaseName varchar(50);
declare @vSQL varchar(8000);
declare @iError integer;
declare @bError BIT;
declare @iCount integer;

begin
	--select @dSnapshotDate = '11-30-2011';
	-- Input the settings
	select @bError = 0;
	-- The ODSServicePackageSnapshot table
	insert into @tablesList(tablename, databaseName) values ('ODSServicePackageSnapshot', '[SCODS-CT]');
	insert into @tablesList(tablename, databaseName) values ('ODSServicePackageSnapshot', '[SCODS-RC]');
	insert into @tablesList(tablename, databaseName) values ('ODSServicePackageSnapshot', '[SCODS-EK]');
	insert into @tablesList(tablename, databaseName) values ('ODSServicePackageSnapshot', '[SCODS]');
	-- The ODSServicePackageDelta table
	insert into @tablesList(tablename, databaseName) values ('ODSServicePackageDelta', '[SCODS-CT]');
	insert into @tablesList(tablename, databaseName) values ('ODSServicePackageDelta', '[SCODS-RC]');
	insert into @tablesList(tablename, databaseName) values ('ODSServicePackageDelta', '[SCODS-EK]');
	insert into @tablesList(tablename, databaseName) values ('ODSServicePackageDelta', '[SCODS]');
	-- The ODSCustomerSnapshot table
	insert into @tablesList(tablename, databaseName) values ('ODSCustomerSnapshot', '[SCODS-CT]');
	insert into @tablesList(tablename, databaseName) values ('ODSCustomerSnapshot', '[SCODS-RC]');
	insert into @tablesList(tablename, databaseName) values ('ODSCustomerSnapshot', '[SCODS-EK]');
	insert into @tablesList(tablename, databaseName) values ('ODSCustomerSnapshot', '[SCODS]');
	 --The ODSCustomerDelta table
	insert into @tablesList(tablename, databaseName) values ('ODSCustomerDelta', '[SCODS-CT]');
	insert into @tablesList(tablename, databaseName) values ('ODSCustomerDelta', '[SCODS-RC]');
	insert into @tablesList(tablename, databaseName) values ('ODSCustomerDelta', '[SCODS-EK]');
	insert into @tablesList(tablename, databaseName) values ('ODSCustomerDelta', '[SCODS]');
	-- The ODSControlData
	insert into @tablesList(tablename, databaseName) values ('ODSControlData', '[SCODS-CT]');
	insert into @tablesList(tablename, databaseName) values ('ODSControlData', '[SCODS-RC]');
	insert into @tablesList(tablename, databaseName) values ('ODSControlData', '[SCODS-EK]');
	insert into @tablesList(tablename, databaseName) values ('ODSControlData', '[SCODS]');

	-- populate the control variable
	select @iTablesCount = COUNT(*) from @tablesList;
	-- Loop over the DBs and delete Snapshots
	while @iTablesCount > 0
	begin	
		select @vTableName = tableName, @vDatabaseName = databaseName from @tablesList t where t.id = @iTablesCount;
		select @vSQL =  'delete from' + @vDatabaseName + '..' + @vTableName + ' where SnapshotDate=''' + cast(@dSnapshotDate as varchar) + '''';	
		exec (@vSQL);
		 
		SELECT @iError = @@Error, @iCount = @@RowCount
		if @iError <> 0 begin
    		set @bError = 1
			goto ExitProcedure
		end 
	    
		print @vDatabaseName + '..' + @vTableName + ': ' + 'RowCount: ' + ltrim(str(@@RowCount)) + ', Error: ' + ltrim(str(@@Error));
		select @iTablesCount = @iTablesCount - 1;
	end;
	
	ExitProcedure:
	set nocount off;
	return @bError;
end;	