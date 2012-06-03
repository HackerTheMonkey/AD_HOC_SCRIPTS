-- Delete the feed data for the SCODS-RC database
-- This script is used to clean up the feed data and delete some duplicate or un-needed subscribers
-- records, e.g. when some feature codes are not mapped to services because they belong to subscribers
-- that have been migrated into another billing system.

delete  [scods-rc]..[ODSservicepackageDelta] where snapshotdate = '25/08/2011' and BillingSubSystemId = '1' and AccountNumber like '650%';

delete  [scods-rc]..[ODSservicepackageSnapshot] where snapshotdate = '25/08/2011' and BillingSubSystemId = '1' and AccountNumber like '650%';

delete  [scods-rc]..[ODSCustomerDelta] where snapshotdate = '25/08/2011' and BillingSubSystemId = '1' and AccountNumber like '650%';

delete  [scods-rc]..[ODSCustomerSnapshot] where snapshotdate = '25/08/2011' and BillingSubSystemId = '1' and AccountNumber like '650%';

select top 10 * from SCRules..DimProductReportingAllHistory;

-- Get the dependabcies in the DimProductReportingAllHistory table
find . -type f | grep -vi svn | grep -i procedure

for filename in $(for file in $(find . -type f | grep -vi svn | grep -i procedure)
do
	grep -li "DimProductReportingAllHistory" $file
done)
do
	grep "billcode" $filename -l
done

-- find the objects that use the DimProductReportingAllHistory and reference the billcode column
-- and open them all together using TextWrangler application.
tw $(for filename in $(for file in $(find . -type f | grep -vi svn | grep -i view)
do
grep -li "DimProductReportingAllHistory" $file
done); do grep -i "billcode" $filename -l; done)

-- Get all the tables that contain the StatusCode field
for filename in $(for file in $(find . -type f | grep -vi svn | grep -i procedure | grep -vi temp | grep -vi 'Scripts/Configure') ; do echo $file ; done)
do
	grep -i ODSCustomerDelta -l ${filename}
done