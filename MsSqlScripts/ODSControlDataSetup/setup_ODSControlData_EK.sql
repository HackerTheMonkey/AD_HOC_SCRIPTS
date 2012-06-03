/*
	This script is used to set up the ODSControlData table for forcing a snapshot load to
	compensate for the gap produced by having a missing feed.
*/
use [SCODS-ek];

/*
	Delete all the records from the ODSControlData for the day that we are processing
	at the moment.
*/
select * from ODSControlData t where t.SnapshotDate = '12-01-2011' and t.DataFileTypeId in ('1', '2', '3');--No data available

/*
	Create ODSControlData for BSSID 40 if there is data for it for [SCODS-EK]..ODSCustomerSnapshot
*/
GO
	declare @iCustomerCount int;
	select @iCustomerCount =  COUNT(0) from [SCODS-EK]..ODSCustomerSnapshot where SnapshotDate = '12-01-2011' and BillingSubSystemId = '40';
	if @iCustomerCount > 0
	begin
		INSERT INTO ODSControlData (ApplicationId,DataFileTypeId,BillingSubSystemId,LoadDate,ExtractDate,SnapshotDate,User01,User02,User03)
			values ('1', '2', '40', '12-01-2011', '12-01-2011', '12-01-2011', 0, 0, 0);
		print 'ODSControlData created for [SCODS-EK]..ODSCustomerSnapshot & BSSID: 40';	
	end;
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	Create ODSControlData for BSSID 30 if there is data for it for [SCODS-EK]..ODSServicePackageSnapshot
*/
GO
	declare @iCustomerCount int;
	select @iCustomerCount =  COUNT(0) from [SCODS-EK]..ODSServicePackageSnapshot where SnapshotDate = '12-01-2011' and BillingSubSystemId = '40';
	if @iCustomerCount > 0
	begin
		INSERT INTO ODSControlData (ApplicationId,DataFileTypeId,BillingSubSystemId,LoadDate,ExtractDate,SnapshotDate,User01,User02,User03)
			values ('1', '3', '40', '12-01-2011', '12-01-2011', '12-01-2011', 0, 0, 0);		
		print 'ODSControlData created for [SCODS-EK]..ODSCustomerSnapshot & BSSID: 40';	
	end;
GO