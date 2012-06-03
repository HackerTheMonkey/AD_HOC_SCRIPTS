/*
	This script is used to set up the ODSControlData table for forcing a snapshot load to
	compensate for the gap produced by having a missing feed.
*/
use [SCODS-CT];

/*
	Delete all the records from the ODSControlData for the day that we are processing
	at the moment.
*/
select * from ODSControlData t where t.SnapshotDate = '12-01-2011' and t.DataFileTypeId in ('1', '2', '3');--No data available

/*
	Create ODSControlData for [SCODS-CT]..ODSCustomerSnapshot
*/
GO
	declare @iCustomerCount int;
	select @iCustomerCount =  count(1) from [SCODS-CT]..ODSCustomerSnapshot where SnapshotDate = '12-01-2011';
	if @iCustomerCount > 0
	begin
		INSERT INTO ODSControlData (ApplicationId,DataFileTypeId,BillingSubSystemId,LoadDate,ExtractDate,SnapshotDate,User01,User02,User03)		
			values ('1', '2', '1', '12-01-2011', '12-01-2011', '12-01-2011', 0, 0, 0);
		print 'ODSControlData created for [SCODS-CT]..ODSCustomerSnapshot & BSSID: 40';	
	end;
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	Create ODSControlData for BSSID 30 if there is data for it for [SCODS-CT]..ODSServicePackageSnapshot
*/
GO
	declare @iCustomerCount int;
	select @iCustomerCount =  COUNT(0) from [SCODS-CT]..ODSServicePackageSnapshot where SnapshotDate = '12-01-2011';
	if @iCustomerCount > 0
	begin
		INSERT INTO ODSControlData (ApplicationId,DataFileTypeId,BillingSubSystemId,LoadDate,ExtractDate,SnapshotDate,User01,User02,User03)
			values ('1', '3', '1', '12-01-2011', '12-01-2011', '12-01-2011', 0, 0, 0);		
		print 'ODSControlData created for [SCODS-CT]..ODSCustomerSnapshot & BSSID: 40';	
	end;
GO