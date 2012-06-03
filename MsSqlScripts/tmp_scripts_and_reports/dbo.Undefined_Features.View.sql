USE [SCLoad]
GO
/****** Object:  View [dbo].[Undefined_Features]    Script Date: 11/09/2011 17:29:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
ACTION is CREATE View Undefined_Features
*/

CREATE  view [dbo].[Undefined_Features] as 
	SELECT DISTINCT 'Outlier' AS Status, featurecode, MIN(snapshotdate) AS MinSnapshotDate
	FROM         [SCODS-CT]..ODSServicePackageSnapshot ods INNER JOIN
						  SCRules..DimProductReportingAllHistory dprah ON ods.FeatureCode = dprah.BillCode
	WHERE     Gen02LongName LIKE 'Unmapped%' AND ods.SnapshotDate >= '10/01/2011' AND isnumeric(AccountNumber) = 1
	GROUP BY featurecode
	UNION ALL
	SELECT DISTINCT 'Missing' AS Status, featurecode, MIN(snapshotdate) AS MinSnapshotDate
	FROM         [SCODS-CT]..ODSServicePackageSnapshot ods LEFT OUTER JOIN
						  SCRules..DimProductReportingAllHistory dprah ON ods.FeatureCode = dprah.BillCode
	WHERE     dprah.BillCode IS NULL AND ods.SnapshotDate >= '10/01/2011' AND isnumeric(AccountNumber) = 1
	GROUP BY featurecode
	UNION ALL
	SELECT DISTINCT 'Outlier' AS Status, featurecode, MIN(snapshotdate) AS MinSnapshotDate
	FROM         [SCODS-RC]..ODSServicePackageSnapshot ods INNER JOIN
						  SCRules..DimProductReportingAllHistory dprah ON ods.FeatureCode = dprah.BillCode
	WHERE     Gen02LongName LIKE 'Unmapped%' AND ods.SnapshotDate >= '10/01/2011' AND isnumeric(AccountNumber) = 1
	GROUP BY featurecode
	UNION ALL
	SELECT DISTINCT 'Missing' AS Status, featurecode, MIN(snapshotdate) AS MinSnapshotDate
	FROM         [SCODS-RC]..ODSServicePackageSnapshot ods LEFT OUTER JOIN
						  SCRules..DimProductReportingAllHistory dprah ON ods.FeatureCode = dprah.BillCode
	WHERE     dprah.BillCode IS NULL AND ods.SnapshotDate >= '10/01/2011' AND isnumeric(AccountNumber) = 1
	GROUP BY featurecode
	UNION ALL
	SELECT DISTINCT 'Outlier' AS Status, featurecode, MIN(snapshotdate) AS MinSnapshotDate
	FROM         [SCODS-EK]..ODSServicePackageSnapshot ods INNER JOIN
						  SCRules..DimProductReportingAllHistory dprah ON ods.FeatureCode = dprah.BillCode
	WHERE     Gen02LongName LIKE 'Unmapped%' AND ods.SnapshotDate >= '10/01/2011' AND isnumeric(AccountNumber) = 1
	GROUP BY featurecode
	UNION ALL
	SELECT DISTINCT 'Missing' AS Status, featurecode, MIN(snapshotdate) AS MinSnapshotDate
	FROM         [SCODS-EK]..ODSServicePackageSnapshot ods LEFT OUTER JOIN
						  SCRules..DimProductReportingAllHistory dprah ON ods.FeatureCode = dprah.BillCode
	WHERE     dprah.BillCode IS NULL AND ods.SnapshotDate >= '10/01/2011' AND isnumeric(AccountNumber) = 1
	GROUP BY featurecode
GO
