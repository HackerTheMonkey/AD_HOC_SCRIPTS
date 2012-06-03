use [SCODS];
declare @toSnapshotDate date;
declare @fromSnapshotDate  date;
declare	@return_value int

select @fromSnapshotDate = '12-26-2011';
select @toSnapshotDate = '12-31-2011';


while @fromSnapshotDate <= @toSnapshotDate
begin
	
	exec	@return_value = [dbo].[Delete_ODS_Data_CT] @dSnapshotDate = @fromSnapshotDate, @vDBName='SCODS-CT';	
	
	select	'DB_NAME' = 'SCODS-CT', 'Deleted' = @fromSnapshotDate, 'Return Value' = @return_value;	
	
	set @fromSnapshotDate = DATEADD(DD, 1, @fromSnapshotDate);
end;
