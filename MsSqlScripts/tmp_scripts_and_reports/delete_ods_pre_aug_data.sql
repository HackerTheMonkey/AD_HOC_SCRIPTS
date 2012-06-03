-- delete data from the SCODS-CT tables
delete from [SCODS-CT]..[CTETLLog] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSCustomerDelta] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSCustomerLoadNew] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSCustomerLoadOld] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSCustomerSnapshot] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageDelta] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageLoadNew] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSServicePackageSnapshot] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSUsageData] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-CT]..[ODSUsageDataRaw] t where MONTH(t.Snapshot)='7' and YEAR(t.Snapshot)='2011';

-- delete data from the SCODS-RC tables
delete from [SCODS-RC]..[MergeODSCustomerDelta-CR] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[MergeODSCustomerSnapshot-CR] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[MergeODSServicePackageDelta-CR] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[MergeODSServicePackageSnapshot-CR] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[ODSCustomerDelta] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[ODSCustomerImport] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[ODSCustomerLoadNew] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[ODSCustomerLoadOld] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[ODSCustomerSnapshot] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[ODSServicePackageDelta] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[ODSServicePackageImport] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[ODSServicePackageLoadNew] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[ODSServicePackageLoadOld] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[ODSServicePackageSnapshot] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[TempODSCustomerSnapshot_EK-CR] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-RC]..[TempODSCustomerSnapshot_RC-CR] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';

-- delete data from the SCODS-EK tables
delete from [SCODS-EK]..[ODSCustomerDelta] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerImport] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerLoadNew] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerLoadOld] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSCustomerSnapshot] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageDelta] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageImport] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageLoadNew] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageLoadOld] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS-EK]..[ODSServicePackageSnapshot] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';


-- delete data from the SCODS tables
delete from [SCODS]..[ODSControlData] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';           
delete from [SCODS]..[ODSCustomerDelta] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';         
delete from [SCODS]..[ODSCustomerSnapshot] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';
delete from [SCODS]..[ODSServicePackageDelta] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';   
delete from [SCODS]..[ODSServicePackageSnapshot] t where MONTH(t.SnapshotDate)='7' and YEAR(t.SnapshotDate)='2011';