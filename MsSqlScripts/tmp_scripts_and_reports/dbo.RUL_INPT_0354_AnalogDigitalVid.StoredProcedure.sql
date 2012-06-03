USE [SCLoad]
GO
/****** Object:  StoredProcedure [dbo].[RUL_INPT_0354_AnalogDigitalVid]    Script Date: 09/17/2011 23:09:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE                        PROCEDURE [dbo].[RUL_INPT_0354_AnalogDigitalVid]

    @nProcessKey                              numeric
AS 

--======================================================================================================================
-- Description:
--
-- Change History:
-- SH20101026:	Custom Proc to Remove Analog Video codes (or deactivate) from input tables if both an Analog and Digital Video code exist.
-- SH20101116:	Modify to use new Preexisting Flag from InputChangedFeature. 
--				Records that are brought into InputChangedFeature via Inpt 350 have PreExistingFlag = 1 
--				Records that are inserted into InputChangedFeature via Inpt 170 have PreExistingFlag = 0 
-- SH20101129:	Move update to set PreExistingFlag = 1 from Input 0350 to this proc
-- SH20110212:	Add tmp_sh_INPT_0354_AnalogDigitalVidCancel insert for balancing ods to state and add init pass
-- SH20110305:  Remove init pass comment out criteria where AND COALESCE(icf.PreExistingFlag,0) = 0 --digital did not exist yesterday
--				as this scenario should not occur
-- HK20112214 Prior to the deletion of the non-pre-existing active analog features with active digital features, we
-- have to transfer any revenue information they contain to their corresponding digital features.
/*
2 statements, 1 update statement and 1 delete statement that takes the PreExistingFlag into account. 
	--If new Active Analog Code and existing Active Digital code, delete the Analog Code 
	--If new Active Analog Code and new Active Digital Code, delete the Analog Code 
	--If existing Active Analog Code and new Active Digital Code, update Analog Code to Cancel. 
	--If existing Active Analog Code and existing Active Digital Code – THIS SHOULD NEVER HAPPEN – WE NEED TO CREATE A QA Test for this. 

Those Boil Down to TWO STATEMENTS:

	1. If new Active Analog Code and Active Digital Code, delete the Analog Code 
	2. If Existing Active Analog Code and Active Digital Code, update the Analog Code 
 
Verify these cases:
Yesterday we have Digital Active

Today is Trueup Day, we can have 2 things happen: 1) Digital drops off, no “C” record sent, 2) “C” cancel record sent in for Digital

1)       Digital Drops off, no “C” record sent
We are ok as the code would only see Analog in the InputChangedFeature table, this will be allowed to flow through to the state table.
The Digital Code will get cancelled automatically by the engine.  We should see a Downgrade for Activity as moving from Digital to Analog.

2)       “C” cancel record sent in for Digital
We will allow the Analog Code to flow through to State table as we have an active Analog and a cancelled Digital code.
*/

-- SH20110813: Remove joins to BillingSubsystemID in DimProductReportingAllHistory as no longer used in DPRAH
--======================================================================================================================

SET NOCOUNT ON

DECLARE @iError                             INTEGER 
DECLARE @bError                             BIT
DECLARE @cMessage                           VARCHAR(250) 
DECLARE @cSPName                            VARCHAR(50) 
DECLARE @iCount                             INTEGER 
DECLARE @nStartTime                         DATETIME 
DECLARE @nEndTime                           DATETIME 
DECLARE @nCHKPTime                          DATETIME 
DECLARE @nDateKey                           NUMERIC 
DECLARE @nBatchKey                          NUMERIC 
DECLARE @dChangeDate                        datetime
DECLARE @iIsTrueup                          NUMERIC 
DECLARE @iInitFlag                          NUMERIC 
DECLARE @nDateKeyMax                        NUMERIC 
DECLARE @iRC								INT
DECLARE @iLevelCount						INT

BEGIN
--======================================================================================================================
-- Set program defaults
    
    SET @bError  = 0
    SET @cSPName  = dbo.UTL_Get_ProcName (@@Procid)
    SET @nStartTime  = GETDATE() 

--======================================================================================================================
    
	EXEC @iRC = RTF_RunTimeParameter_Get @nProcessKey, @nDateKeyMax OUTPUT, 'DateKeyMax'
	EXEC @iRC = RTF_RunTimeParameter_Get @nProcessKey, @iInitFlag OUTPUT, 'InitFlag'
	EXEC @iRC = RTF_RunTimeParameter_Get @nProcessKey, @nBatchKey OUTPUT, 'BatchKey'
	EXEC @iRC = RTF_RunTimeParameter_Get @nProcessKey, @nDateKey OUTPUT, 'DateKey'
	EXEC @iRC = RTF_RunTimeParameter_Get @nProcessKey, @iIsTrueup OUTPUT, 'IsTrueup'
	SET @dChangeDate = dbo.RTF_Get_Date (@nDateKey)


    SET @cMessage  = 'Starting - ' + cast(@nDateKey as varchar) + '/' + convert(varchar,@dChangeDate,105 )+ '/' + cast(@nBatchKey as varchar)
    EXEC RTF_ProcessMessage_Add 'I',0,@cMessage,@cSPName,@nProcessKey,0   
    SET @nCHKPTime  = GETDATE()

--======================================================================================================================

--	We have to identify the Analog and Digital Parents: 
	--Explicity look for LevelLongNames “Analog” or “Digital” in DimProductLevel so we can get the level id/name (think we would just want to make sure the name exists as that is what is in DimFeature.) 
	--If we don’t find the particular names we’ve/they’ve setup, we error out the run.  


	SET @iLevelCount = (SELECT COUNT(distinct Gen05LongName) FROM SCRules..DimProductReportingAllHistory WHERE Gen05LongName IN ('Analog','Digital Full', 'Digital Basic', 'Digital Start'))

		if @iLevelCount <> 4 begin
			set @bError = 1
			SET @cMessage = 'FAILED: Level Does Not Exist'
			exec RTF_ProcessMessage_Add 'E', @iError, @cMessage,@cSPName,@nProcessKey,0
			goto ExitProcedure
		END 

		

------------------------------------------------------------------------------------------------------------------------------------------
--SH20101124  Set the Preexisting flag for cases where the Feature was active yesterday, but is in the snapshot today so we can Cancel rather than Delete
--			 Also sets flag for cases where inserts are made from RUL_INPT_0300_FeatFutureDating which is after the flags are set in Input 350.
--			 This also updates the Preexisting for cases where inserts were done in RUL_INPT_0300_FeatFutureDating but may have already been Active
--			 This may be resolved as status code issues get resolved. Also used in Input 450 for pushing up DeactivatingReasonTypeId to Service.

--If @iInitFlag = 0 BEGIN
			
		UPDATE 
			icf 
		SET
			icf.PREEXISTINGFLAG = 1
		FROM 
			SCRules..INPUTCHANGEDFEATURE icf
		INNER JOIN
			SCRules..StateFeatureDimension  sfd
		ON 	icf.BillingSubSystemId = sfd.BillingSubSystemId
		AND icf.AccountNumber = sfd.AccountNumber
		AND icf.ServiceNumber = sfd.ServiceNumber
		AND icf.FeatureNumber = sfd.FeatureNumber
		AND sfd.DateKeyEnd = 401767
		AND sfd.StatusCode IN ('A','S','F') --only update if feature exists as active prior to today 
		
				

	SELECT @iError = @@Error, @iCount = @@RowCount
	if @iError <> 0 begin
		set @bError = 1
		SET @cMessage = 'FAILED: Update InputChangedFeature PreExistingFlag'
		exec RTF_ProcessMessage_Add 'E', @iError, @cMessage, @cSPName, @nProcessKey, 0
		goto ExitProcedure
	end 


	SELECT @cMessage  = 'CHKP 01' 
	SELECT @nEndTime  = GETDATE() 
	EXEC RTF_ProcessMessage_RunTime   @nCHKPTime  ,  @nEndTime  ,  @cMessage  ,  @cSPName  ,  @nProcessKey   
	SELECT @nCHKPTime  = GETDATE() 
	



------------------------------------------------------------------------------------------------------------------------------------------

-- START TESTING - Temporary output to temp table for validation purposes SH20110212

	--	Insert into temp table for testing only	
		--UPDATE icfanalog
		--SET StatusCode = 'C'
		--	,DateKeyDeactivation = @nDateKey
		
		DELETE FROM SCLoad..tmp_sh_INPT_0354_AnalogDigitalVidCancel WHERE DateKey = @nDateKey 
	
		INSERT INTO SCLoad..tmp_sh_INPT_0354_AnalogDigitalVidCancel
				(DateKey
				,BillingSubSystemId
				,AccountNumber
				,ServiceNumber
				,FeatureNumber
				,AnalogFeatureCode
				,AnalogStatusCode
				,DigitalFeatureCode
				,DigitalStatusCode
				,AnalogPreExistingFlag
				,DigitalPreExistingFlag
				,User19 
				)
				
		SELECT
				icfanalog.DateKey AS DateKey
				,icfanalog.BillingSubSystemId AS BillingSubSystemId
				,icfanalog.AccountNumber AS AccountNumber
				,icfanalog.ServiceNumber AS ServiceNumber
				,icfanalog.FeatureNumber AS FeatureNumber
				,icfanalog.FeatureCode	AS AnalogFeatureCode
				,icfanalog.StatusCode AS AnalogStatusCode
				,icf.FeatureCode AS DigitalFeatureCode
				,icf.StatusCode AS DigitalStatusCode
				,icfanalog.PreExistingFlag AS AnalogPreExistingFlag
				,icf.PreExistingFlag AS DigitalPreExistingFlag
				,icfanalog.User19 
	
		FROM SCRules..InputChangedFeature icfanalog
		
		INNER JOIN 
			SCRules..InputChangedFeature icf
			ON	icf.BillingSubSystemId = icfanalog.BillingSubSystemId
			AND icf.AccountNumber = icfanalog.AccountNumber
			AND icf.ServiceNumber = icfanalog.ServiceNumber
			AND icf.FeatureNumber <> icfanalog.FeatureNumber
			AND icf.DateKey = icfanalog.DateKey	
			
		INNER JOIN 
			SCRules..DimProductReportingAllHistory dprahanalog
			ON icfanalog.FeatureCode = dprahanalog.BillCode
			--AND icfanalog.BillingSubSystemId = dprahanalog.BillingSubSystemId --SH20110813 No longer used in DPRAH
			AND @nDateKey BETWEEN dprahanalog.DateKeyStart AND dprahanalog.DateKeyEnd
			
		INNER JOIN 
			SCRules..DimProductReportingAllHistory dprahdig
			ON icf.FeatureCode = dprahdig.BillCode
			--AND icf.BillingSubSystemId = dprahdig.BillingSubSystemId	--SH20110813 No longer used in DPRAH
			AND @nDateKey BETWEEN dprahdig.DateKeyStart AND dprahdig.DateKeyEnd				 
						
		WHERE
			dprahanalog.Gen05LongName = 'Analog' 
			AND dprahdig.Gen05LongName IN ('Digital Full', 'Digital Basic', 'Digital Start')
			AND icf.StatusCode IN ('A','S','F') --digital is active today
			AND icfanalog.PreExistingFlag = 1 --analog was active yesterday
			AND icfanalog.StatusCode IN ('A','S','F')--analog is active today
			--AND COALESCE(icf.PreExistingFlag,0) = 0 --digital did not exist yesterday  SH20110305: Commented out 
	
	--END Temp Testing

------------------------------------------------------------------------------------------------------------------------------------------

	--  Cancel Analog services that existed prior to today without Digital and Digital service activates today

		UPDATE icfanalog
		SET icfanalog.StatusCode = 'C'
			,icfanalog.DateKeyDeactivation = @nDateKey
	
		FROM SCRules..InputChangedFeature icfanalog
		
		INNER JOIN 
			SCRules..InputChangedFeature icf
			ON	icf.BillingSubSystemId = icfanalog.BillingSubSystemId
			AND icf.AccountNumber = icfanalog.AccountNumber
			AND icf.ServiceNumber = icfanalog.ServiceNumber
			AND icf.FeatureNumber <> icfanalog.FeatureNumber
			AND icf.DateKey = icfanalog.DateKey	
			
		INNER JOIN 
			SCRules..DimProductReportingAllHistory dprahanalog
			ON icfanalog.FeatureCode = dprahanalog.BillCode
			--AND icfanalog.BillingSubSystemId = dprahanalog.BillingSubSystemId --SH20110813 No longer used in DPRAH
			AND @nDateKey BETWEEN dprahanalog.DateKeyStart AND dprahanalog.DateKeyEnd
			
		INNER JOIN 
			SCRules..DimProductReportingAllHistory dprahdig
			ON icf.FeatureCode = dprahdig.BillCode
			--AND icf.BillingSubSystemId = dprahdig.BillingSubSystemId  --SH20110813 No longer used in DPRAH		
			AND @nDateKey BETWEEN dprahdig.DateKeyStart AND dprahdig.DateKeyEnd				 
						
		WHERE
			dprahanalog.Gen05LongName = 'Analog' 
			AND dprahdig.Gen05LongName IN ('Digital Full', 'Digital Basic', 'Digital Start')
			AND icf.StatusCode IN ('A','S','F') --digital is active today
			AND icfanalog.PreExistingFlag = 1 --analog was active yesterday
			AND icfanalog.StatusCode IN ('A','S','F')--analog is active today
			--AND COALESCE(icf.PreExistingFlag,0) = 0 --digital did not exist yesterday
				
		SELECT @iError = @@Error, @iCount = @@RowCount
		if @iError <> 0 begin
			set @bError = 1
			SET @cMessage = 'FAILED: Cancel SCRules..InputChangedFeature Analog'
			exec RTF_ProcessMessage_Add 'E', @iError, @cMessage,@cSPName,@nProcessKey,0
			goto ExitProcedure
		END 		


------------------------------------------------------------------------------------------------------------------------------------------

-- START TESTING - Temporary output to temp table for validation purposes

	--	Insert into temp table for testing only
	
	--  Delete any Analog services in today's data that are not currently active in StateFeatureDimension
	
	-- HK20111114 adding the revenue information to the temp table from both analog and digital services.

		DELETE FROM SCLoad..tmp_sh_INPT_0354_AnalogDigitalVid WHERE DateKey = @nDateKey
	
		INSERT INTO SCLoad..tmp_sh_INPT_0354_AnalogDigitalVid
				(DateKey
				,BillingSubSystemId
				,AccountNumber
				,ServiceNumber
				,FeatureNumber
				,AnalogFeatureCode
				,AnalogStatusCode
				,DigitalFeatureCode
				,DigitalStatusCode
				,AnalogPreExistingFlag
				,DigitalPreExistingFlag
				,User19
				,AnalogRevenue_user25
				,DigitalRevenue_user25
				)
				
		SELECT
				icfanalog.DateKey AS DateKey
				,icfanalog.BillingSubSystemId AS BillingSubSystemId
				,icfanalog.AccountNumber AS AccountNumber
				,icfanalog.ServiceNumber AS ServiceNumber
				,icfanalog.FeatureNumber AS FeatureNumber
				,icfanalog.FeatureCode	AS AnalogFeatureCode
				,icfanalog.StatusCode AS AnalogStatusCode
				,icf.FeatureCode AS DigitalFeatureCode
				,icf.StatusCode AS DigitalStatusCode
				,icfanalog.PreExistingFlag AS AnalogPreExistingFlag
				,icf.PreExistingFlag AS DigitalPreExistingFlag
				,icfanalog.User19
				,icfanalog.User25 as "AnalogRevenue" -- Analog Revenue information
				,icf.User25 as "DigitalRevenue" -- Digital revenue information
		
		FROM SCRules..InputChangedFeature icfanalog
		
		INNER JOIN 
			SCRules..InputChangedFeature icf
			ON	icf.BillingSubSystemId = icfanalog.BillingSubSystemId
			AND icf.AccountNumber = icfanalog.AccountNumber
			AND icf.ServiceNumber = icfanalog.ServiceNumber
			AND icf.FeatureNumber <> icfanalog.FeatureNumber
			AND icf.DateKey = icfanalog.DateKey
			
		INNER JOIN 
			SCRules..DimProductReportingAllHistory dprahanalog
			ON icfanalog.FeatureCode = dprahanalog.BillCode
			--AND icfanalog.BillingSubSystemId = dprahanalog.BillingSubSystemId --SH20110813 No longer used in DPRAH
			AND @nDateKey BETWEEN dprahanalog.DateKeyStart AND dprahanalog.DateKeyEnd			
			
		INNER JOIN 
			SCRules..DimProductReportingAllHistory dprahdig
			ON icf.FeatureCode = dprahdig.BillCode
			--AND icf.BillingSubSystemId = dprahdig.BillingSubSystemId	 --SH20110813 No longer used in DPRAH
			AND @nDateKey BETWEEN dprahdig.DateKeyStart AND dprahdig.DateKeyEnd					 
						
		WHERE
			dprahanalog.Gen05LongName = 'Analog' 
			AND dprahdig.Gen05LongName IN ('Digital Full', 'Digital Basic', 'Digital Start')
			AND icf.StatusCode IN ('A','S','F') -- DO NOT DELETE RECORDS UPDATED TO CANCELLED ABOVE 
			AND icfanalog.StatusCode IN ('A','S','F') 
			--AND icfanalog.PreExistingFlag = 0	-- only delete if new today				--SH20110305

-- END TESTING		

------------------------------------------------------------------------------------------------------------------------------------------

-- HK20112214 Prior to the deletion of the non-pre-existing active analog features with active digital features, we
-- have to transfer any revenue information they contain to their corresponding digital features.

	UPDATE
		icf
	SET
		icf.user25 = icfanalog.user25 -- transfer the revenue information from the analog to the digital features.
	from
		SCRules..InputChangedFeature icf
	inner join
			(
					select
							icf_analog.*,
							row_number() over
							(
								partition by
										icf_analog.DateKey,
										icf_analog.BillingSubSystemId,
										icf_analog.AccountNumber,
										icf_analog.ServiceNumber
								order by
										User25 desc			
							) as rownumb
					from
							SCRules..InputChangedFeature icf_analog
					inner join 
							SCRules..DimProductReportingAllHistory dprahanalog
					on
							icf_analog.FeatureCode = dprahanalog.BillCode
							and @nDateKey BETWEEN dprahanalog.DateKeyStart AND dprahanalog.DateKeyEnd
					where
							icf_analog.StatusCode IN ('A','S','F') 
							and dprahanalog.Gen05LongName = 'Analog'
			) icfanalog
	on
			icf.BillingSubSystemId = icfanalog.BillingSubSystemId
			AND icf.AccountNumber = icfanalog.AccountNumber
			AND icf.ServiceNumber = icfanalog.ServiceNumber
			AND icf.FeatureNumber <> icfanalog.FeatureNumber
			AND icf.DateKey = icfanalog.DateKey
			AND icfanalog.rownumb = 1
	inner join 
			SCRules..DimProductReportingAllHistory dprahdig
	on 
			icf.FeatureCode = dprahdig.BillCode and
			@nDateKey BETWEEN dprahdig.DateKeyStart and dprahdig.DateKeyEnd
	where		 
			--dprahdig.Gen05LongName IN ('Digital Full', 'Digital Basic', 'Digital Start') and 
			icf.StatusCode IN ('A','S','F') 
			and icf.user25 = 0
			and icfanalog.user25 = 1
		
	SELECT @iError = @@Error, @iCount = @@RowCount
		if @iError <> 0 begin
			set @bError = 1
			SET @cMessage = 'FAILED: Updating SCRules..InputChangedFeature revenue info transfer from analog to digital'
			exec RTF_ProcessMessage_Add 'E', @iError, @cMessage,@cSPName,@nProcessKey,0
			goto ExitProcedure
		END		


------------------------------------------------------------------------------------------------------------------------------------------
	
	
	--  Delete any Analog services in today's data that are not currently active in StateFeatureDimension
	
		DELETE icfanalog

		FROM SCRules..InputChangedFeature icfanalog
		
		INNER JOIN 
			SCRules..InputChangedFeature icf
			ON	icf.BillingSubSystemId = icfanalog.BillingSubSystemId
			AND icf.AccountNumber = icfanalog.AccountNumber
			AND icf.ServiceNumber = icfanalog.ServiceNumber
			AND icf.FeatureNumber <> icfanalog.FeatureNumber
			AND icf.DateKey = icfanalog.DateKey
			
		INNER JOIN 
			SCRules..DimProductReportingAllHistory dprahanalog
			ON icfanalog.FeatureCode = dprahanalog.BillCode
			--AND icfanalog.BillingSubSystemId = dprahanalog.BillingSubSystemId  --SH20110813 No longer used in DPRAH
			AND @nDateKey BETWEEN dprahanalog.DateKeyStart AND dprahanalog.DateKeyEnd			
			
		INNER JOIN 
			SCRules..DimProductReportingAllHistory dprahdig
			ON icf.FeatureCode = dprahdig.BillCode
			--AND icf.BillingSubSystemId = dprahdig.BillingSubSystemId	 --SH20110813 No longer used in DPRAH
			AND @nDateKey BETWEEN dprahdig.DateKeyStart AND dprahdig.DateKeyEnd		
			
		WHERE
			dprahanalog.Gen05LongName = 'Analog' 
			AND dprahdig.Gen05LongName IN ('Digital Full', 'Digital Basic', 'Digital Start')
			AND icf.StatusCode IN ('A','S','F') 
			AND icfanalog.StatusCode IN ('A','S','F') 
			--AND icfanalog.PreExistingFlag = 0 -- only delete if new today	  --SH20110305

		SELECT @iError = @@Error, @iCount = @@RowCount
		if @iError <> 0 begin
			set @bError = 1
			SET @cMessage = 'FAILED: Delete SCRules..InputChangedFeature Analog'
			exec RTF_ProcessMessage_Add 'E', @iError, @cMessage,@cSPName,@nProcessKey,0
			goto ExitProcedure
		END 
	

--======================================================================================================================
ExitProcedure:

    IF @bError = 1 
        set @cMessage  = 'FAILED RUN TIME' 
    ELSE 
        set @cMessage  = 'TOTAL RUN TIME' 

    SELECT @nEndTime  = GETDATE() 
    EXEC RTF_ProcessMessage_RunTime @nStartTime, @nEndTime, @cMessage, @cSPName, @nProcessKey   
    
    RETURN (@bError )

    SET NOCOUNT OFF

END



