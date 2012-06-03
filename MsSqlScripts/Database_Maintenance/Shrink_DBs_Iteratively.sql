use [SCODS-CT];
SET NOCOUNT ON;

declare @vDatabaseName varchar(50);
declare @iFinalTargetPercent integer;
declare @iIntermediateTargetPercent integer;
declare @iCurrentPercentageAvailble integer;
declare @databaseSize dec(15, 3);
declare @allocatedPages dec(15, 3);
declare @unallocatedPages dec(15, 3);
declare @percentageAvailable dec(15, 3);

set nocount on;
begin
	select 	@vDatabaseName = 'scods-ct', @iFinalTargetPercent = '60';			
	/*
		Get the current percentage of the available space
		on the given database to start shrinking from
	*/
	
	-- Get the database size
	select 
		@databaseSize = STR(sum(convert(bigint,case when status & 64 = 0 then size else 0 end)))
	from
		sys.sysfiles;
		
	-- Get the allocated pages
	select @allocatedPages = sum(a.total_pages) from sys.partitions p join sys.allocation_units a on p.partition_id = a.container_id
	left join sys.internal_tables it on p.object_id = it.object_id;
	-- Calculate the percentage of the available space in the DB
	select @unallocatedPages = @databaseSize - @allocatedPages;
	-- Calculate the percentage of the available space
	select @percentageAvailable = (@unallocatedPages / @databaseSize) * 100;	
	/*
		Shrink incrementally by 1% at a time
		until the finalTargetPercent is reached
	*/
	select @iIntermediateTargetPercent = @percentageAvailable - 1;
	
	ShrinkDatabase:
	begin		
		select 'PercentageAvailable' = ltrim(str(@iIntermediateTargetPercent));
		--print 'dbcc shrinkdatabase(' + @vDatabaseName + ', ' + ltrim(str(@iIntermediateTargetPercent)) + ')';
		dbcc shrinkdatabase(@vDatabaseName, @iIntermediateTargetPercent);		
	end;		
	/*
		decrement the intermediate value and test if the
		finalTargetPercent is reached.
	*/
	select @iIntermediateTargetPercent = @iIntermediateTargetPercent - 1;
	if @iIntermediateTargetPercent >= @iFinalTargetPercent 
		goto ShrinkDatabase		
	
	print upper(@vDatabaseName) + ': percentageAvailable: ' + ltrim(str(@percentageAvailable)) + '%';
	print upper(@vDatabaseName) + ': intermediateTargetPercent: ' + ltrim(str(@iIntermediateTargetPercent)) + '%';		
end;