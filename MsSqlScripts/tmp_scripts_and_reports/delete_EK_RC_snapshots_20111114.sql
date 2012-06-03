-- Delete the snapshot data for RC for the 14-NOV-2011
delete from [scods-rc]..[ODSservicepackageSnapshot] where cast(snapshotdate as date) = '2011-11-14';
delete from [scods-rc]..[ODSCustomerSnapshot] where cast(snapshotdate as date) = '2011-11-14';
-- Delete the snapshot data for EK for the 14-NOV-2011
delete from [scods-ek]..[ODSservicepackageSnapshot] where cast(snapshotdate as date) = '2011-11-14';
delete from [scods-ek]..[ODSCustomerSnapshot] where cast(snapshotdate as date) = '2011-11-14';