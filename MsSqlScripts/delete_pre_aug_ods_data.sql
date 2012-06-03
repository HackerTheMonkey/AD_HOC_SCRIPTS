-- The following is an ad-hoc procedure to be used for each bulk of deletions
begin
	--Print the job ID of the executed procedure for tracking purposes.
	print @@spid;
end;

-- Then in order to track the execution status of the previous ad-hoc procedure, we need to
-- use the sp_who system stored procedure to do so, as follows:
exec sp_who '<The SPID of the procedure printed during the execution of the ad-hoc procedure>'

-- Get the number of records per each day of the month
select 
	CONVERT(nvarchar, YEAR(SnapshotDate)) + '0' + 
	CONVERT(nvarchar, MONTH(SnapshotDate)) + '0' + 
	CONVERT(nvarchar, DAY(SnapshotDate)) as "CurrentDate", 
	COUNT(*) as "count" 
from 
	(select SnapshotDate from [SCODS-RC]..[ODSCustomerSnapshot] where YEAR(SnapshotDate)='2011' and MONTH(SnapshotDate)='5') a 
group by 
	CONVERT(nvarchar, YEAR(SnapshotDate)) + '0' + 
	CONVERT(nvarchar, MONTH(SnapshotDate)) + '0' + 
	CONVERT(nvarchar, DAY(SnapshotDate));

-- Query all the RC data to make sure that everything has been removed
select 
	CONVERT(nvarchar, YEAR(SnapshotDate)) + '0' + 
	CONVERT(nvarchar, MONTH(SnapshotDate)) + '0' + 
	CONVERT(nvarchar, DAY(SnapshotDate)) as "CurrentDate", 
	COUNT(*) as "count" 
from 
	(select SnapshotDate from [SCODS-RC]..[ODSServicePackageSnapshot] where YEAR(SnapshotDate)='2011' and (MONTH(SnapshotDate)='5' or MONTH(SnapshotDate)='7' or MONTH(SnapshotDate)='7')) a 
group by 
	CONVERT(nvarchar, YEAR(SnapshotDate)) + '0' + 
	CONVERT(nvarchar, MONTH(SnapshotDate)) + '0' + 
	CONVERT(nvarchar, DAY(SnapshotDate));
		
-- delete data from the SCODS-Ctables

delete from [SCODS-CT]..[ODSCustomerDelta] where MONTH(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(569944 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerDelta] where MONTH(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(17867 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerDelta] where MONTH(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(22233 row(s) affected)

delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(670769 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';--(670812 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';--(670817 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(671037 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(671268 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(671429 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(671575 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(671677 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';--(671727 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(671736 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';--no data
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';--no data
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';--no data
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';--(672317 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';--(672426 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';--(672475 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';--(672481 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';--(672665 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';--(672791 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';--(672924 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';--(673072 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';--(667652 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';--(667700 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';--(667706 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';--(659506 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';--(659701 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';--(395511 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';--(659992 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';--(660106 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';--(660144 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='31' and YEAR(SnapshotDate)='2011';--N/A

delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(672421 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';--(672668 row(s) affected) 
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';--(672817 row(s) affected) 
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(672868 row(s) affected) 
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(672877 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(673129 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(667863 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(667968 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';--(668046 row(s) affected) 
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(668296 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';--(668320 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';--(668325 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';--(668543 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';--(668698 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';--(668894 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';--(669044 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';--(669183 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';--(669227 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';--(669236 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';--(669461 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';--(669624 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';--(669754 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';--(670033 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';--(670035 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';--(670208 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';--(670361 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';--(670467 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';--(670635 row(s) affected)

delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(667386 row(s) affected) 
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';--(667557 row(s) affected) 
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(667840 row(s) affected) 
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(667950 row(s) affected) 
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(667965 row(s) affected) 
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(667993 row(s) affected) 
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(668002 row(s) affected) 
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';--(668174 row(s) affected) 
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(668306 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';--(668433 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';--(668628 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';--(668788 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';--(668824 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';--(668833 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';--(669079 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';--(669384 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';--(669592 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';--(669832 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';--(670086 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';--(670179 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';--(670187 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';--(670280 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';--(670320 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';--(670592 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';--(670886 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';--(671359 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';--(671374 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';--(671855 row(s) affected)
delete from [SCODS-CT]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='31' and YEAR(SnapshotDate)='2011';--(672246 row(s) affected)

delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(397750 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';--(743 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(13119 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(11387 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(13113 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(15301 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(628 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';--(16111 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';--(16578 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';--(14695 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';--(77571 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';--(20065 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';--(440 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';--(14085 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';--(1416115 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';--(8517 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';--(8217 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';--(13597 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';--(361 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';--(18964 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';--(618031 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';--(618656 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';--(7185 row(s) affected)


delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(411223 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';--(11085 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';--(9705 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(721 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(13180 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(29073 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(13811 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';--(12458 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(13574 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';--(562 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';--(22622 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';--(19279 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';--(17693 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';--(12094 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';--(9963 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';--(491 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';--(10725 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';--(9341 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';--(7173 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';--(4623 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';--(8241 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';--(8393 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';--(7341 row(s) affected)

delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(1679 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';--(15372 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(426836 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(10700 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(1184 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(2078 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(470 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';--(21335 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(20579 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';--(1381474 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';--(20459 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';--(21876 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';--(6791 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';--(611 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';--(18627 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';--(11544 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';--(8958 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';--(8093 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';--(8602 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';--(283 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';--(1947 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';--(1389347 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';--(23036 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';--(10420 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';--(8756 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';--(439 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';--(12866 row(s) affected)


delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(1405673 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';--(1405954 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';--(1406001 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(1407333 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(1408674 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(1409608 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(1410302 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(1410911 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';--(1411160 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(1411199 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';--(1411942 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';--(1412599 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';--(1413255 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';--(1413979 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';--(1414550 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';--(0 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';--deleted
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';--deleted
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';


delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(1397184 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';--(1398121 row(s) affected)                          
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';--(1398971 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(1399199 row(s) affected)                          
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(1399231 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(1400151 row(s) affected)                          
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(1388149 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(1388735 row(s) affected)                          
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';--(1389319 row(s) affected) 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(1390127 row(s) affected)                         
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';                         
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';                         
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';                         
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';                         
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';

-- average # of records per day is 1.4 M
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(1374394 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';--(1375389 row(s) affected)
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';-- 0 row(s) affected
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';


-- delete data from the SCODS-RC tables
delete from [SCODS-RC]..[ODSCustomerDelta] where MONTH(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(376315 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerDelta] where MONTH(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(518373 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate) < '10' and YEAR(SnapshotDate)='2011';--(209754 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate) < '20' and YEAR(SnapshotDate)='2011';--(132176 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate) < '22' and YEAR(SnapshotDate)='2011';--(6682 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate) < '24' and YEAR(SnapshotDate)='2011';--(1954 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate) < '26' and YEAR(SnapshotDate)='2011';--(4933 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate) < '28' and YEAR(SnapshotDate)='2011';--(4833 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate) > '28' and YEAR(SnapshotDate)='2011';--(946852 row(s) affected)


delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(309560 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)<'3' and YEAR(SnapshotDate)='2011';--(309590 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';--(309591 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(309893 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(310110 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(deleted)

delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';--(deleted)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='31' and YEAR(SnapshotDate)='2011';--(321638 row(s) affected)



 
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';--(304067 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';--(304303 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(304363 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(304363 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(304573 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(304795 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(305029 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';--(305220 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(305466 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';--(305533 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';--(305544 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';--(305885 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';--(306141 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';--(306422 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';--(306563 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';--(306755 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';--(306852 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';--(306830 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';--(307061 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';--(307279 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';--(307512 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';--(308073 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';--(308098 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';--(308393 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';--(308663 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';--(308905 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';--(309280 row(s) affected)
	
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(0 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';--(318750 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';--(0 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(319520 row(s) affected) 
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(319826 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(319866 row(s) affected) 
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(319943 row(s) affected) 
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(319952 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';--(320359 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';--(320770 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';--(321147 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';--(321519 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';--(321906 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';--(322047 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';--(322081 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';--(325093 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';--(325259 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';--(325842 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';--(327497 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';--(0 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';--(335505 row(s) affected)
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';-- deleted
delete from [SCODS-RC]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';-- deleted


delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(Snapshotdate)<'5' and YEAR(SnapshotDate)='2011';--(986354 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(Snapshotdate)<'10' and YEAR(SnapshotDate)='2011';--(211459 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(Snapshotdate)<'15' and YEAR(SnapshotDate)='2011';--(268419 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(Snapshotdate)<'20' and YEAR(SnapshotDate)='2011';--(427758 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(Snapshotdate)<'25' and YEAR(SnapshotDate)='2011';-- 0 rows affected
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and DAY(Snapshotdate)<'27' and YEAR(SnapshotDate)='2011';--(250489 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(82023 row(s) affected)


delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate) < '10' and YEAR(SnapshotDate)='2011';--(1494498 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate) < '20' and YEAR(SnapshotDate)='2011';--(2247594 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate) < '25' and YEAR(SnapshotDate)='2011';--(1396398 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(4011371 row(s) affected)

delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';--(756127 row(s) affected) 
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(41087 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(33383 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(7901 row(s) affected) 
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(7500 row(s) affected) 
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(3637 row(s) affected) 
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';--(60411 row(s) affected) 
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(63561 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';--(63215 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';--(70667 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';--(96875 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';--(33046 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';--(5353 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';--(149536 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';--(50829 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';--(28075 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';--(22939 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';--(21532 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';--(7255 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';--(2169 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';--(6719 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';--(3704 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';--(17393 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';--(19367 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';--(2497632 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';--(2715 row(s) affected)
delete from [SCODS-RC]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='31' and YEAR(SnapshotDate)='2011';--(85319 row(s) affected)

delete from [SCODS-RC]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';
delete from [SCODS-RC]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';
delete from [SCODS-RC]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';

-- delete data from the SCODS-EK tables
delete from [SCODS-EK]..[ODSCustomerDelta] where MONTH(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(7220 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerDelta] where MONTH(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(8989 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerDelta] where MONTH(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(8745 row(s) affected)

delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='31' and YEAR(SnapshotDate)='2011';


delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='31' and YEAR(SnapshotDate)='2011';

delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(0 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';--(535357 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';--(0 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(535567 row(s) affected) 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(535671 row(s) affected) 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(535682 row(s) affected) 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(535705 row(s) affected) 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(535710 row(s) affected) 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';--(535810 row(s) affected) 
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(535930 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';--(536013 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';--(536104 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';--(536170 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';--(536208 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';--(536219 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';--(536314 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';--(536437 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';--(536591 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';--(536720 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';--(536882 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';--(536930 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';--(536939 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';--(537055 row(s) affected)
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='31' and YEAR(SnapshotDate)='2011';

-- Need to check if the amount of data is small enough to be deleted on month by month basis
select count(*) from [SCODS-EK]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';

delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011';--(1017906 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011';-- (1018097 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011';--(1018117 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011';--(1018722 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011';--(1019208 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011';--(1019666 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';--(1020092 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011';--(1020462 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011';--(1020620 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';--(1020636 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';--(1021004 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';--(1021261 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';--(0 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';--(1022012 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';--(1022353 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';--(1022548 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';--(1022556 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';--(1022963 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';--(1023326 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';--(1023709 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';--(1024009 row(s) affected)
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and DAY(SnapshotDate)='31' and YEAR(SnapshotDate)='2011';


delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='6' and DAY(SnapshotDate)='31' and YEAR(SnapshotDate)='2011';

delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='1' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='2' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='3' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='4' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='5' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='6' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='7' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='8' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='9' and YEAR(SnapshotDate)='2011'; 
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='10' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='11' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='12' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='13' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='14' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='15' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='16' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='17' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='18' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='19' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='20' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='21' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='22' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='23' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='24' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='25' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='26' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='27' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='28' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='29' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='30' and YEAR(SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='5' and DAY(SnapshotDate)='31' and YEAR(SnapshotDate)='2011';



-- delete data from the SCODS tables - no need for the deletion from this DB as there are no data prior to AUG
-- 2011
delete from [SCODS]..[ODSCustomerDelta] where MONTH(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';         
delete from [SCODS]..[ODSCustomerSnapshot] where MONTH(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';
delete from [SCODS]..[ODSServicePackageDelta] where MONTH(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';   
delete from [SCODS]..[ODSServicePackageSnapshot] where MONTH(SnapshotDate)='7' and YEAR(SnapshotDate)='2011';
