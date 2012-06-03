-- Delete bssid 30 from scods

delete  [scods]..[ODSservicepackageDelta] where cast(snapshotdate as date) = '2011-10-25' and BillingSubSystemId = '30' and AccountNumber like 'CRU%';

delete  [scods]..[ODSservicepackageSnapshot] where cast(snapshotdate as date) = '2011-10-25' and BillingSubSystemId = '30' and AccountNumber like 'CRU%';

delete  [scods]..[ODSCustomerDelta] where cast(snapshotdate as date) = '2011-10-25' and BillingSubSystemId = '30' and AccountNumber like 'CRU%';

delete  [scods]..[ODSCustomerSnapshot] where cast(snapshotdate as date) = '2011-10-25' and BillingSubSystemId = '30' and AccountNumber like 'CRU%';