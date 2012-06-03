USE [SCLoad]
GO
/****** Object:  StoredProcedure [dbo].[RUL_INPT_0450_ServFeatStatus]    Script Date: 11/28/2011 20:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE	PROCEDURE [dbo].[RUL_INPT_0450_ServFeatStatus]
			@nProcessKey                              numeric
AS 
		
--========================================================================================================================================
-- Description:
--
-- Change History:	
-- SH20101005	New for Blizoo --need logic confirmed for Revenue/Segment.
-- SH20110405:  Changed pushing down address from Service to Feature from user20 to User21 since User20 is used for OrigBillingSystemStatus
-- SH20110412:	Add push down of feed channel, sales person and supervisor from service to feature
-- SH20110512:  Redo rankings for Payment Status due to dimension change
-- SH20110526:	CR001 and CR-002: Changes for RC/EK Merge and Non-Revenue services
-- SH20110813:	CR-012 Push User25 Revenue Type up from service package to customer instead of IsRevenue flag.
-- SH20110813:  CR-014 Any customers with no RGUs will be cancelled. Create fail safe to exit if Level 02 RGU is not in DPRAH.
-- SH20110813:  CR-011 Add new deactivation type for temporary churn.
-- SH20110916:	Move Customer and CableHouse population from Input 170. Exclude pending and canceled pendings or "new" metric doesn't 
--				calculate correctly when it activates	
-- SH20110921:	CR-014 change in how we push up status for customers with no active RGUs
-- SH20111014:	CR-014 change in how we push up status for customers with no active RGUs and Pending RGUs - Set customer to P even
--				if we have other Active non-RGU services
-- HK20111101 Push the max service commitements from the feature level to the service level.
-- HK20111117 restricting pushing up the values on the RGU services only.
-- PD20111128:  Ensure we count correct "Connect" metric when processing False Churn.  If we connected as a New Connect and now it's being
--              reversed because of False Churn, we want to reverse "NewConnect", not "MoveReconnect".  This means we have to save AccountNumber
--              and ServiceNumber as key of SCODS.CustomerNumber.
-- HK20111202 Changing the ranking criteria for the last payment date/type to use the
-- UserUser02 from the DimUserReportingAllHistory
--=========================================================================================================================================

DECLARE @iError                                INTEGER 
DECLARE @bError									BIT
DECLARE @cMessage                                 VARCHAR(250) 
DECLARE @cSPName                                  VARCHAR(50) 
DECLARE @iCount                                   INTEGER 
DECLARE @nStartTime                               DATETIME 
DECLARE @nEndTime                                 DATETIME 
DECLARE @nCHKPTime                                DATETIME 
DECLARE @nDateKey                                 numeric(8) 
DECLARE @nBatchKey                                numeric(8) 
DECLARE @nDateKeyMax                              numeric(8) 
DECLARE @bDisableFutureDating                     BIT 
DECLARE @bInitFlag                                INTEGER 
--MW20050323

DECLARE @bRC                                      BIT 
DECLARE @iRC                                      INT
DECLARE @dChangeDate							  datetime
DECLARE @iLevelCount							  INT

BEGIN
SET NOCOUNT ON

--==========================================================================================================================================
-- Set program defaults
		
    	SET @bError  = 0
    	SET @cSPName  = dbo.UTL_Get_ProcName (@@Procid)
		SELECT @nStartTime  = GETDATE() 
		--==========================================================================================================================================
		-- Write out Starting Message
		
		EXEC @iRC = RTF_RunTimeParameter_Get @nProcessKey, @nBatchKey  OUTPUT, 'BatchKey'
		EXEC @iRC = RTF_RunTimeParameter_Get @nProcessKey, @nDateKey  OUTPUT, 'DateKey'
		EXEC @iRC = RTF_RunTimeParameter_Get @nProcessKey, @nDateKeyMax  OUTPUT, 'DateKeyMax'
		EXEC @iRC = RTF_RunTimeParameter_Get @nProcessKey, @bInitFlag  OUTPUT, 'InitFlag'
    	SET @dChangeDate = dbo.RTF_Get_Date (@nDateKey)
    
		SET @cMessage  = 'Starting - ' + cast(@nDateKey as varchar) + '/' + convert(varchar,@dChangeDate,105 )+ '/' + cast(@nBatchKey as varchar)
    	EXEC RTF_ProcessMessage_Add 'I', 0, @cMessage, @cSPName, @nProcessKey, 0   
		SELECT @nCHKPTime  = GETDATE() 
		--==================================================================================================================================

		--Push Fields Down From Service to Feature
				
		UPDATE icf 		
		SET RegionCode = ics.RegionCode
			,SegmentCode = ics.SegmentCode
			,RatePlanCode = ics.RatePlanCode --Customer Relationship
			,User23 = ics.User03 --Technical Region
			,User21 = ics.Address --Address for MoveConnects and NewCustomerReconnects  SH20110405 Changed from user20 used for OrigBillingSystemStatus
			,User13 = ics.User13 --SalesRep
			,User14 = ics.User14 --Sales Supervisor
			,ChannelCode = ics.ChannelCode
			,User15 = ics.User22 --FeedChannelCode
			,User16 = ics.User23 --FeedSupervisorCode
			,User17 = ics.User25 --FeedSalesPersonCode

		FROM
			SCRules..InputChangedFeature icf
		INNER JOIN
			SCRules..INPUTCHANGEDSERVICE ics
		ON
			icf.BillingSubSystemId = ics.BillingSubSystemId
			AND icf.AccountNumber = ics.AccountNumber
			AND icf.ServiceNumber = ics.ServiceNumber								

    	SELECT @iError = @@Error, @iCount = @@RowCount
    	if @iError <> 0 begin
    		set @bError = 1
    		SET @cMessage = 'FAILED: Update InputChangedFeature From Service'
    		exec RTF_ProcessMessage_Add 'E', @iError, @cMessage, @cSPName, @nProcessKey, 0
    		goto ExitProcedure
    	end 

		
		SELECT @cMessage  = 'CHKP 01' 
		SELECT @nEndTime  = GETDATE() 
		EXEC RTF_ProcessMessage_RunTime   @nCHKPTime  ,  @nEndTime  ,  @cMessage  ,  @cSPName  ,  @nProcessKey   
		SELECT @nCHKPTime  = GETDATE() 

		--==================================================================================================================================
		
-- SH20110813: CR-014 Any customers with no RGUs will be cancelled. Create fail safe to exit if Level 02 RGU is not in DPRAH.

	SET @iLevelCount = (SELECT COUNT(distinct Gen02LongName) FROM SCRules..DimProductReportingAllHistory WHERE Gen02LongName = 'RGU')

    	SELECT @iError = @@Error, @iCount = @@RowCount
    	if @iError <> 0 
    	begin
    		set @bError = 1
    		SET @cMessage = 'FAILED: RGU Level Validation'
    		exec RTF_ProcessMessage_Add 'E', @iError, @cMessage, @cSPName, @nProcessKey, 0
    		goto ExitProcedure
    	end 
	

		-- Push status code up from Feature to Service Level based on ranking of Feature Status Codes

		UPDATE ics
		SET StatusCode = ISNULL(icf.StatusCode,'C') 
		FROM SCRules..InputChangedService ics
		LEFT OUTER JOIN	(
			SELECT
			DateKey,
			icf.billingsubsystemid,
			icf.accountnumber,
			icf.servicenumber,
			icf.statuscode,
			icf.DateKeyDeactivation,
			row_number() over (
			partition by datekey, icf.billingsubsystemid, icf.accountnumber, icf.servicenumber 
					order by case when statuscode = 'A' then 10
						  when statuscode = 'S' then 20
						  when statuscode = 'F' then 30
						  when statuscode = 'P' then 40
						  when statuscode = 'C' then 50
						  when statuscode = 'N' then 60
						  when statuscode = 'D' then 70
							ELSE 100						  
					 end
		) as rownumb
		from SCRules..InputChangedFeature icf
		INNER JOIN SCRules..DimProductReportingAllHistory dprah
		ON icf.FeatureCode = dprah.BillCode
		WHERE
		--icf.StatusCode IN ('A','S','F','P','D')
		dprah.Gen02LongName = 'RGU'
		AND dprah.DateKeyEnd = @nDateKeyMax

		) icf
		on ics.billingsubsystemid = icf.billingsubsystemid 
		and ics.accountnumber = icf.accountnumber 
		and ics.servicenumber = icf.servicenumber 
		and ics.datekey = icf.datekey 
		and icf.rownumb = 1

    	SELECT @iError = @@Error, @iCount = @@RowCount
    	if @iError <> 0 begin
    		set @bError = 1
    		SET @cMessage = 'FAILED: Update InputChangedService Status'
    		exec RTF_ProcessMessage_Add 'E', @iError, @cMessage, @cSPName, @nProcessKey, 0
    		goto ExitProcedure
    	end 

		SELECT @cMessage  = 'CHKP 02' 
		SELECT @nEndTime  = GETDATE() 
		EXEC RTF_ProcessMessage_RunTime   @nCHKPTime  ,  @nEndTime  ,  @cMessage  ,  @cSPName  ,  @nProcessKey   
		SELECT @nCHKPTime  = GETDATE() 
		
		------------------------------------------------------------------------------------------------------------------------	
		-- Customer table population
		-- delete all records for processdate >= changedate

		DELETE FROM SCODS..CustomerNumber 
		WHERE ProcessedDate >= @dChangeDate

	    INSERT
		INTO SCODS..CustomerNumber
			(BillingSubSystemId --SH20110401
			, CustomerId
			, ProcessedDate
			)
		SELECT DISTINCT
			inp.BillingSubSystemId  --SH20110401
			, inp.AccountNumber --inp.Address	--SH20110620		
			, @dChangeDate

		FROM 
			SCRULES..InputChangedService inp
			
		INNER JOIN
			SCRULES..GlobalDateSmall actdt
		ON 
			inp.DateKeyActivation = actdt.ChangeDate
			
	    LEFT OUTER JOIN 
			SCODS..CustomerNumber ch
	    ON 
			--inp.Address = ch.CustomerId
			inp.AccountNumber = ch.CustomerId --SH20110620
			AND inp.BillingSubSystemId = ch.BillingSubSystemId --SH20110401
			

	    WHERE 
			ch.CustomerId IS NULL
			--AND inp.Address IS NOT NULL
			AND inp.AccountNumber IS NOT NULL  --SH20110620
			AND inp.StatusCode NOT IN ('P', 'D')  --SH20110916: Don't insert pending houses or "new" metric doesn't calculate correctly when it activates	
	

		SELECT @iError = @@Error, @iCount = @@RowCount
		if @iError <> 0 begin
			set @bError = 1
			SET @cMessage = 'FAILED: Insert into SCODS..CustomerNumber'
			exec RTF_ProcessMessage_Add 'E', @iError, @cMessage,@cSPName,@nProcessKey,0
			goto ExitProcedure
		end 
		 

		SET @cMessage  = 'CHKP 03 - RowCount: ' + rtrim(@iCount)
		SET @nEndTime  = GETDATE() 
		EXEC RTF_ProcessMessage_RunTime @nCHKPTime,@nEndTime,@cMessage,@cSPName,@nProcessKey   
		SET @nCHKPTime  = GETDATE()
		


	------------------------------------------------------------------------------------------------------------------------	
			-- HOUSE table population

			DELETE FROM SCODS..CableHouse 
			WHERE ProcessedDate >= @dChangeDate;

			INSERT
			INTO SCODS..CableHouse
				(BillingSubSystemId --SH20110401
				, HouseKey
				, ProcessedDate
				)
			SELECT DISTINCT
				inp.BillingSubSystemId  --SH20110401
				, inp.Address		--inp.AccountNumber		--SH 20110620
				, @dChangeDate

			FROM 
				SCRULES..InputChangedService inp
			LEFT OUTER JOIN 
				SCODS..CableHouse ch
			ON 
				--inp.AccountNumber = ch.HouseKey
				inp.Address = ch.HouseKey --SH 20110620
				AND inp.BillingSubSystemId = ch.BillingSubSystemId --SH20110401			

			WHERE 
				ch.HouseKey IS NULL
				--AND inp.AccountNumber IS NOT NULL
				AND inp.Address IS NOT NULL--SH 20110620
				AND inp.StatusCode NOT IN ('P', 'D')  --SH20110916: Don't insert pending houses or "new" metric doesn't calculate correctly when it activates

			


		SELECT @iError = @@Error, @iCount = @@RowCount
		if @iError <> 0 begin
			set @bError = 1
			SET @cMessage = 'FAILED: Insert into SCODS..CableHouse'
			exec RTF_ProcessMessage_Add 'E', @iError, @cMessage,@cSPName,@nProcessKey,0
			goto ExitProcedure
		end 
		 

		SET @cMessage  = 'CHKP 04 - RowCount: ' + rtrim(@iCount)
		SET @nEndTime  = GETDATE() 
		EXEC RTF_ProcessMessage_RunTime @nCHKPTime,@nEndTime,@cMessage,@cSPName,@nProcessKey   
		SET @nCHKPTime  = GETDATE()
		

		--==================================================================================================================================			
		
		-- Push DeactivatingReasonTypeId up from Feature to Service Level
		
		--DeactivatingReasonTypeId - if customer has any canceled services with Involuntary DeactivatingReasonTypeId 
		--and customer is canceled today, set customer DeactivatingReasonTypeId = 2 
		--if there's an active services default to 1
		-- HK20111117 restriciting the pushed up values to RGU services only
	
		IF @bInitFlag = 1 BEGIN				
		
		UPDATE ics
		SET DeactivatingReasonTypeId = ISNULL(icf.DeactivatingReasonTypeId, 1)
			,DateKeyDeactivation =icf.DateKeyDeactivation
		FROM SCRules..InputChangedService ics
		LEFT OUTER JOIN	(
			SELECT
			DateKey,
			icf.BillingSubSystemId,
			accountnumber,
			servicenumber,
			StatusCode,
			DeactivatingReasonTypeId,
			DateKeyDeactivation,
			row_number() over (
			partition by datekey, icf.billingsubsystemid, accountnumber, servicenumber 
					order by --case when DeactivatingReasonTypeId = 2 then 1
							DateKeyDeactivation desc, case when DeactivatingReasonTypeId = 2 then 1 -- most recent cancelled record
							--ELSE 2						  
							when DeactivatingReasonTypeId = 3 then 2 --SH20110813 CR-011 Add new deactivation type.
							ELSE 3
					 end
		) as rownumb
		from SCRules..InputChangedFeature icf
		INNER JOIN SCRules..DimProductReportingAllHistory dprah
		ON icf.FeatureCode = dprah.BillCode
		where icf.StatusCode in ('N', 'C')
		and dprah.Gen02LongName = 'RGU'
		and dprah.DateKeyEnd = @nDateKeyMax
		) icf
		on ics.billingsubsystemid = icf.billingsubsystemid 
		and ics.accountnumber = icf.accountnumber 
		and ics.servicenumber = icf.servicenumber 
		and ics.datekey = icf.datekey 
		and icf.rownumb = 1
		where ics.StatusCode in ('C','N') 
		
		END
		
		ELSE BEGIN
		
		UPDATE ics
		SET 
			DeactivatingReasonTypeId = ISNULL(icf.DeactivatingReasonTypeId, 1) 
			,DateKeyDeactivation = @nDateKey --SH20101116
		FROM SCRules..InputChangedService ics
		LEFT OUTER JOIN	(
			SELECT
			DateKey,
			icf.BillingSubSystemId,
			accountnumber,
			servicenumber,
			StatusCode,
			DeactivatingReasonTypeId,
			DateKeyDeactivation,
			row_number() over (
			partition by datekey, icf.billingsubsystemid, accountnumber, servicenumber 
					order by --case when DeactivatingReasonTypeId = 2 then 1
							DateKeyDeactivation desc, case when DeactivatingReasonTypeId = 2 then 1 -- most recent cancelled record
							--ELSE 2						  
							when DeactivatingReasonTypeId = 3 then 2 --SH20110813 CR-011 Add new deactivation type.
							ELSE 3
					 end
		) as rownumb
		from SCRules..InputChangedFeature icf
		INNER JOIN SCRules..DimProductReportingAllHistory dprah
		ON icf.FeatureCode = dprah.BillCode
		where icf.StatusCode in ('N', 'C') --feature cancelled today
		AND icf.PreExistingFlag = 1 --SH20101116 - active yesterday
		AND dprah.Gen02LongName = 'RGU'
		AND dprah.DateKeyEnd = @nDateKeyMax
		) icf
		on ics.billingsubsystemid = icf.billingsubsystemid 
		and ics.accountnumber = icf.accountnumber 
		and ics.servicenumber = icf.servicenumber 
		and ics.datekey = icf.datekey 
		and icf.rownumb = 1

		where ics.StatusCode in ('C','N') 		
		
		END
		
		

    	SELECT @iError = @@Error, @iCount = @@RowCount
    	if @iError <> 0 begin
    		set @bError = 1
    		SET @cMessage = 'FAILED: Update InputChangedService DeactReasonTypeId'
    		exec RTF_ProcessMessage_Add 'E', @iError, @cMessage, @cSPName, @nProcessKey, 0
    		goto ExitProcedure
    	end 

		
		SELECT @cMessage  = 'CHKP 03' 
		SELECT @nEndTime  = GETDATE() 
		EXEC RTF_ProcessMessage_RunTime   @nCHKPTime  ,  @nEndTime  ,  @cMessage  ,  @cSPName  ,  @nProcessKey   
		SELECT @nCHKPTime  = GETDATE() 


		--==================================================================================================================================			
			
		-- Push Max Payment Status up from Feature to Service Level	
		-- HK20111117 restricting pushing up the values on the RGU services only.
			
		UPDATE ics
		SET User08 = icf.User08
		FROM SCRules..InputChangedService ics
		INNER JOIN	(
			SELECT
			DateKey,
			icf.BillingSubSystemId,
			accountnumber,
			servicenumber,
			StatusCode,
			User08,
			row_number() over (
			partition by datekey, icf.billingsubsystemid, accountnumber, servicenumber 
					order by /*case when LEFT(User08,1) = '0' then 1
					when RIGHT(User08,1) = '1' then 2
					when RIGHT(User08,1) = '2' then 3
					when RIGHT(User08,1) = '3' then 4
							ELSE CAST(LEFT(User08,1) AS INT) + 1  --to allow for additional values just in case additional buckets are created later.*/
					CASE 		--SH20110512 Payment Status dimesnion change
						 WHEN User08 = 'Prepaid' THEN 1 
						 WHEN User08 = 'Unknown' THEN 99
						 ELSE CAST(User08 AS INT)  END
		) as rownumb
		from SCRules..InputChangedFeature icf
		INNER JOIN SCRules..DimProductReportingAllHistory dprah
		ON icf.FeatureCode = dprah.BillCode		
		where icf.StatusCode in ('A', 'S', 'F') -- only do this for active
		and dprah.Gen02LongName = 'RGU'
		and dprah.DateKeyEnd = @nDateKeyMax	
		) icf
		on ics.billingsubsystemid = icf.billingsubsystemid 
		and ics.accountnumber = icf.accountnumber 
		and ics.servicenumber = icf.servicenumber 
		and ics.datekey = icf.datekey 
		and icf.rownumb = 1


    	SELECT @iError = @@Error, @iCount = @@RowCount
    	if @iError <> 0 begin
    		set @bError = 1
    		SET @cMessage = 'FAILED: Update InputChangedService Payment Status'
    		exec RTF_ProcessMessage_Add 'E', @iError, @cMessage, @cSPName, @nProcessKey, 0
    		goto ExitProcedure
    	end 

		
		SELECT @cMessage  = 'CHKP 04' 
		SELECT @nEndTime  = GETDATE() 
		EXEC RTF_ProcessMessage_RunTime   @nCHKPTime  ,  @nEndTime  ,  @cMessage  ,  @cSPName  ,  @nProcessKey   
		SELECT @nCHKPTime  = GETDATE() 
				
				

		--==================================================================================================================================
		
		-- HK-TEST insert data into some temp table prior to the update for testing purposes[START]
		select ics.* into scload..tmp_hk_last_payment_date_type
		from SCRules..InputChangedService ics
		INNER JOIN	(
			SELECT
			DateKey,
			icf.billingsubsystemid,
			accountnumber,
			servicenumber,
			StatusCode,
			User11,
			User09,
			durah.UserUser02,
			durah.Gen02LongName,
			durah.UserCode as "Durah_UserCode",
			row_number() over (
			partition by datekey, icf.billingsubsystemid, accountnumber, servicenumber 
					order by User11 desc, durah.UserUser02

		) as rownumb
		from SCRules..InputChangedFeature icf
		inner join SCRules..DimProductReportingAllHistory dprah
		on icf.FeatureCode = dprah.BillCode
		inner join ScRules..DimUserReportingAllHistory durah
		on icf.User09 = durah.UserCode
		where icf.StatusCode in ('A', 'S', 'F')
		and dprah.Gen02LongName = 'RGU'
		and dprah.DateKeyEnd = @nDateKeyMax
		and durah.DateKeyEnd = @nDateKeyMax
		and durah.DimensionId = 3
		) icf
		on ics.billingsubsystemid = icf.billingsubsystemid 
		and ics.accountnumber = icf.accountnumber 
		and ics.servicenumber = icf.servicenumber 
		and ics.datekey = icf.datekey 
		and icf.rownumb = 1
		-- HK-TEST insert data into some temp table prior to the update for testing purposes[END]
		
		-- Push Last Payment Date and Type up from Feature to Service Level
		-- HK20111117 restricting pushing up the values on the RGU services only.				
		-- HK20111202 Changing the ranking criteria for the last payment date/type to use the
		-- UserUser02 from the DimUserReportingAllHistory
		UPDATE ics
		SET User12 = icf.User11,
			User09 = icf.User09
		FROM SCRules..InputChangedService ics
		INNER JOIN	(
			SELECT
			DateKey,
			icf.billingsubsystemid,
			accountnumber,
			servicenumber,
			StatusCode,
			User11,
			User09,
			durah.UserUser02,
			durah.Gen02LongName,
			durah.UserCode as "Durah_UserCode",
			row_number() over (
			partition by datekey, icf.billingsubsystemid, accountnumber, servicenumber 
					order by User11 desc, durah.UserUser02

		) as rownumb
		from SCRules..InputChangedFeature icf
		inner join SCRules..DimProductReportingAllHistory dprah
		on icf.FeatureCode = dprah.BillCode
		inner join ScRules..DimUserReportingAllHistory durah
		on icf.User09 = durah.UserCode
		where icf.StatusCode in ('A', 'S', 'F')
		and dprah.Gen02LongName = 'RGU'
		and dprah.DateKeyEnd = @nDateKeyMax
		and durah.DateKeyEnd = @nDateKeyMax
		and durah.DimensionId = 3
		) icf
		on ics.billingsubsystemid = icf.billingsubsystemid 
		and ics.accountnumber = icf.accountnumber 
		and ics.servicenumber = icf.servicenumber 
		and ics.datekey = icf.datekey 
		and icf.rownumb = 1

    	SELECT @iError = @@Error, @iCount = @@RowCount
    	if @iError <> 0 begin
    		set @bError = 1
    		SET @cMessage = 'FAILED: Update InputChangedServoce Payment Date/Type'
    		exec RTF_ProcessMessage_Add 'E', @iError, @cMessage, @cSPName, @nProcessKey, 0
    		goto ExitProcedure
    	end 

		
		SELECT @cMessage  = 'CHKP 05' 
		SELECT @nEndTime  = GETDATE() 
		EXEC RTF_ProcessMessage_RunTime   @nCHKPTime  ,  @nEndTime  ,  @cMessage  ,  @cSPName  ,  @nProcessKey   
		SELECT @nCHKPTime  = GETDATE()
		
		--==================================================================================================================================			
		
 		-- Push Campaign code up from Feature to Service Level
 		--NOTE: Allow updates on Canceled records in INIT and then only Active
 		-- HK20111117 restricting pushing up the values on the RGU services only.

 		IF @bInitFlag = 1 BEGIN 		
		
		UPDATE ics
		SET CampaignCode = icf.CampaignCode
		FROM SCRules..InputChangedService ics
		LEFT OUTER JOIN	(
			SELECT
			DateKey,
			icf.BillingSubSystemId,
			accountnumber,
			servicenumber,
			statuscode,
			CampaignCode,
			row_number() over (
			partition by datekey, icf.billingsubsystemid, accountnumber, servicenumber
					order by DateKeyActivation desc, CampaignCode desc					  
		) as rownumb
		from SCRules..InputChangedFeature icf
		inner join SCRules..DimProductReportingAllHistory dprah
		ON icf.FeatureCode = dprah.BillCode
		WHERE icf.CampaignCode is not null
		and dprah.Gen02LongName = 'RGU'
		AND dprah.DateKeyEnd = @nDateKeyMax
		) icf
		on ics.billingsubsystemid = icf.billingsubsystemid 
		and ics.accountnumber = icf.accountnumber 
		and ics.servicenumber = icf.servicenumber 
		and ics.datekey = icf.datekey 
		and icf.rownumb = 1
		
		END
		
		ELSE BEGIN		
		
		UPDATE ics
		SET CampaignCode = icf.CampaignCode
		FROM SCRules..InputChangedService ics
		LEFT OUTER JOIN	(
			SELECT
			DateKey,
			icf.BillingSubSystemId,
			accountnumber,
			servicenumber,
			statuscode,
			CampaignCode,
			row_number() over (
			partition by datekey, icf.billingsubsystemid, accountnumber, servicenumber 
					order by DateKeyActivation desc, CampaignCode desc						  
		) as rownumb
		from SCRules..InputChangedFeature icf
		INNER JOIN SCRules..DimProductReportingAllHistory dprah
		ON icf.FeatureCode = dprah.BillCode
		WHERE icf.CampaignCode is not null
		AND icf.StatusCode IN ('A','S','F')   -- only do this for active
		and dprah.Gen02LongName = 'RGU'
		AND dprah.DateKeyEnd = @nDateKeyMax
		) icf
		on ics.billingsubsystemid = icf.billingsubsystemid 
		and ics.accountnumber = icf.accountnumber 
		and ics.servicenumber = icf.servicenumber 
		and ics.datekey = icf.datekey 
		and icf.rownumb = 1
	
		END


    	SELECT @iError = @@Error, @iCount = @@RowCount
    	if @iError <> 0 begin
    		set @bError = 1
    		SET @cMessage = 'FAILED: Update InputChangedService CampaignCode'
    		exec RTF_ProcessMessage_Add 'E', @iError, @cMessage, @cSPName, @nProcessKey, 0
    		goto ExitProcedure
    	end 
    		
		SELECT @cMessage  = 'CHKP 06' 
		SELECT @nEndTime  = GETDATE() 
		EXEC RTF_ProcessMessage_RunTime   @nCHKPTime  ,  @nEndTime  ,  @cMessage  ,  @cSPName  ,  @nProcessKey   
		SELECT @nCHKPTime  = GETDATE()
    	

		--==================================================================================================================================
		
		-- SH20110526: Push Revenue Flag up from Feature to Service Level - If Service has at least 1 Paid Service, set Customer IsRevenueFlag = 1
		-- SH20110813:	CR-012 Push User25 Revenue Type up from service package to customer instead of IsRevenue flag.
		-- HK20111117 restricting pushing up the values on the RGU services only.
				
		
		UPDATE ics
		SET User18 = ISNULL(icf.User25,0) --IsRevenueFlag = ISNULL(icf.IsRevenueFlag,0) 
		FROM SCRules..InputChangedService ics
		LEFT OUTER JOIN	(
			SELECT
			DateKey,
			icf.BillingSubSystemId,
			accountnumber,
			servicenumber,
			--IsRevenueFlag,
			User25,
			row_number() over (
			partition by datekey, icf.billingsubsystemid, accountnumber, servicenumber 
					order by User25 desc --IsRevenueFlag desc	  
		) as rownumb
		from SCRules..InputChangedFeature icf
		INNER JOIN SCRules..DimProductReportingAllHistory dprah
		ON icf.FeatureCode = dprah.BillCode
		where icf.StatusCode IN ('A', 'S', 'F')
		AND dprah.Gen02LongName = 'RGU'
		AND dprah.DateKeyEnd = @nDateKeyMax
		) icf
		on ics.billingsubsystemid = icf.billingsubsystemid 
		and ics.accountnumber = icf.accountnumber 
		and ics.servicenumber = icf.servicenumber 
		and ics.datekey = icf.datekey 
		and icf.rownumb = 1



    	SELECT @iError = @@Error, @iCount = @@RowCount
    	if @iError <> 0 begin
    		set @bError = 1
    		SET @cMessage = 'FAILED: Update InputChangedService IsRevenueFlag'
    		exec RTF_ProcessMessage_Add 'E', @iError, @cMessage, @cSPName, @nProcessKey, 0
    		goto ExitProcedure
    	end 

		
		SELECT @cMessage  = 'CHKP 07' 
		SELECT @nEndTime  = GETDATE() 
		EXEC RTF_ProcessMessage_RunTime   @nCHKPTime  ,  @nEndTime  ,  @cMessage  ,  @cSPName  ,  @nProcessKey   
		SELECT @nCHKPTime  = GETDATE()

		
--==========================================================================================================================================

--
-- HK20111101 Push the max service commitements from the feature level to the service level.
-- HK20111117 restricting pushing up the values on the RGU services only.

UPDATE ics
		SET User17 = icf.User10
		FROM SCRules..InputChangedService ics
		LEFT OUTER JOIN	(
			SELECT
			DateKey,
			icf.billingsubsystemid,
			accountnumber,
			servicenumber,
			User10,
			row_number() over (
			partition by datekey, icf.billingsubsystemid, accountnumber, servicenumber 
					order by User10 desc  
		) as rownumb
		from SCRules..InputChangedFeature icf
		INNER JOIN SCRules..DimProductReportingAllHistory dprah
		ON icf.FeatureCode = dprah.BillCode
		where StatusCode IN ('A', 'S', 'F')
		AND dprah.Gen02LongName = 'RGU'
		AND dprah.DateKeyEnd = @nDateKeyMax
		) icf
		on ics.billingsubsystemid = icf.billingsubsystemid 
		and ics.accountnumber = icf.accountnumber 
		and ics.servicenumber = icf.servicenumber 
		and ics.datekey = icf.datekey 
		and icf.rownumb = 1



    	SELECT @iError = @@Error, @iCount = @@RowCount
    	if @iError <> 0 begin
    		set @bError = 1
    		SET @cMessage = 'FAILED: Update InputChangedService IsRevenueFlag'
    		exec RTF_ProcessMessage_Add 'E', @iError, @cMessage, @cSPName, @nProcessKey, 0
    		goto ExitProcedure
    	end 

		
		SELECT @cMessage  = 'CHKP 08' 
		SELECT @nEndTime  = GETDATE() 
		EXEC RTF_ProcessMessage_RunTime   @nCHKPTime  ,  @nEndTime  ,  @cMessage  ,  @cSPName  ,  @nProcessKey
		SELECT @nCHKPTime  = GETDATE()		

--==========================================================================================================================================		
ExitProcedure:

	if @bError = 1 
		set @cMessage  = 'FAILED RUN TIME' 
	ELSE 
		set @cMessage  = 'TOTAL RUN TIME' 

	SELECT @nEndTime  = GETDATE() 
	EXEC RTF_ProcessMessage_RunTime @nStartTime, @nEndTime, @cMessage, @cSPName, @nProcessKey   
	
	RETURN (@bError )

	SET NOCOUNT OFF

END