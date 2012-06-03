/*
	This script is used to update region codes in the SCODS-RC and the SCODS databases Snapshot and Delta tables
*/

/*
	SCODS-RC
*/
select * from [SCODS-RC].[dbo].[ODSCustomerSnapshot] --(24101 row(s) affected)
--UPDATE  [SCODS-RC].[dbo].[ODSCustomerSnapshot]
  --SET RegionCode = '32-660'  
  where (AccountNumber like '660%' or AccountNumber like '680%') and LEN(AccountNumber) = 11 and SnapshotDate between '09-28-2011' and '09-30-2011' and BillingSubSystemId = '32';
   
  
-- select * from [SCODS-RC].[dbo].[ODSCustomerDelta] --(0 row(s) affected)
UPDATE  [SCODS-RC].[dbo].[ODSCustomerDelta]
  SET RegionCode = '32-660'
  where (AccountNumber like '660%' or AccountNumber like '680%') and LEN(AccountNumber) = 11 and SnapshotDate between '09-28-2011' and '09-30-2011' and BillingSubSystemId = '32';  
  
  
/*
	SCODS
*/
-- select * from [SCODS].[dbo].[ODSCustomerSnapshot] --(16066 row(s) affected)
UPDATE  [SCODS].[dbo].[ODSCustomerSnapshot]
  SET RegionCode = '32-660'  
  where (AccountNumber like '660%' or AccountNumber like '680%') and LEN(AccountNumber) = 11 and SnapshotDate between '09-28-2011' and '09-30-2011' and BillingSubSystemId = '32';
   
  
-- select * from [SCODS].[dbo].[ODSCustomerDelta] --(8039 row(s) affected)
UPDATE  [SCODS].[dbo].[ODSCustomerDelta]
  SET RegionCode = '32-660'
  where (AccountNumber like '660%' or AccountNumber like '680%') and LEN(AccountNumber) = 11 and SnapshotDate between '09-28-2011' and '09-30-2011' and BillingSubSystemId = '32';