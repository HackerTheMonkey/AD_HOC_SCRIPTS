-- To verify pushing up the Max Payment Status from the feature to the service level
-- the following query should return 0 rows
select count(1) from
	(
	select
		tmp.BillingSubSystemId as BillingSubSystemID,
		tmp.AccountNumber as AccountNumber,
		tmp.ServiceNumber as ServiceNumber,
		tmp.DateKey as DateKey,
		tmp.user08 as "tmp_user08",
		icf.user08 as "icf_user08",
		ics.user08 as "ics_user08",
		icf.StatusCode as "icf_status_code",
		row_number() over (
			partition by 
			tmp.billingsubsystemid, 
			tmp.accountnumber, 
			tmp.servicenumber, 
			tmp.datekey 
			order by 
				case
					when icf.user08 = 'Prepaid' then 1
					when icf.user08 = 'Unknown' then 99
					else
						cast(icf.user08 as int)
					end
			) as rownum
	from
		scload..tmp_hk_payment_status tmp
	inner join
		scrules..InputChangedFeature icf
	on
		tmp.BillingSubSystemId = icf.BillingSubSystemID
		and tmp.AccountNumber = icf.AccountNumber
		and tmp.ServiceNumber = icf.ServiceNumber
		and tmp.DateKey = icf.DateKey
	inner join scrules..InputChangedService ics
	on
		tmp.BillingSubSystemId = ics.BillingSubSystemID
		and tmp.AccountNumber = ics.AccountNumber
		and tmp.ServiceNumber = ics.ServiceNumber
		and tmp.DateKey = ics.DateKey
	inner join
		scrules..DimProductReportingAllHistory dprah
	on
		icf.FeatureCode = dprah.BillCode
	where
		icf.StatusCode in ('A', 'S', 'F')
		and dprah.Gen02LongName = 'RGU'
		and dprah.DateKeyEnd = (select top 1 DateKey from scrules..GlobalDateSmall order by DateKey desc)
	) a
where
	a.icf_user08 <> ics_user08
	and a.rownum = 1;
	
-- To verify pushing up the Last Payment Date from the feature to the service level
-- the following query should return 0 rows
select count(1) from
	(
	select
		tmp.BillingSubSystemId as BillingSubSystemID,
		tmp.AccountNumber as AccountNumber,
		tmp.ServiceNumber as ServiceNumber,
		tmp.DateKey as DateKey,
		
		tmp.user12 as "tmp_user12",
		icf.user11 as "icf_user11",
		ics.user12 as "ics_user12",		
				
		tmp.user09 as "tmp_user09",
		icf.user09 as "icf_user09",
		ics.user09 as "ics_user09",
		
		icf.StatusCode as "icf_status_code",
		row_number() over (
			partition by 
			tmp.billingsubsystemid, 
			tmp.accountnumber, 
			tmp.servicenumber, 
			tmp.datekey 
			order by icf.User11 desc 							
			 ,case when RIGHT(icf.User09,1)= 6 THEN 10
			When RIGHT(icf.User09,1)= 4 THEN 20
			When RIGHT(icf.User09,1) = 3 THEN 30
			When RIGHT(icf.User09,1) = 5 THEN 40
			When RIGHT(icf.User09,1) = 1 THEN 50
			When RIGHT(icf.User09,1) = 2 THEN 60
			When RIGHT(icf.User09,1) = 7 THEN 70
			When RIGHT(icf.User09,1) = 8 THEN 80
				 ELSE 100 END
			) as rownum
	from
		scload..tmp_hk_last_pay_date tmp
	inner join
		scrules..InputChangedFeature icf
	on
		tmp.BillingSubSystemId = icf.BillingSubSystemID
		and tmp.AccountNumber = icf.AccountNumber
		and tmp.ServiceNumber = icf.ServiceNumber
		and tmp.DateKey = icf.DateKey
	inner join scrules..InputChangedService ics
	on
		tmp.BillingSubSystemId = ics.BillingSubSystemID
		and tmp.AccountNumber = ics.AccountNumber
		and tmp.ServiceNumber = ics.ServiceNumber
		and tmp.DateKey = ics.DateKey
	inner join
		scrules..DimProductReportingAllHistory dprah
	on
		icf.FeatureCode = dprah.BillCode
	where
		icf.StatusCode in ('A', 'S', 'F')
		and dprah.Gen02LongName = 'RGU'
		and dprah.DateKeyEnd = (select top 1 DateKey from scrules..GlobalDateSmall order by DateKey desc)
	) a
where
	a.icf_user09 <> ics_user09
	and a.ics_user12 <> a.icf_user11
	and a.rownum = 1;
-- To verify pushing up the Campaign Code from the feature to the service level
-- the following query should return 0 rows
select count(1) from
	(
	select
		tmp.BillingSubSystemId as BillingSubSystemID,
		tmp.AccountNumber as AccountNumber,
		tmp.ServiceNumber as ServiceNumber,
		tmp.DateKey as DateKey,
		icf.DateKeyDeactivation as "icf_DateKeyDeactivation",
		tmp.CampaignCode as "tmp_CampaignCode",
		icf.CampaignCode as "icf_CampaignCode",
		ics.CampaignCode as "ics_CampaignCode",					
		icf.StatusCode as "icf_status_code",
		row_number() over (
			partition by 
			tmp.billingsubsystemid, 
			tmp.accountnumber, 
			tmp.servicenumber, 
			tmp.datekey 
			order by icf.DateKeyActivation desc, icf.CampaignCode desc 
			) as rownum
	from
		scload..tmp_hk_camp_code2 tmp --tmp_hk_camp_code1 contains no data
	inner join
		scrules..InputChangedFeature icf
	on
		tmp.BillingSubSystemId = icf.BillingSubSystemID
		and tmp.AccountNumber = icf.AccountNumber
		and tmp.ServiceNumber = icf.ServiceNumber
		and tmp.DateKey = icf.DateKey
	inner join scrules..InputChangedService ics
	on
		tmp.BillingSubSystemId = ics.BillingSubSystemID
		and tmp.AccountNumber = ics.AccountNumber
		and tmp.ServiceNumber = ics.ServiceNumber
		and tmp.DateKey = ics.DateKey
	inner join
		scrules..DimProductReportingAllHistory dprah
	on
		icf.FeatureCode = dprah.BillCode
	where
		icf.StatusCode in ('A', 'S', 'F')
		and dprah.Gen02LongName = 'RGU'
		and dprah.DateKeyEnd = (select top 1 DateKey from scrules..GlobalDateSmall order by DateKey desc)
	) a
where
	a.icf_campaigncode <> a.ics_campaigncode
	and a.rownum = 1;
-- To verify pushing up the Revenue Flag from the feature to the service level
-- the following query should return 0 rows
select count(1) from
	(
	select
		tmp.BillingSubSystemId as BillingSubSystemID,
		tmp.AccountNumber as AccountNumber,
		tmp.ServiceNumber as ServiceNumber,
		tmp.DateKey as DateKey,
		
		tmp.user18 as "tmp_user18",
		ics.user18 as "ics_user18",
		ISNULL(icf.User25,0) as "icf_user25",
		
		icf.StatusCode as "icf_status_code",
		row_number() over (
			partition by 
			tmp.billingsubsystemid, 
			tmp.accountnumber, 
			tmp.servicenumber, 
			tmp.datekey 
			order by icf.user25 desc 
			) as rownum
	from
		scload..tmp_hk_rev_flag tmp
	inner join
		scrules..InputChangedFeature icf
	on
		tmp.BillingSubSystemId = icf.BillingSubSystemID
		and tmp.AccountNumber = icf.AccountNumber
		and tmp.ServiceNumber = icf.ServiceNumber
		and tmp.DateKey = icf.DateKey
	inner join scrules..InputChangedService ics
	on
		tmp.BillingSubSystemId = ics.BillingSubSystemID
		and tmp.AccountNumber = ics.AccountNumber
		and tmp.ServiceNumber = ics.ServiceNumber
		and tmp.DateKey = ics.DateKey
	inner join
		scrules..DimProductReportingAllHistory dprah
	on
		icf.FeatureCode = dprah.BillCode
	where
		icf.StatusCode in ('A', 'S', 'F')
		and dprah.Gen02LongName = 'RGU'
		and dprah.DateKeyEnd = (select top 1 DateKey from scrules..GlobalDateSmall order by DateKey desc)
	) a
where
	a.ics_user18 <> a.icf_user25
	and a.rownum = 1;
-- To verify pushing up the Max Service Commitment from the feature to the service level
-- the following query should return 0 rows
select count(1) from
(
select
	tmp.DateKey,
	tmp.BillingSubSystemId,
	tmp.AccountNumber,
	tmp.ServiceNumber,
	
	tmp.User12 as "tmp_user12_old_value",
	icf.user11 as "icf_user11_src_value",
	ics.user12 as "ics_user12_new_value",
	
	tmp.user09 as "tmp_user09_old_value",
	icf.user09 as "icf_user09_src_value",
	ics.user09 as "ics_user09_new_value",
	
	icf.StatusCode,
	icf.Durah_UserCode,
	icf.rownumb
from
	scload..tmp_hk_last_payment_date_type tmp
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
		and dprah.DateKeyEnd = 401767
		and durah.DateKeyEnd = 401767
		and durah.DimensionId = 3
		) icf
on 
	tmp.billingsubsystemid = icf.billingsubsystemid 
	and tmp.accountnumber = icf.accountnumber 
	and tmp.servicenumber = icf.servicenumber 
	and tmp.datekey = icf.datekey 
	and icf.rownumb = 1
inner join SCRules..InputChangedService ics
on tmp.billingsubsystemid = ics.billingsubsystemid 
	and tmp.accountnumber = ics.accountnumber 
	and tmp.servicenumber = ics.servicenumber 
	and tmp.datekey = ics.datekey
) a
where
	(a.icf_user11_src_value <> a.ics_user12_new_value or
	a.icf_user09_src_value <> a.ics_user09_new_value)
	and a.rownumb <> 1;
	