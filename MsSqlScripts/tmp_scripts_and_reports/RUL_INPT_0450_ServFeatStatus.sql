--==========================================================================================================================================
--
-- HK20111101 Push the max service commitements from the feature level to the service level.
--
UPDATE ics
		SET User10 = icf.User10
		FROM SCRules..InputChangedService ics
		LEFT OUTER JOIN	(
			SELECT
			DateKey,
			billingsubsystemid,
			accountnumber,
			servicenumber,
			User10,
			row_number() over (
			partition by datekey, billingsubsystemid, accountnumber, servicenumber 
					order by User10 desc  
		) as rownumb
		from SCRules..InputChangedFeature icf
		where StatusCode IN ('A', 'S', 'F')
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