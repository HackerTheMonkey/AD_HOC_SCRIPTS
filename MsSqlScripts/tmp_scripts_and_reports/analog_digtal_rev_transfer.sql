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