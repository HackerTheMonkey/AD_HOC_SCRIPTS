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