-- Delete the feed data from the SCODS database
-- This script is used to clean up the feed data and delete some duplicate or un-needed subscribers
-- records, e.g. when some feature codes are not mapped to services because they belong to subscribers
-- that have been migrated into another billing system.

delete  [scods]..[ODSservicepackageDelta] where snapshotdate = '25/08/2011' and BillingSubSystemId = '1' and AccountNumber like '650%';

delete  [scods]..[ODSservicepackageSnapshot] where snapshotdate = '25/08/2011' and BillingSubSystemId = '1' and AccountNumber like '650%';

delete  [scods]..[ODSCustomerDelta] where snapshotdate = '25/08/2011' and BillingSubSystemId = '1' and AccountNumber like '650%';

delete  [scods]..[ODSCustomerSnapshot] where snapshotdate = '25/08/2011' and BillingSubSystemId = '1' and AccountNumber like '650%';