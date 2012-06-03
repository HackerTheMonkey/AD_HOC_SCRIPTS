select top 1 * from SCRules..InputChangedFeature;
select distinct datekey from scrules..InputChangedFeature;
select DateKey from scrules..GlobalDateSmall t where cast(ChangeDate as date)='2011-10-01';--40816
select * from scrules..globaldatesmall t where t.datekey='40755';
-- Check the data in the ICF that belongs to the last engine run for aug 01
select * from scrules..InputChangedFeature t where t.datekey=
(select DateKey from scrules..GlobalDateSmall t where cast(ChangeDate as date)='2011-10-01');
---------------------------------------------------------------------------------------------
select
	icf.DateKey,
	icf.BillingSubSystemId,
	icf.AccountNumber,
	icf.ServiceNumber,
	icf.FeatureNumber as "DigFeatureNumber",
	icfanalog.FeatureNumber as "AnaFeatureNumber",
	icf.user25 as "digital_revenue",
	icfanalog.user25 as "analog_revenue",
	icfanalog.rownumb
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
			and icfanalog.user25 = 1;