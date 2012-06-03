-- This script is used to delete data feeds from SCODS-RC DB for the subscribers with some un-mapped codes
-- that came into the feed on the 25-OCT-2011, those subscribers have been migrated to RC on the 26th of the
-- same month and hence we should remove the data came on the 25th OCT. Those subscribers can be
-- identified with their customerId/accountnumber which begins with CRU

delete  [scods-rc]..[ODSservicepackageDelta] where cast(snapshotdate as date) = '2011-10-25' and BillingSubSystemId = '30' and AccountNumber like 'CRU%';

delete  [scods-rc]..[ODSservicepackageSnapshot] where cast(snapshotdate as date) = '2011-10-25' and BillingSubSystemId = '30' and AccountNumber like 'CRU%';

delete  [scods-rc]..[ODSCustomerDelta] where cast(snapshotdate as date) = '2011-10-25' and BillingSubSystemId = '30' and AccountNumber like 'CRU%';

delete  [scods-rc]..[ODSCustomerSnapshot] where cast(snapshotdate as date) = '2011-10-25' and BillingSubSystemId = '30' and AccountNumber like 'CRU%';