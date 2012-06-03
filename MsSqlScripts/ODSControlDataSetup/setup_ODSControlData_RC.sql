/*
	This script is used to set up the ODSControlData table for forcing a snapshot load to
	compensate for the gap produced by having a missing feed.
*/
use [SCODS-RC];

/*
	VARIABLES DECLARATION
*/
DECLARE @tMissingFeeds table (id int identity , MissingSnapshotDate date, IsNextDayTrueUp INT default 1, SeriesId INT, ForcedSnapshotDate date);
DECLARE @tForcedSnapshotDates table (id int identity , ForcedSnapshotDate date);
DECLARE @iCount INT;
DECLARE @iRowCount INT;
DECLARE @dMissingFeedSnapshotDate date;
DECLARE @dPrevMissingFeedSnapshotDate date;
DECLARE @dNextDaySnapshotDate date;
DECLARE @dForcedSnapshotDate date;
DECLARE @isTrueUp INT;
DECLARE @iCurrentSeriesId INT;
/*
	Populate the @tMissingFeeds table
*/
insert into @tMissingFeeds (MissingSnapshotDate) values ('08-18-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('08-19-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('08-20-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('08-21-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('08-22-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('08-23-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('08-24-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('08-26-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('08-27-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('08-28-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('10-07-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('10-08-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('10-09-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('10-10-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('10-14-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('10-15-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('11-14-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('11-23-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('11-29-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('11-30-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('12-05-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('12-15-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('12-17-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('12-28-2011');
insert into @tMissingFeeds (MissingSnapshotDate) values ('01-10-2012');

/*
	Delete all the records from the ODSControlData for the missing feed
*/
select @iCurrentSeriesId = 1, @iCount = 1, @iRowCount = COUNT(1) from @tMissingFeeds;
while @iCount <= @iRowCount
begin
	-- Get the MissingSnapshotDate
	select @dMissingFeedSnapshotDate = MissingSnapshotDate, @dNextDaySnapshotDate = DATEADD(DD, 1, MissingSnapshotDate) from @tMissingFeeds t where t.id = @iCount;
	select @dPrevMissingFeedSnapshotDate = MissingSnapshotDate from @tMissingFeeds t where t.id = @iCount - 1;
	--Delete the ODSControlData records for the MissingSnapshotDate for all DataFileTypeId's
	--delete from ODSControlData where SnapshotDate = @dMissingFeedSnapshotDate;	
	
	/*
		Group the successive series of MissingSnapshotDates in a single series
		with the same series ID and set their ForcedSnapshotDate
	*/
	if @dPrevMissingFeedSnapshotDate is null or DATEDIFF(dd, @dPrevMissingFeedSnapshotDate, @dMissingFeedSnapshotDate) = 1
	begin
		update @tMissingFeeds set SeriesId = @iCurrentSeriesId where MissingSnapshotDate = @dMissingFeedSnapshotDate;		
	end
	else
	begin
		/*
			Set the SnapshotDate for the previous series that has just ended
		*/
		update @tMissingFeeds set ForcedSnapshotDate = DATEADD(DD, 1, @dPrevMissingFeedSnapshotDate) where SeriesId = (select SeriesId from @tMissingFeeds where MissingSnapshotDate = @dPrevMissingFeedSnapshotDate);
		/*
			Set the Series ID for the current MissingSnapshotDate
		*/
		select @iCurrentSeriesId = @iCurrentSeriesId + 1;
		update @tMissingFeeds set SeriesId = @iCurrentSeriesId where MissingSnapshotDate = @dMissingFeedSnapshotDate;
	end
	-- Increment the counter
	select @iCount = @iCount + 1;
	
	/*
		If this is the end of the loop, then set the ForcedSnapshotDate as the date that
		comes immediately after the last MissingFeedSnapshotDate, this is used to cover for
		the last record in the table
	*/	
	if @iCount > @iRowCount
	begin
		update @tMissingFeeds set ForcedSnapshotDate = DATEADD(DD, 1, @dMissingFeedSnapshotDate) where SeriesId = @iCurrentSeriesId;
	end;
end;


/*
	Check if the SnapshotDate to be forced is originaly a true-up date or not
*/
select @iCount = 1, @iRowCount = COUNT(1) from @tMissingFeeds;
while @iCount <= @iRowCount
begin
	-- Get the MissingSnapshotDate
	select @dForcedSnapshotDate = ForcedSnapshotDate from @tMissingFeeds t where t.id = @iCount;
	/*
		Update the temp table if the next day is a true up day
	*/
	select @isTrueUp = case when ((LastDayInWeekFlag + LastDayInMonthFlag) > 0) then 1 else 0 end from SCRules..GlobalDate where ChangeDate = @dForcedSnapshotDate;
	if @isTrueUp <> 1
	begin
		--delete from ODSControlData where SnapshotDate = @dNextDaySnapshotDate;
		update @tMissingFeeds set IsNextDayTrueUp = 0 where ForcedSnapshotDate = @dForcedSnapshotDate;
	end;
	-- Increment the counter
	select @iCount = @iCount + 1;
end;
select * from @tMissingFeeds;
/*
	Get the dates to set the ODSControlData for
*/
select distinct ForcedSnapshotDate from @tMissingFeeds t where t.IsNextDayTrueUp = 0;
/*
	Delete all the records from the ODSControlData for the ForcedSnapshotDate(s)
*/
--delete from ODSControlData where SnapshotDate in (select distinct ForcedSnapshotDate from @tMissingFeeds t where t.IsNextDayTrueUp = 0);



/*
	Loop over all the ForcedSnapshotDates and set up the ODSControlData for them
*/
insert into @tForcedSnapshotDates (ForcedSnapshotDate) (select distinct ForcedSnapshotDate from @tMissingFeeds t where t.IsNextDayTrueUp = 0);
select @iCount = 1, @iRowCount = COUNT(1) from @tForcedSnapshotDates;
while @iCount <= @iRowCount
begin
	select @dForcedSnapshotDate = ForcedSnapshotDate from @tForcedSnapshotDates where id = @iCount;
	
	
	/* Setup the ODSControlDate [START]*/
	
	/*
		Create ODSControlData for BSSID 30 if there is data for it for [SCODS-RC]..ODSCustomerSnapshot
	*/
	declare @iRecordCount int;
	
	select @iRecordCount =  COUNT(0) from [SCODS-RC]..ODSCustomerSnapshot where SnapshotDate = @dForcedSnapshotDate and BillingSubSystemId = '30';
	if @iRecordCount > 0
	begin
		INSERT INTO ODSControlData (ApplicationId,DataFileTypeId,BillingSubSystemId,LoadDate,ExtractDate,SnapshotDate,User01,User02,User03)
			values ('1', '2', '30', @dForcedSnapshotDate, @dForcedSnapshotDate, @dForcedSnapshotDate, 0, 0, 0);
		print 'ODSControlData created for [SCODS-RC]..ODSCustomerSnapshot & BSSID: 30';	
	end;
	
	
	/*
		Create ODSControlData for BSSID 31 if there is data for it for [SCODS-RC]..ODSCustomerSnapshot
	*/
	select @iRecordCount =  COUNT(0) from [SCODS-RC]..ODSCustomerSnapshot where SnapshotDate = @dForcedSnapshotDate and BillingSubSystemId = '31';
	if @iRecordCount > 0
	begin
		INSERT INTO ODSControlData (ApplicationId,DataFileTypeId,BillingSubSystemId,LoadDate,ExtractDate,SnapshotDate,User01,User02,User03)
			values ('1', '2', '31', @dForcedSnapshotDate, @dForcedSnapshotDate, @dForcedSnapshotDate, 0, 0, 0);
		print 'ODSControlData created for [SCODS-RC]..ODSCustomerSnapshot & BSSID: 31';	
	end;
	
	/*
		Create ODSControlData for BSSID 32 if there is data for it for [SCODS-RC]..ODSCustomerSnapshot
	*/
	select @iRecordCount =  COUNT(0) from [SCODS-RC]..ODSCustomerSnapshot where SnapshotDate = @dForcedSnapshotDate and BillingSubSystemId = '32';
	if @iRecordCount > 0
	begin
		INSERT INTO ODSControlData (ApplicationId,DataFileTypeId,BillingSubSystemId,LoadDate,ExtractDate,SnapshotDate,User01,User02,User03)
			values ('1', '2', '32', @dForcedSnapshotDate, @dForcedSnapshotDate, @dForcedSnapshotDate, 0, 0, 0);
		print 'ODSControlData created for [SCODS-RC]..ODSCustomerSnapshot & BSSID: 32';	
	end;


	/*
		Create ODSControlData for BSSID 30 if there is data for it for [SCODS-RC]..ODSServicePackageSnapshot
	*/
	select @iRecordCount =  COUNT(0) from [SCODS-RC]..ODSServicePackageSnapshot where SnapshotDate = @dForcedSnapshotDate and BillingSubSystemId = '30';
	if @iRecordCount > 0
	begin
		INSERT INTO ODSControlData (ApplicationId,DataFileTypeId,BillingSubSystemId,LoadDate,ExtractDate,SnapshotDate,User01,User02,User03)
			values ('1', '3', '30', @dForcedSnapshotDate, @dForcedSnapshotDate, @dForcedSnapshotDate, 0, 0, 0);
		print 'ODSControlData created for [SCODS-RC]..ODSCustomerSnapshot & BSSID: 30';	
	end;
	
	/*
		Create ODSControlData for BSSID 31 if there is data for it for [SCODS-RC]..ODSServicePackageSnapshot
	*/
	
	select @iRecordCount =  COUNT(0) from [SCODS-RC]..ODSServicePackageSnapshot where SnapshotDate = @dForcedSnapshotDate and BillingSubSystemId = '31';
	if @iRecordCount > 0
	begin
		INSERT INTO ODSControlData (ApplicationId,DataFileTypeId,BillingSubSystemId,LoadDate,ExtractDate,SnapshotDate,User01,User02,User03)
			values ('1', '3', '31', @dForcedSnapshotDate, @dForcedSnapshotDate, @dForcedSnapshotDate, 0, 0, 0);
		print 'ODSControlData created for [SCODS-RC]..ODSCustomerSnapshot & BSSID: 31';	
	end;

	/*
		Create ODSControlData for BSSID 32 if there is data for it for [SCODS-RC]..ODSServicePackageSnapshot
	*/

	select @iRecordCount =  COUNT(0) from [SCODS-RC]..ODSServicePackageSnapshot where SnapshotDate = @dForcedSnapshotDate and BillingSubSystemId = '32';
	if @iRecordCount > 0
	begin
		INSERT INTO ODSControlData (ApplicationId,DataFileTypeId,BillingSubSystemId,LoadDate,ExtractDate,SnapshotDate,User01,User02,User03)
			values ('1', '3', '32', @dForcedSnapshotDate, @dForcedSnapshotDate, @dForcedSnapshotDate, 0, 0, 0);
		print 'ODSControlData created for [SCODS-RC]..ODSCustomerSnapshot & BSSID: 32';	
	end;

	/* Setup the ODSControlDate [END]*/	
	
	-- Increment the Counter
	select @iCount = @iCount + 1;
end;
