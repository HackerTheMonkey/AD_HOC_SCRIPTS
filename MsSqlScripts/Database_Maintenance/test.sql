REPLACE PROCEDURE "SCLOAD"."LoadProducts" (
		IN "nProcessKey" DECIMAL(15 , 0),
		INOUT "bError" BYTEINT)




BEGIN

  DECLARE cMessage              VARCHAR(250);
  DECLARE cSPName               VARCHAR(50);
  DECLARE iCount                INTEGER;
  DECLARE tsStartTime           TIMESTAMP(2);
  DECLARE tsEndTime             TIMESTAMP(2);
  DECLARE tsCHKPTime            TIMESTAMP(2);

  DECLARE nDateKey              NUMERIC;
  DECLARE nBatchKey             NUMERIC;
  DECLARE iIsTrueup             NUMERIC;
  DECLARE iInitFlag             NUMERIC;
  DECLARE cParameterValue       VARCHAR(500);
  DECLARE dChangeDate           TIMESTAMP(0);
  DECLARE errDPCount            INTEGER;
  DECLARE errPGACount 					INTEGER;

  DECLARE Exit HANDLER For sqlexception
    HCS1: BEGIN
            SET bError = 1;
            SET cMessage =  sqlcode || ' - ' || cMessage;
            CALL RTF_ProcessMessage_Add('E',0,:cMessage,:cSPName,:nProcessKey,0);

            SET cMessage = 'FAILED RUN TIME';
            SET tsEndTime = CURRENT_TIMESTAMP(2);
            CALL RTF_ProcessMessage_RunTime(:tsStartTime, :tsEndTime, :cMessage, :cSPName, :nProcessKey);
    END HCS1;

MAINPROC:
BEGIN
--======================================================================================================================
-- Set program defaults
	
  SET bError  = 0;
  SET cSPName  = 'LoadProducts';
  SET tsStartTime  = CURRENT_TIMESTAMP(2); 

--======================================================================================================================

  SET cMessage  = 'Starting';
  CALL RTF_ProcessMessage_Add ('I',0,:cMessage,:cSPName,:nProcessKey,0); 
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);
  
--==========================================================================================================================================

  CALL RTF_Parameter_Get ('BatchKey',:cSPName, :nProcessKey,1,:cParameterValue);
  SET nBatchKey = CAST(cParameterValue AS NUMERIC(8));

  CALL RTF_Parameter_Get ('DateKey',:cSPName, :nProcessKey,1,:cParameterValue);
  SET nDateKey = CAST(cParameterValue AS NUMERIC(8));

  CALL RTF_Parameter_Get ('IsTrueup',:cSPName, :nProcessKey,1,:cParameterValue);
  SET iIsTrueup = CAST(cParameterValue AS INTEGER);

  CALL RTF_Parameter_Get ('InitFlag',:cSPName, :nProcessKey,1,:cParameterValue);
  SET iInitFlag = CAST(cParameterValue AS INTEGER);
  
  CALL RTF_Get_Date(:nDateKey,:dChangeDate);
  
--======================================================================================================================
--	Feature/Product code inserts
--======================================================================================================================

	DELETE FROM TempProductHierBuild ALL;

  INSERT INTO TempProductHierBuild ( 
      MaxLevelNumber,
      Product_Hier_Type_Cd,
      Product_Grp_Id1,
      Product_Grp_Hier_Level_Cd1,
      Product_Grp_Id2,
      Product_Grp_Hier_Level_Cd2,
      Product_Grp_Id3,
      Product_Grp_Hier_Level_Cd3,
      Product_Grp_Id4,
      Product_Grp_Hier_Level_Cd4,
      Product_Grp_Id5,
      Product_Grp_Hier_Level_Cd5,
      Product_Grp_Id6,
      Product_Grp_Hier_Level_Cd6,
      Product_Grp_Id7,
      Product_Grp_Hier_Level_Cd7,
      Product_Grp_Id8,
      Product_Grp_Hier_Level_Cd8,
      Product_Grp_Id9,
      Product_Grp_Hier_Level_Cd9,
      Product_Grp_Id10,
      Product_Grp_Hier_Level_Cd10,
      Product_Grp_Id11,
      Product_Grp_Hier_Level_Cd11
    )
    SELECT
        -1 as MaxLevelNumber
        ,pgh1.Product_Hier_Type_Cd 
        ,pgh1.Child_Product_Grp_Id as Product_Grp_Id1
        ,pgh1.Product_Grp_Hier_Child_Lvl_Cd as Product_Grp_Hier_Level_Cd1
        ,pgh1.Parent_Product_Grp_Id as Product_Grp_Id2
        ,pgh1.Product_Grp_Hier_Parent_Lvl_Cd as Product_Grp_Hier_Level_Cd2

        ,pgh2.Parent_Product_Grp_Id as Product_Grp_Id3
        ,pgh2.Product_Grp_Hier_Parent_Lvl_Cd as Product_Grp_Hier_Level_Cd3

        ,pgh3.Parent_Product_Grp_Id as Product_Grp_Id4
        ,pgh3.Product_Grp_Hier_Parent_Lvl_Cd as Product_Grp_Hier_Level_Cd4

        ,pgh4.Parent_Product_Grp_Id as Product_Grp_Id5
        ,pgh4.Product_Grp_Hier_Parent_Lvl_Cd as Product_Grp_Hier_Level_Cd5

        ,pgh5.Parent_Product_Grp_Id as Product_Grp_Id6
        ,pgh5.Product_Grp_Hier_Parent_Lvl_Cd as Product_Grp_Hier_Level_Cd6

        ,pgh6.Parent_Product_Grp_Id as Product_Grp_Id7
        ,pgh6.Product_Grp_Hier_Parent_Lvl_Cd as Product_Grp_Hier_Level_Cd7

        ,pgh7.Parent_Product_Grp_Id as Product_Grp_Id8
        ,pgh7.Product_Grp_Hier_Parent_Lvl_Cd as Product_Grp_Hier_Level_Cd8

        ,pgh8.Parent_Product_Grp_Id as Product_Grp_Id9
        ,pgh8.Product_Grp_Hier_Parent_Lvl_Cd as Product_Grp_Hier_Level_Cd9

        ,pgh9.Parent_Product_Grp_Id as Product_Grp_Id10
        ,pgh9.Product_Grp_Hier_Parent_Lvl_Cd as Product_Grp_Hier_Level_Cd10

        ,pgh10.Parent_Product_Grp_Id as Product_Grp_Id11
        ,pgh10.Product_Grp_Hier_Parent_Lvl_Cd as Product_Grp_Hier_Level_Cd11

      FROM (
	SELECT DISTINCT Product_Grp_Id
	  FROM Product_Group_Association
	  --WHERE :dChangeDate BETWEEN Product_Ass_Start_Dt AND Product_Ass_End_Dt
	    --AND :dChangeDate BETWEEN Record_Start_Dt AND Record_End_Dt
	    --AND '00:00:00' BETWEEN Product_Ass_Start_Tm AND Product_Ass_End_Tm
	    --AND '00:00:00' BETWEEN Record_Start_Tm AND Record_End_Tm

      ) pg0

      INNER JOIN Product_Group_Hierarchy pgh1
        ON pg0.Product_Grp_Id = pgh1.Child_Product_Grp_Id
	  AND :dChangeDate BETWEEN pgh1.Product_Grp_Related_Start_Dt AND pgh1.Product_Grp_Related_End_Dt
          AND :dChangeDate BETWEEN pgh1.Record_Start_Dt AND pgh1.Record_End_Dt
	  AND '00:00:00' BETWEEN pgh1.Product_Grp_Related_Start_Tm AND pgh1.Product_Grp_Related_End_Tm
          AND '00:00:00' BETWEEN pgh1.Record_Start_Tm AND pgh1.Record_End_Tm

      LEFT OUTER JOIN Product_Group_Hierarchy pgh2
        ON pgh1.Parent_Product_Grp_Id = pgh2.Child_Product_Grp_Id
          AND pgh1.Product_Hier_Type_Cd = pgh2.Product_Hier_Type_Cd
	  AND :dChangeDate BETWEEN pgh2.Product_Grp_Related_Start_Dt AND pgh2.Product_Grp_Related_End_Dt
          AND :dChangeDate BETWEEN pgh2.Record_Start_Dt AND pgh2.Record_End_Dt
	  AND '00:00:00' BETWEEN pgh2.Product_Grp_Related_Start_Tm AND pgh2.Product_Grp_Related_End_Tm
          AND '00:00:00' BETWEEN pgh2.Record_Start_Tm AND pgh2.Record_End_Tm

      LEFT OUTER JOIN Product_Group_Hierarchy pgh3
        ON pgh2.Parent_Product_Grp_Id = pgh3.Child_Product_Grp_Id
          AND pgh2.Product_Hier_Type_Cd = pgh3.Product_Hier_Type_Cd
          AND :dChangeDate BETWEEN pgh3.Product_Grp_Related_Start_Dt AND pgh3.Product_Grp_Related_End_Dt
	  AND :dChangeDate BETWEEN pgh3.Record_Start_Dt AND pgh3.Record_End_Dt
	  AND '00:00:00' BETWEEN pgh3.Product_Grp_Related_Start_Tm AND pgh3.Product_Grp_Related_End_Tm
          AND '00:00:00' BETWEEN pgh3.Record_Start_Tm AND pgh3.Record_End_Tm

      LEFT OUTER JOIN Product_Group_Hierarchy pgh4
        ON pgh3.Parent_Product_Grp_Id = pgh4.Child_Product_Grp_Id
          AND pgh3.Product_Hier_Type_Cd = pgh4.Product_Hier_Type_Cd
	  AND :dChangeDate BETWEEN pgh4.Product_Grp_Related_Start_Dt AND pgh4.Product_Grp_Related_End_Dt
          AND :dChangeDate BETWEEN pgh4.Record_Start_Dt AND pgh4.Record_End_Dt
	  AND '00:00:00' BETWEEN pgh4.Product_Grp_Related_Start_Tm AND pgh4.Product_Grp_Related_End_Tm
          AND '00:00:00' BETWEEN pgh4.Record_Start_Tm AND pgh4.Record_End_Tm

      LEFT OUTER JOIN Product_Group_Hierarchy pgh5
        ON pgh4.Parent_Product_Grp_Id = pgh5.Child_Product_Grp_Id
          AND pgh4.Product_Hier_Type_Cd = pgh5.Product_Hier_Type_Cd
	  AND :dChangeDate BETWEEN pgh5.Product_Grp_Related_Start_Dt AND pgh5.Product_Grp_Related_End_Dt
          AND :dChangeDate BETWEEN pgh5.Record_Start_Dt AND pgh5.Record_End_Dt
	  AND '00:00:00' BETWEEN pgh5.Product_Grp_Related_Start_Tm AND pgh5.Product_Grp_Related_End_Tm
          AND '00:00:00' BETWEEN pgh5.Record_Start_Tm AND pgh5.Record_End_Tm

      LEFT OUTER JOIN Product_Group_Hierarchy pgh6
        ON pgh5.Parent_Product_Grp_Id = pgh6.Child_Product_Grp_Id
          AND pgh5.Product_Hier_Type_Cd = pgh6.Product_Hier_Type_Cd
	  AND :dChangeDate BETWEEN pgh6.Product_Grp_Related_Start_Dt AND pgh6.Product_Grp_Related_End_Dt
          AND :dChangeDate BETWEEN pgh6.Record_Start_Dt AND pgh6.Record_End_Dt
	  AND '00:00:00' BETWEEN pgh6.Product_Grp_Related_Start_Tm AND pgh6.Product_Grp_Related_End_Tm
          AND '00:00:00' BETWEEN pgh6.Record_Start_Tm AND pgh6.Record_End_Tm

      LEFT OUTER JOIN Product_Group_Hierarchy pgh7
        ON pgh6.Parent_Product_Grp_Id = pgh7.Child_Product_Grp_Id
          AND pgh6.Product_Hier_Type_Cd = pgh7.Product_Hier_Type_Cd
	  AND :dChangeDate BETWEEN pgh7.Product_Grp_Related_Start_Dt AND pgh7.Product_Grp_Related_End_Dt
          AND :dChangeDate BETWEEN pgh7.Record_Start_Dt AND pgh7.Record_End_Dt
	  AND '00:00:00' BETWEEN pgh7.Product_Grp_Related_Start_Tm AND pgh7.Product_Grp_Related_End_Tm
          AND '00:00:00' BETWEEN pgh7.Record_Start_Tm AND pgh7.Record_End_Tm

      LEFT OUTER JOIN Product_Group_Hierarchy pgh8
        ON pgh7.Parent_Product_Grp_Id = pgh8.Child_Product_Grp_Id
          AND pgh7.Product_Hier_Type_Cd = pgh8.Product_Hier_Type_Cd
	  AND :dChangeDate BETWEEN pgh8.Product_Grp_Related_Start_Dt AND pgh8.Product_Grp_Related_End_Dt
          AND :dChangeDate BETWEEN pgh8.Record_Start_Dt AND pgh8.Record_End_Dt
	  AND '00:00:00' BETWEEN pgh8.Product_Grp_Related_Start_Tm AND pgh8.Product_Grp_Related_End_Tm
          AND '00:00:00' BETWEEN pgh8.Record_Start_Tm AND pgh8.Record_End_Tm

      LEFT OUTER JOIN Product_Group_Hierarchy pgh9
        ON pgh8.Parent_Product_Grp_Id = pgh9.Child_Product_Grp_Id
          AND pgh8.Product_Hier_Type_Cd = pgh9.Product_Hier_Type_Cd
	  AND :dChangeDate BETWEEN pgh9.Product_Grp_Related_Start_Dt AND pgh9.Product_Grp_Related_End_Dt
          AND :dChangeDate BETWEEN pgh9.Record_Start_Dt AND pgh9.Record_End_Dt
	  AND '00:00:00' BETWEEN pgh9.Product_Grp_Related_Start_Tm AND pgh9.Product_Grp_Related_End_Tm
          AND '00:00:00' BETWEEN pgh9.Record_Start_Tm AND pgh9.Record_End_Tm

      LEFT OUTER JOIN Product_Group_Hierarchy pgh10
        ON pgh9.Parent_Product_Grp_Id = pgh10.Child_Product_Grp_Id
          AND pgh9.Product_Hier_Type_Cd = pgh10.Product_Hier_Type_Cd
	  AND :dChangeDate BETWEEN pgh10.Product_Grp_Related_Start_Dt AND pgh10.Product_Grp_Related_End_Dt
          AND :dChangeDate BETWEEN pgh10.Record_Start_Dt AND pgh10.Record_End_Dt
	  AND '00:00:00' BETWEEN pgh10.Product_Grp_Related_Start_Tm AND pgh10.Product_Grp_Related_End_Tm
          AND '00:00:00' BETWEEN pgh10.Record_Start_Tm AND pgh10.Record_End_Tm
  ;

  SET cMessage = 'CHKP 01 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

  UPDATE TempProductHierBuild
    SET MaxLevelNumber = CASE
        WHEN Product_Grp_Id1 IS NOT NULL AND Product_Grp_Id2 IS NULL THEN 1
        WHEN Product_Grp_Id2 IS NOT NULL AND Product_Grp_Id3 IS NULL THEN 2
        WHEN Product_Grp_Id3 IS NOT NULL AND Product_Grp_Id4 IS NULL THEN 3
        WHEN Product_Grp_Id4 IS NOT NULL AND Product_Grp_Id5 IS NULL THEN 4
        WHEN Product_Grp_Id5 IS NOT NULL AND Product_Grp_Id6 IS NULL THEN 5
        WHEN Product_Grp_Id6 IS NOT NULL AND Product_Grp_Id7 IS NULL THEN 6
        WHEN Product_Grp_Id7 IS NOT NULL AND Product_Grp_Id8 IS NULL THEN 7
        WHEN Product_Grp_Id8 IS NOT NULL AND Product_Grp_Id9 IS NULL THEN 8
        WHEN Product_Grp_Id9 IS NOT NULL AND Product_Grp_Id10 IS NULL THEN 9
        WHEN Product_Grp_Id10 IS NOT NULL AND Product_Grp_Id11 IS NULL THEN 10
        WHEN Product_Grp_Id10 IS NOT NULL THEN 11
        ELSE MaxLevelNumber
      END
  ;

  SET cMessage = 'CHKP 02 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Updated';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

--SELECT ERROR FROM TempProductHierBuild WHERE MaxLevelNumber = -1;

  DELETE FROM TempProductHierBuild2 ALL;

  SET cMessage = 'CHKP 03 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Deleted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

  INSERT INTO TempProductHierBuild2 (
       Product_Hier_Type_Cd 
      ,Product_Grp_Id1
      ,Product_Grp_Hier_Level_Cd1
      ,Product_Grp_Id2
      ,Product_Grp_Hier_Level_Cd2
      ,Product_Grp_Id3
      ,Product_Grp_Hier_Level_Cd3
      ,Product_Grp_Id4
      ,Product_Grp_Hier_Level_Cd4
      ,Product_Grp_Id5
      ,Product_Grp_Hier_Level_Cd5
      ,Product_Grp_Id6
      ,Product_Grp_Hier_Level_Cd6
      ,Product_Grp_Id7
      ,Product_Grp_Hier_Level_Cd7
      ,Product_Grp_Id8
      ,Product_Grp_Hier_Level_Cd8
      ,Product_Grp_Id9
      ,Product_Grp_Hier_Level_Cd9
      ,Product_Grp_Id10
      ,Product_Grp_Hier_Level_Cd10
      ,Product_Grp_Id11
      ,Product_Grp_Hier_Level_Cd11
      ,Product_Grp_IdLeaf
      ,Product_Grp_Hier_Level_CdLeaf
    )
    SELECT
         Product_Hier_Type_Cd 		as Product_Hier_Type_Cd
        ,Product_Grp_Id11               as Product_Grp_Id1
        ,Product_Grp_Hier_Level_Cd11    as Product_Grp_Hier_Level_Cd1
        ,Product_Grp_Id10               as Product_Grp_Id2
        ,Product_Grp_Hier_Level_Cd10    as Product_Grp_Hier_Level_Cd2
        ,Product_Grp_Id9                as Product_Grp_Id3
        ,Product_Grp_Hier_Level_Cd9     as Product_Grp_Hier_Level_Cd3
        ,Product_Grp_Id8                as Product_Grp_Id4
        ,Product_Grp_Hier_Level_Cd8     as Product_Grp_Hier_Level_Cd4
        ,Product_Grp_Id7                as Product_Grp_Id5
        ,Product_Grp_Hier_Level_Cd7     as Product_Grp_Hier_Level_Cd5
        ,Product_Grp_Id6                as Product_Grp_Id6
        ,Product_Grp_Hier_Level_Cd6     as Product_Grp_Hier_Level_Cd6
        ,Product_Grp_Id5                as Product_Grp_Id7
        ,Product_Grp_Hier_Level_Cd5     as Product_Grp_Hier_Level_Cd7
        ,Product_Grp_Id4                as Product_Grp_Id8
        ,Product_Grp_Hier_Level_Cd4     as Product_Grp_Hier_Level_Cd8
        ,Product_Grp_Id3                as Product_Grp_Id9
        ,Product_Grp_Hier_Level_Cd3     as Product_Grp_Hier_Level_Cd9
        ,Product_Grp_Id2                as Product_Grp_Id10
        ,Product_Grp_Hier_Level_Cd2     as Product_Grp_Hier_Level_Cd10
        ,Product_Grp_Id1                as Product_Grp_Id11
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_Cd11
        ,Product_Grp_Id1                as Product_Grp_IdLeaf
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_CdLeaf
      FROM TempProductHierBuild
      WHERE MaxLevelNumber = 11
  ;

  SET cMessage = 'CHKP 04 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

  INSERT INTO TempProductHierBuild2 (
       Product_Hier_Type_Cd 
      ,Product_Grp_Id1
      ,Product_Grp_Hier_Level_Cd1
      ,Product_Grp_Id2
      ,Product_Grp_Hier_Level_Cd2
      ,Product_Grp_Id3
      ,Product_Grp_Hier_Level_Cd3
      ,Product_Grp_Id4
      ,Product_Grp_Hier_Level_Cd4
      ,Product_Grp_Id5
      ,Product_Grp_Hier_Level_Cd5
      ,Product_Grp_Id6
      ,Product_Grp_Hier_Level_Cd6
      ,Product_Grp_Id7
      ,Product_Grp_Hier_Level_Cd7
      ,Product_Grp_Id8
      ,Product_Grp_Hier_Level_Cd8
      ,Product_Grp_Id9
      ,Product_Grp_Hier_Level_Cd9
      ,Product_Grp_Id10
      ,Product_Grp_Hier_Level_Cd10
      ,Product_Grp_Id11
      ,Product_Grp_Hier_Level_Cd11
      ,Product_Grp_IdLeaf
      ,Product_Grp_Hier_Level_CdLeaf
    )
    SELECT
         Product_Hier_Type_Cd         as Product_Hier_Type_Cd
         ,Product_Grp_Id10            as Product_Grp_Id1
         ,Product_Grp_Hier_Level_Cd10 as Product_Grp_Hier_Level_Cd1
         ,Product_Grp_Id9             as Product_Grp_Id2
         ,Product_Grp_Hier_Level_Cd9  as Product_Grp_Hier_Level_Cd2
         ,Product_Grp_Id8             as Product_Grp_Id3
         ,Product_Grp_Hier_Level_Cd8  as Product_Grp_Hier_Level_Cd3
         ,Product_Grp_Id7             as Product_Grp_Id4
         ,Product_Grp_Hier_Level_Cd7  as Product_Grp_Hier_Level_Cd4
         ,Product_Grp_Id6             as Product_Grp_Id5
         ,Product_Grp_Hier_Level_Cd6  as Product_Grp_Hier_Level_Cd5
         ,Product_Grp_Id5             as Product_Grp_Id6
         ,Product_Grp_Hier_Level_Cd5  as Product_Grp_Hier_Level_Cd6
         ,Product_Grp_Id4             as Product_Grp_Id7
         ,Product_Grp_Hier_Level_Cd4  as Product_Grp_Hier_Level_Cd7
         ,Product_Grp_Id3             as Product_Grp_Id8
         ,Product_Grp_Hier_Level_Cd3  as Product_Grp_Hier_Level_Cd8
         ,Product_Grp_Id2             as Product_Grp_Id9
         ,Product_Grp_Hier_Level_Cd2  as Product_Grp_Hier_Level_Cd9
         ,Product_Grp_Id1             as Product_Grp_Id10
         ,Product_Grp_Hier_Level_Cd1  as Product_Grp_Hier_Level_Cd10
         ,NULL                        as Product_Grp_Id11
         ,NULL                        as Product_Grp_Hier_Level_Cd11
         ,Product_Grp_Id1             as Product_Grp_IdLeaf
         ,Product_Grp_Hier_Level_Cd1  as Product_Grp_Hier_Level_CdLeaf
      FROM TempProductHierBuild
      WHERE MaxLevelNumber = 10
  ;

  SET cMessage = 'CHKP 05 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);
  
  INSERT INTO TempProductHierBuild2 (
       Product_Hier_Type_Cd 
      ,Product_Grp_Id1
      ,Product_Grp_Hier_Level_Cd1
      ,Product_Grp_Id2
      ,Product_Grp_Hier_Level_Cd2
      ,Product_Grp_Id3
      ,Product_Grp_Hier_Level_Cd3
      ,Product_Grp_Id4
      ,Product_Grp_Hier_Level_Cd4
      ,Product_Grp_Id5
      ,Product_Grp_Hier_Level_Cd5
      ,Product_Grp_Id6
      ,Product_Grp_Hier_Level_Cd6
      ,Product_Grp_Id7
      ,Product_Grp_Hier_Level_Cd7
      ,Product_Grp_Id8
      ,Product_Grp_Hier_Level_Cd8
      ,Product_Grp_Id9
      ,Product_Grp_Hier_Level_Cd9
      ,Product_Grp_Id10
      ,Product_Grp_Hier_Level_Cd10
      ,Product_Grp_Id11
      ,Product_Grp_Hier_Level_Cd11
      ,Product_Grp_IdLeaf
      ,Product_Grp_Hier_Level_CdLeaf
    )
    SELECT
         Product_Hier_Type_Cd        as Product_Hier_Type_Cd
         ,Product_Grp_Id9            as Product_Grp_Id1
         ,Product_Grp_Hier_Level_Cd9 as Product_Grp_Hier_Level_Cd1
         ,Product_Grp_Id8            as Product_Grp_Id2
         ,Product_Grp_Hier_Level_Cd8 as Product_Grp_Hier_Level_Cd2
         ,Product_Grp_Id7            as Product_Grp_Id3
         ,Product_Grp_Hier_Level_Cd7 as Product_Grp_Hier_Level_Cd3
         ,Product_Grp_Id6            as Product_Grp_Id4
         ,Product_Grp_Hier_Level_Cd6 as Product_Grp_Hier_Level_Cd4
         ,Product_Grp_Id5            as Product_Grp_Id5
         ,Product_Grp_Hier_Level_Cd5 as Product_Grp_Hier_Level_Cd5
         ,Product_Grp_Id4            as Product_Grp_Id6
         ,Product_Grp_Hier_Level_Cd4 as Product_Grp_Hier_Level_Cd6
         ,Product_Grp_Id3            as Product_Grp_Id7
         ,Product_Grp_Hier_Level_Cd3 as Product_Grp_Hier_Level_Cd7
         ,Product_Grp_Id2            as Product_Grp_Id8
         ,Product_Grp_Hier_Level_Cd2 as Product_Grp_Hier_Level_Cd8
         ,Product_Grp_Id1            as Product_Grp_Id9
         ,Product_Grp_Hier_Level_Cd1 as Product_Grp_Hier_Level_Cd9
         ,NULL                       as Product_Grp_Id10
         ,NULL                       as Product_Grp_Hier_Level_Cd10
         ,NULL                       as Product_Grp_Id11
         ,NULL                       as Product_Grp_Hier_Level_Cd11
         ,Product_Grp_Id1            as Product_Grp_IdLeaf
         ,Product_Grp_Hier_Level_Cd1 as Product_Grp_Hier_Level_CdLeaf
      FROM TempProductHierBuild
      WHERE MaxLevelNumber = 9
  ;

  SET cMessage = 'CHKP 06 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);
  
  INSERT INTO TempProductHierBuild2 (
       Product_Hier_Type_Cd 
      ,Product_Grp_Id1
      ,Product_Grp_Hier_Level_Cd1
      ,Product_Grp_Id2
      ,Product_Grp_Hier_Level_Cd2
      ,Product_Grp_Id3
      ,Product_Grp_Hier_Level_Cd3
      ,Product_Grp_Id4
      ,Product_Grp_Hier_Level_Cd4
      ,Product_Grp_Id5
      ,Product_Grp_Hier_Level_Cd5
      ,Product_Grp_Id6
      ,Product_Grp_Hier_Level_Cd6
      ,Product_Grp_Id7
      ,Product_Grp_Hier_Level_Cd7
      ,Product_Grp_Id8
      ,Product_Grp_Hier_Level_Cd8
      ,Product_Grp_Id9
      ,Product_Grp_Hier_Level_Cd9
      ,Product_Grp_Id10
      ,Product_Grp_Hier_Level_Cd10
      ,Product_Grp_Id11
      ,Product_Grp_Hier_Level_Cd11
      ,Product_Grp_IdLeaf
      ,Product_Grp_Hier_Level_CdLeaf
    )
    SELECT
         Product_Hier_Type_Cd 		as Product_Hier_Type_Cd
        ,Product_Grp_Id8                as Product_Grp_Id1
        ,Product_Grp_Hier_Level_Cd8     as Product_Grp_Hier_Level_Cd1
        ,Product_Grp_Id7                as Product_Grp_Id2
        ,Product_Grp_Hier_Level_Cd7     as Product_Grp_Hier_Level_Cd2
        ,Product_Grp_Id6                as Product_Grp_Id3
        ,Product_Grp_Hier_Level_Cd6     as Product_Grp_Hier_Level_Cd3
        ,Product_Grp_Id5                as Product_Grp_Id4
        ,Product_Grp_Hier_Level_Cd5     as Product_Grp_Hier_Level_Cd4
        ,Product_Grp_Id4                as Product_Grp_Id5
        ,Product_Grp_Hier_Level_Cd4     as Product_Grp_Hier_Level_Cd5
        ,Product_Grp_Id3                as Product_Grp_Id6
        ,Product_Grp_Hier_Level_Cd3     as Product_Grp_Hier_Level_Cd6
        ,Product_Grp_Id2                as Product_Grp_Id7
        ,Product_Grp_Hier_Level_Cd2     as Product_Grp_Hier_Level_Cd7
        ,Product_Grp_Id1                as Product_Grp_Id8
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_Cd8
        ,NULL                           as Product_Grp_Id9
        ,NULL                           as Product_Grp_Hier_Level_Cd9
        ,NULL                           as Product_Grp_Id10
        ,NULL                           as Product_Grp_Hier_Level_Cd10
        ,NULL                           as Product_Grp_Id11
        ,NULL                           as Product_Grp_Hier_Level_Cd11
        ,Product_Grp_Id1                as Product_Grp_IdLeaf
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_CdLeaf
      FROM TempProductHierBuild
      WHERE MaxLevelNumber = 8
  ;
  SET cMessage = 'CHKP 07 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

  INSERT INTO TempProductHierBuild2 (
       Product_Hier_Type_Cd 
      ,Product_Grp_Id1
      ,Product_Grp_Hier_Level_Cd1
      ,Product_Grp_Id2
      ,Product_Grp_Hier_Level_Cd2
      ,Product_Grp_Id3
      ,Product_Grp_Hier_Level_Cd3
      ,Product_Grp_Id4
      ,Product_Grp_Hier_Level_Cd4
      ,Product_Grp_Id5
      ,Product_Grp_Hier_Level_Cd5
      ,Product_Grp_Id6
      ,Product_Grp_Hier_Level_Cd6
      ,Product_Grp_Id7
      ,Product_Grp_Hier_Level_Cd7
      ,Product_Grp_Id8
      ,Product_Grp_Hier_Level_Cd8
      ,Product_Grp_Id9
      ,Product_Grp_Hier_Level_Cd9
      ,Product_Grp_Id10
      ,Product_Grp_Hier_Level_Cd10
      ,Product_Grp_Id11
      ,Product_Grp_Hier_Level_Cd11
      ,Product_Grp_IdLeaf
      ,Product_Grp_Hier_Level_CdLeaf
    )
    SELECT
         Product_Hier_Type_Cd 		as Product_Hier_Type_Cd
        ,Product_Grp_Id7                as Product_Grp_Id1
        ,Product_Grp_Hier_Level_Cd7     as Product_Grp_Hier_Level_Cd1
        ,Product_Grp_Id6                as Product_Grp_Id2
        ,Product_Grp_Hier_Level_Cd6     as Product_Grp_Hier_Level_Cd2
        ,Product_Grp_Id5                as Product_Grp_Id3
        ,Product_Grp_Hier_Level_Cd5     as Product_Grp_Hier_Level_Cd3
        ,Product_Grp_Id4                as Product_Grp_Id4
        ,Product_Grp_Hier_Level_Cd4     as Product_Grp_Hier_Level_Cd4
        ,Product_Grp_Id3                as Product_Grp_Id5
        ,Product_Grp_Hier_Level_Cd3     as Product_Grp_Hier_Level_Cd5
        ,Product_Grp_Id2                as Product_Grp_Id6
        ,Product_Grp_Hier_Level_Cd2     as Product_Grp_Hier_Level_Cd6
        ,Product_Grp_Id1                as Product_Grp_Id7
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_Cd7
        ,NULL                           as Product_Grp_Id8
        ,NULL                           as Product_Grp_Hier_Level_Cd8
        ,NULL                           as Product_Grp_Id9
        ,NULL                           as Product_Grp_Hier_Level_Cd9
        ,NULL                           as Product_Grp_Id10
        ,NULL                           as Product_Grp_Hier_Level_Cd10
        ,NULL                           as Product_Grp_Id11
        ,NULL                           as Product_Grp_Hier_Level_Cd11
        ,Product_Grp_Id1                as Product_Grp_IdLeaf
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_CdLeaf
      FROM TempProductHierBuild
      WHERE MaxLevelNumber = 7
  ;

  SET cMessage = 'CHKP 08 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

  INSERT INTO TempProductHierBuild2 (
       Product_Hier_Type_Cd 
      ,Product_Grp_Id1
      ,Product_Grp_Hier_Level_Cd1
      ,Product_Grp_Id2
      ,Product_Grp_Hier_Level_Cd2
      ,Product_Grp_Id3
      ,Product_Grp_Hier_Level_Cd3
      ,Product_Grp_Id4
      ,Product_Grp_Hier_Level_Cd4
      ,Product_Grp_Id5
      ,Product_Grp_Hier_Level_Cd5
      ,Product_Grp_Id6
      ,Product_Grp_Hier_Level_Cd6
      ,Product_Grp_Id7
      ,Product_Grp_Hier_Level_Cd7
      ,Product_Grp_Id8
      ,Product_Grp_Hier_Level_Cd8
      ,Product_Grp_Id9
      ,Product_Grp_Hier_Level_Cd9
      ,Product_Grp_Id10
      ,Product_Grp_Hier_Level_Cd10
      ,Product_Grp_Id11
      ,Product_Grp_Hier_Level_Cd11
      ,Product_Grp_IdLeaf
      ,Product_Grp_Hier_Level_CdLeaf
    )
    SELECT
         Product_Hier_Type_Cd 		as Product_Hier_Type_Cd
        ,Product_Grp_Id6                as Product_Grp_Id1
        ,Product_Grp_Hier_Level_Cd6     as Product_Grp_Hier_Level_Cd1
        ,Product_Grp_Id5                as Product_Grp_Id2
        ,Product_Grp_Hier_Level_Cd5     as Product_Grp_Hier_Level_Cd2
        ,Product_Grp_Id4                as Product_Grp_Id3
        ,Product_Grp_Hier_Level_Cd4     as Product_Grp_Hier_Level_Cd3
        ,Product_Grp_Id3                as Product_Grp_Id4
        ,Product_Grp_Hier_Level_Cd3     as Product_Grp_Hier_Level_Cd4
        ,Product_Grp_Id2                as Product_Grp_Id5
        ,Product_Grp_Hier_Level_Cd2     as Product_Grp_Hier_Level_Cd5
        ,Product_Grp_Id1                as Product_Grp_Id6
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_Cd6
        ,NULL                           as Product_Grp_Id7
        ,NULL                           as Product_Grp_Hier_Level_Cd7
        ,NULL                           as Product_Grp_Id8
        ,NULL                           as Product_Grp_Hier_Level_Cd8
        ,NULL                           as Product_Grp_Id9
        ,NULL                           as Product_Grp_Hier_Level_Cd9
        ,NULL                           as Product_Grp_Id10
        ,NULL                           as Product_Grp_Hier_Level_Cd10
        ,NULL                           as Product_Grp_Id11
        ,NULL                           as Product_Grp_Hier_Level_Cd11
        ,Product_Grp_Id1                as Product_Grp_IdLeaf
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_CdLeaf
      FROM TempProductHierBuild
      WHERE MaxLevelNumber = 6
  ;

  SET cMessage = 'CHKP 09 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

  INSERT INTO TempProductHierBuild2 (
       Product_Hier_Type_Cd 
      ,Product_Grp_Id1
      ,Product_Grp_Hier_Level_Cd1
      ,Product_Grp_Id2
      ,Product_Grp_Hier_Level_Cd2
      ,Product_Grp_Id3
      ,Product_Grp_Hier_Level_Cd3
      ,Product_Grp_Id4
      ,Product_Grp_Hier_Level_Cd4
      ,Product_Grp_Id5
      ,Product_Grp_Hier_Level_Cd5
      ,Product_Grp_Id6
      ,Product_Grp_Hier_Level_Cd6
      ,Product_Grp_Id7
      ,Product_Grp_Hier_Level_Cd7
      ,Product_Grp_Id8
      ,Product_Grp_Hier_Level_Cd8
      ,Product_Grp_Id9
      ,Product_Grp_Hier_Level_Cd9
      ,Product_Grp_Id10
      ,Product_Grp_Hier_Level_Cd10
      ,Product_Grp_Id11
      ,Product_Grp_Hier_Level_Cd11
      ,Product_Grp_IdLeaf
      ,Product_Grp_Hier_Level_CdLeaf
    )
    SELECT
         Product_Hier_Type_Cd 		as Product_Hier_Type_Cd
        ,Product_Grp_Id5                as Product_Grp_Id1
        ,Product_Grp_Hier_Level_Cd5     as Product_Grp_Hier_Level_Cd1
        ,Product_Grp_Id4                as Product_Grp_Id2
        ,Product_Grp_Hier_Level_Cd4     as Product_Grp_Hier_Level_Cd2
        ,Product_Grp_Id3                as Product_Grp_Id3
        ,Product_Grp_Hier_Level_Cd3     as Product_Grp_Hier_Level_Cd3
        ,Product_Grp_Id2                as Product_Grp_Id4
        ,Product_Grp_Hier_Level_Cd2     as Product_Grp_Hier_Level_Cd4
        ,Product_Grp_Id1                as Product_Grp_Id5
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_Cd5
        ,NULL                           as Product_Grp_Id6
        ,NULL                           as Product_Grp_Hier_Level_Cd6
        ,NULL                           as Product_Grp_Id7
        ,NULL                           as Product_Grp_Hier_Level_Cd7
        ,NULL                           as Product_Grp_Id8
        ,NULL                           as Product_Grp_Hier_Level_Cd8
        ,NULL                           as Product_Grp_Id9
        ,NULL                           as Product_Grp_Hier_Level_Cd9
        ,NULL                           as Product_Grp_Id10
        ,NULL                           as Product_Grp_Hier_Level_Cd10
        ,NULL                           as Product_Grp_Id11
        ,NULL                           as Product_Grp_Hier_Level_Cd11
        ,Product_Grp_Id1                as Product_Grp_IdLeaf
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_CdLeaf
      FROM TempProductHierBuild
      WHERE MaxLevelNumber = 5
  ;

  SET cMessage = 'CHKP 10 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

  INSERT INTO TempProductHierBuild2 (
       Product_Hier_Type_Cd 
      ,Product_Grp_Id1
      ,Product_Grp_Hier_Level_Cd1
      ,Product_Grp_Id2
      ,Product_Grp_Hier_Level_Cd2
      ,Product_Grp_Id3
      ,Product_Grp_Hier_Level_Cd3
      ,Product_Grp_Id4
      ,Product_Grp_Hier_Level_Cd4
      ,Product_Grp_Id5
      ,Product_Grp_Hier_Level_Cd5
      ,Product_Grp_Id6
      ,Product_Grp_Hier_Level_Cd6
      ,Product_Grp_Id7
      ,Product_Grp_Hier_Level_Cd7
      ,Product_Grp_Id8
      ,Product_Grp_Hier_Level_Cd8
      ,Product_Grp_Id9
      ,Product_Grp_Hier_Level_Cd9
      ,Product_Grp_Id10
      ,Product_Grp_Hier_Level_Cd10
      ,Product_Grp_Id11
      ,Product_Grp_Hier_Level_Cd11
      ,Product_Grp_IdLeaf
      ,Product_Grp_Hier_Level_CdLeaf
    )
    SELECT
         Product_Hier_Type_Cd 		as Product_Hier_Type_Cd
        ,Product_Grp_Id4                as Product_Grp_Id1
        ,Product_Grp_Hier_Level_Cd4     as Product_Grp_Hier_Level_Cd1
        ,Product_Grp_Id3                as Product_Grp_Id2
        ,Product_Grp_Hier_Level_Cd3     as Product_Grp_Hier_Level_Cd2
        ,Product_Grp_Id2                as Product_Grp_Id3
        ,Product_Grp_Hier_Level_Cd2     as Product_Grp_Hier_Level_Cd3
        ,Product_Grp_Id1                as Product_Grp_Id4
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_Cd4
        ,NULL                           as Product_Grp_Id5
        ,NULL                           as Product_Grp_Hier_Level_Cd5
        ,NULL                           as Product_Grp_Id6
        ,NULL                           as Product_Grp_Hier_Level_Cd6
        ,NULL                           as Product_Grp_Id7
        ,NULL                           as Product_Grp_Hier_Level_Cd7
        ,NULL                           as Product_Grp_Id8
        ,NULL                           as Product_Grp_Hier_Level_Cd8
        ,NULL                           as Product_Grp_Id9
        ,NULL                           as Product_Grp_Hier_Level_Cd9
        ,NULL                           as Product_Grp_Id10
        ,NULL                           as Product_Grp_Hier_Level_Cd10
        ,NULL                           as Product_Grp_Id11
        ,NULL                           as Product_Grp_Hier_Level_Cd11
        ,Product_Grp_Id1                as Product_Grp_IdLeaf
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_CdLeaf
      FROM TempProductHierBuild
      WHERE MaxLevelNumber = 4
  ;

  SET cMessage = 'CHKP 11 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

  INSERT INTO TempProductHierBuild2 (
       Product_Hier_Type_Cd 
      ,Product_Grp_Id1
      ,Product_Grp_Hier_Level_Cd1
      ,Product_Grp_Id2
      ,Product_Grp_Hier_Level_Cd2
      ,Product_Grp_Id3
      ,Product_Grp_Hier_Level_Cd3
      ,Product_Grp_Id4
      ,Product_Grp_Hier_Level_Cd4
      ,Product_Grp_Id5
      ,Product_Grp_Hier_Level_Cd5
      ,Product_Grp_Id6
      ,Product_Grp_Hier_Level_Cd6
      ,Product_Grp_Id7
      ,Product_Grp_Hier_Level_Cd7
      ,Product_Grp_Id8
      ,Product_Grp_Hier_Level_Cd8
      ,Product_Grp_Id9
      ,Product_Grp_Hier_Level_Cd9
      ,Product_Grp_Id10
      ,Product_Grp_Hier_Level_Cd10
      ,Product_Grp_Id11
      ,Product_Grp_Hier_Level_Cd11
      ,Product_Grp_IdLeaf
      ,Product_Grp_Hier_Level_CdLeaf
    )
    SELECT
         Product_Hier_Type_Cd 		as Product_Hier_Type_Cd
        ,Product_Grp_Id3                as Product_Grp_Id1
        ,Product_Grp_Hier_Level_Cd3     as Product_Grp_Hier_Level_Cd1
        ,Product_Grp_Id2                as Product_Grp_Id2
        ,Product_Grp_Hier_Level_Cd2     as Product_Grp_Hier_Level_Cd2
        ,Product_Grp_Id1                as Product_Grp_Id3
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_Cd3
        ,NULL                           as Product_Grp_Id4
        ,NULL                           as Product_Grp_Hier_Level_Cd4
        ,NULL                           as Product_Grp_Id5
        ,NULL                           as Product_Grp_Hier_Level_Cd5
        ,NULL                           as Product_Grp_Id6
        ,NULL                           as Product_Grp_Hier_Level_Cd6
        ,NULL                           as Product_Grp_Id7
        ,NULL                           as Product_Grp_Hier_Level_Cd7
        ,NULL                           as Product_Grp_Id8
        ,NULL                           as Product_Grp_Hier_Level_Cd8
        ,NULL                           as Product_Grp_Id9
        ,NULL                           as Product_Grp_Hier_Level_Cd9
        ,NULL                           as Product_Grp_Id10
        ,NULL                           as Product_Grp_Hier_Level_Cd10
        ,NULL                           as Product_Grp_Id11
        ,NULL                           as Product_Grp_Hier_Level_Cd11
        ,Product_Grp_Id1                as Product_Grp_IdLeaf
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_CdLeaf
      FROM TempProductHierBuild
      WHERE MaxLevelNumber = 3
  ;

  SET cMessage = 'CHKP 12 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

  INSERT INTO TempProductHierBuild2 (
       Product_Hier_Type_Cd 
      ,Product_Grp_Id1
      ,Product_Grp_Hier_Level_Cd1
      ,Product_Grp_Id2
      ,Product_Grp_Hier_Level_Cd2
      ,Product_Grp_Id3
      ,Product_Grp_Hier_Level_Cd3
      ,Product_Grp_Id4
      ,Product_Grp_Hier_Level_Cd4
      ,Product_Grp_Id5
      ,Product_Grp_Hier_Level_Cd5
      ,Product_Grp_Id6
      ,Product_Grp_Hier_Level_Cd6
      ,Product_Grp_Id7
      ,Product_Grp_Hier_Level_Cd7
      ,Product_Grp_Id8
      ,Product_Grp_Hier_Level_Cd8
      ,Product_Grp_Id9
      ,Product_Grp_Hier_Level_Cd9
      ,Product_Grp_Id10
      ,Product_Grp_Hier_Level_Cd10
      ,Product_Grp_Id11
      ,Product_Grp_Hier_Level_Cd11
      ,Product_Grp_IdLeaf
      ,Product_Grp_Hier_Level_CdLeaf
    )
    SELECT
         Product_Hier_Type_Cd 		as Product_Hier_Type_Cd
        ,Product_Grp_Id2                as Product_Grp_Id1
        ,Product_Grp_Hier_Level_Cd2     as Product_Grp_Hier_Level_Cd1
        ,Product_Grp_Id1                as Product_Grp_Id2
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_Cd2
        ,NULL                           as Product_Grp_Id3
        ,NULL                           as Product_Grp_Hier_Level_Cd3
        ,NULL                           as Product_Grp_Id4
        ,NULL                           as Product_Grp_Hier_Level_Cd4
        ,NULL                           as Product_Grp_Id5
        ,NULL                           as Product_Grp_Hier_Level_Cd5
        ,NULL                           as Product_Grp_Id6
        ,NULL                           as Product_Grp_Hier_Level_Cd6
        ,NULL                           as Product_Grp_Id7
        ,NULL                           as Product_Grp_Hier_Level_Cd7
        ,NULL                           as Product_Grp_Id8
        ,NULL                           as Product_Grp_Hier_Level_Cd8
        ,NULL                           as Product_Grp_Id9
        ,NULL                           as Product_Grp_Hier_Level_Cd9
        ,NULL                           as Product_Grp_Id10
        ,NULL                           as Product_Grp_Hier_Level_Cd10
        ,NULL                           as Product_Grp_Id11
        ,NULL                           as Product_Grp_Hier_Level_Cd11
        ,Product_Grp_Id1                as Product_Grp_IdLeaf
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_CdLeaf
      FROM TempProductHierBuild
      WHERE MaxLevelNumber = 2
  ;

  SET cMessage = 'CHKP 13 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

  INSERT INTO TempProductHierBuild2 (
       Product_Hier_Type_Cd 
      ,Product_Grp_Id1
      ,Product_Grp_Hier_Level_Cd1
      ,Product_Grp_Id2
      ,Product_Grp_Hier_Level_Cd2
      ,Product_Grp_Id3
      ,Product_Grp_Hier_Level_Cd3
      ,Product_Grp_Id4
      ,Product_Grp_Hier_Level_Cd4
      ,Product_Grp_Id5
      ,Product_Grp_Hier_Level_Cd5
      ,Product_Grp_Id6
      ,Product_Grp_Hier_Level_Cd6
      ,Product_Grp_Id7
      ,Product_Grp_Hier_Level_Cd7
      ,Product_Grp_Id8
      ,Product_Grp_Hier_Level_Cd8
      ,Product_Grp_Id9
      ,Product_Grp_Hier_Level_Cd9
      ,Product_Grp_Id10
      ,Product_Grp_Hier_Level_Cd10
      ,Product_Grp_Id11
      ,Product_Grp_Hier_Level_Cd11
      ,Product_Grp_IdLeaf
      ,Product_Grp_Hier_Level_CdLeaf
    )
    SELECT
         Product_Hier_Type_Cd 		as Product_Hier_Type_Cd
        ,Product_Grp_Id1                as Product_Grp_Id1
        ,Product_Grp_Hier_Level_Cd2     as Product_Grp_Hier_Level_Cd1
        ,NULL                           as Product_Grp_Id2
        ,NULL                           as Product_Grp_Hier_Level_Cd2
        ,NULL                           as Product_Grp_Id3
        ,NULL                           as Product_Grp_Hier_Level_Cd3
        ,NULL                           as Product_Grp_Id4
        ,NULL                           as Product_Grp_Hier_Level_Cd4
        ,NULL                           as Product_Grp_Id5
        ,NULL                           as Product_Grp_Hier_Level_Cd5
        ,NULL                           as Product_Grp_Id6
        ,NULL                           as Product_Grp_Hier_Level_Cd6
        ,NULL                           as Product_Grp_Id7
        ,NULL                           as Product_Grp_Hier_Level_Cd7
        ,NULL                           as Product_Grp_Id8
        ,NULL                           as Product_Grp_Hier_Level_Cd8
        ,NULL                           as Product_Grp_Id9
        ,NULL                           as Product_Grp_Hier_Level_Cd9
        ,NULL                           as Product_Grp_Id10
        ,NULL                           as Product_Grp_Hier_Level_Cd10
        ,NULL                           as Product_Grp_Id11
        ,NULL                           as Product_Grp_Hier_Level_Cd11
        ,Product_Grp_Id1                as Product_Grp_IdLeaf
        ,Product_Grp_Hier_Level_Cd1     as Product_Grp_Hier_Level_CdLeaf
      FROM TempProductHierBuild
      WHERE MaxLevelNumber = 1
  ;

  SET cMessage = 'CHKP 14 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

  DELETE FROM SCReport.DimProduct ALL;

  INSERT INTO SCReport.DimProduct (
       Product_Id
      ,Product_Name
      ,Product_Desc
      ,Product_Start_Dt
      ,Product_End_Dt
      ,Product_Type_Cd
      ,Product_Reference_Num
      ,Product_Subtype_1_Cd
      ,Product_Subtype_2_Cd
      ,Product_Subtype_3_Cd
      ,Product_Subtype_1_Name
      ,Product_Subtype_2_Name
      ,Product_Subtype_3_Name
      ,Source_Product_Type_Cd
      ,Network_Type_Cd
      ,Supplier_Party_Id
      ,Tax_Type_Cd
      ,VAT_Pct
      ,Warranty_Period_Num
      ,Confirm_Product_Ind
      ,Network_Sub_Type_Cd
      ,Vendor_Name
      ,Manufacturer_Model_Number_Val
      ,Product_Ass_Start_Dt
      ,Product_Ass_Start_Tm
      ,Record_Start_Dt
      ,Record_Start_Tm
      ,Product_Ass_End_Dt
      ,Product_Ass_End_Tm
      ,Record_End_Dt
      ,Record_End_Tm
      ,Product_Hier_Type_Cd
      ,Product_Hier_Type_Name
      ,Product_Grp_IdL01
      ,Product_Grp_NameL01
      ,Product_Grp_DescL01
      ,Product_Grp_Upgrd_Elgbl_IndL01
      ,Product_Grp_Upgrd_Famly_IndL01
      ,Product_Grp_Ranking_StringL01
      ,Product_Grp_Heir_CdL01
      ,Product_Grp_IdL02
      ,Product_Grp_NameL02
      ,Product_Grp_DescL02
      ,Product_Grp_Upgrd_Elgbl_IndL02
      ,Product_Grp_Upgrd_Famly_IndL02
      ,Product_Grp_Ranking_StringL02
      ,Product_Grp_Heir_CdL02
      ,Product_Grp_IdL03
      ,Product_Grp_NameL03
      ,Product_Grp_DescL03
      ,Product_Grp_Upgrd_Elgbl_IndL03
      ,Product_Grp_Upgrd_Famly_IndL03
      ,Product_Grp_Ranking_StringL03
      ,Product_Grp_Heir_CdL03
      ,Product_Grp_IdL04
      ,Product_Grp_NameL04
      ,Product_Grp_DescL04
      ,Product_Grp_Upgrd_Elgbl_IndL04
      ,Product_Grp_Upgrd_Famly_IndL04
      ,Product_Grp_Ranking_StringL04
      ,Product_Grp_Heir_CdL04
      ,Product_Grp_IdL05
      ,Product_Grp_NameL05
      ,Product_Grp_DescL05
      ,Product_Grp_Upgrd_Elgbl_IndL05
      ,Product_Grp_Upgrd_Famly_IndL05
      ,Product_Grp_Ranking_StringL05
      ,Product_Grp_Heir_CdL05
      ,Product_Grp_IdL06
      ,Product_Grp_NameL06
      ,Product_Grp_DescL06
      ,Product_Grp_Upgrd_Elgbl_IndL06
      ,Product_Grp_Upgrd_Famly_IndL06
      ,Product_Grp_Ranking_StringL06
      ,Product_Grp_Heir_CdL06
      ,Product_Grp_IdL07
      ,Product_Grp_NameL07
      ,Product_Grp_DescL07
      ,Product_Grp_Upgrd_Elgbl_IndL07
      ,Product_Grp_Upgrd_Famly_IndL07
      ,Product_Grp_Ranking_StringL07
      ,Product_Grp_Heir_CdL07
      ,Product_Grp_IdL08
      ,Product_Grp_NameL08
      ,Product_Grp_DescL08
      ,Product_Grp_Upgrd_Elgbl_IndL08
      ,Product_Grp_Upgrd_Famly_IndL08
      ,Product_Grp_Ranking_StringL08
      ,Product_Grp_Heir_CdL08
      ,Product_Grp_IdL09
      ,Product_Grp_NameL09
      ,Product_Grp_DescL09
      ,Product_Grp_Upgrd_Elgbl_IndL09
      ,Product_Grp_Upgrd_Famly_IndL09
      ,Product_Grp_Ranking_StringL09
      ,Product_Grp_Heir_CdL09
      ,Product_Grp_IdL10
      ,Product_Grp_NameL10
      ,Product_Grp_DescL10
      ,Product_Grp_Upgrd_Elgbl_IndL10
      ,Product_Grp_Upgrd_Famly_IndL10
      ,Product_Grp_Ranking_StringL10
      ,Product_Grp_Heir_CdL10
      ,Product_Grp_IdL11
      ,Product_Grp_NameL11
      ,Product_Grp_DescL11
      ,Product_Grp_Upgrd_Elgbl_IndL11
      ,Product_Grp_Upgrd_Famly_IndL11
      ,Product_Grp_Ranking_StringL11
      ,Product_Grp_Heir_CdL11
    )
    SELECT
         p.Product_Id
        ,p.Product_Name
        ,p.Product_Desc
        ,p.Product_Start_Dt
        ,p.Product_End_Dt
        ,p.Product_Type_Cd
        ,p.Product_Reference_Num
        ,p.Product_SubType_1_Cd
        ,p.Product_SubType_2_Cd
        ,p.Product_SubType_3_Cd
        ,p.Product_SubType_1_Name
        ,p.Product_SubType_2_Name
        ,p.Product_SubType_3_Name
        ,p.Source_Product_Type_Cd
        ,p.Network_Type_Cd
        ,p.Supplier_Party_Id
        ,p.Tax_Type_Cd
        ,p.VAT_Pct
        ,p.Warranty_Period_Num
        ,p.Confirm_Product_Ind
        ,p.Network_Sub_Type_Cd
        ,p.Vendor_Name
        ,p.Manufacturer_Model_Number_Val

        ,pga.Product_Ass_Start_Dt
        ,pga.Product_Ass_Start_Tm
        ,pga.Record_Start_Dt
        ,pga.Record_Start_Tm
        ,pga.Product_Ass_End_Dt
        ,pga.Product_Ass_End_Tm
        ,pga.Record_End_Dt
        ,pga.Record_End_Tm

        ,tphb2.Product_Hier_Type_Cd		as Product_Hier_Type_Cd
        ,pht.Product_Hier_Type_Name		as Product_Hier_Type_Name

        ,pg1.Product_Grp_Id 			as Product_Grp_IdL01
        ,pg1.Product_Grp_Name			as Product_Grp_NameL01
        ,pg1.Product_Grp_Desc			as Product_Grp_DescL01
        ,pg1.Product_Grp_Upgrd_Elgbl_Ind	as Product_Grp_Upgrd_Elgbl_IndL01
        ,pg1.Product_Grp_Upgrd_Family_Ind	as Product_Grp_Upgrd_Famly_IndL01
        ,pg1.Product_Grp_Ranking_String		as Product_Grp_Ranking_StringL01
        ,tphb2.Product_Grp_Hier_Level_Cd1	as Product_Grp_Heir_CdL01

        ,pg2.Product_Grp_Id 			as Product_Grp_IdL02
        ,pg2.Product_Grp_Name			as Product_Grp_NameL02
        ,pg2.Product_Grp_Desc			as Product_Grp_DescL02
        ,pg2.Product_Grp_Upgrd_Elgbl_Ind	as Product_Grp_Upgrd_Elgbl_IndL02
        ,pg2.Product_Grp_Upgrd_Family_Ind	as Product_Grp_Upgrd_Famly_IndL02
        ,pg2.Product_Grp_Ranking_String		as Product_Grp_Ranking_StringL02
        ,tphb2.Product_Grp_Hier_Level_Cd2	as Product_Grp_Heir_CdL02

        ,pg3.Product_Grp_Id 			as Product_Grp_IdL03
        ,pg3.Product_Grp_Name			as Product_Grp_NameL03
        ,pg3.Product_Grp_Desc			as Product_Grp_DescL03
        ,pg3.Product_Grp_Upgrd_Elgbl_Ind	as Product_Grp_Upgrd_Elgbl_IndL03
        ,pg3.Product_Grp_Upgrd_Family_Ind	as Product_Grp_Upgrd_Famly_IndL03
        ,pg3.Product_Grp_Ranking_String		as Product_Grp_Ranking_StringL03
        ,tphb2.Product_Grp_Hier_Level_Cd3	as Product_Grp_Heir_CdL03

        ,pg4.Product_Grp_Id 			as Product_Grp_IdL04
        ,pg4.Product_Grp_Name			as Product_Grp_NameL04
        ,pg4.Product_Grp_Desc			as Product_Grp_DescL04
        ,pg4.Product_Grp_Upgrd_Elgbl_Ind	as Product_Grp_Upgrd_Elgbl_IndL04
        ,pg4.Product_Grp_Upgrd_Family_Ind	as Product_Grp_Upgrd_Famly_IndL04
        ,pg4.Product_Grp_Ranking_String		as Product_Grp_Ranking_StringL04
        ,tphb2.Product_Grp_Hier_Level_Cd4	as Product_Grp_Heir_CdL04

        ,pg5.Product_Grp_Id 			as Product_Grp_IdL05
        ,pg5.Product_Grp_Name			as Product_Grp_NameL05
        ,pg5.Product_Grp_Desc			as Product_Grp_DescL05
        ,pg5.Product_Grp_Upgrd_Elgbl_Ind	as Product_Grp_Upgrd_Elgbl_IndL05
        ,pg5.Product_Grp_Upgrd_Family_Ind	as Product_Grp_Upgrd_Famly_IndL05
        ,pg5.Product_Grp_Ranking_String		as Product_Grp_Ranking_StringL05
        ,tphb2.Product_Grp_Hier_Level_Cd5	as Product_Grp_Heir_CdL05

        ,pg6.Product_Grp_Id 			as Product_Grp_IdL06
        ,pg6.Product_Grp_Name			as Product_Grp_NameL06
        ,pg6.Product_Grp_Desc			as Product_Grp_DescL06
        ,pg6.Product_Grp_Upgrd_Elgbl_Ind	as Product_Grp_Upgrd_Elgbl_IndL06
        ,pg6.Product_Grp_Upgrd_Family_Ind	as Product_Grp_Upgrd_Famly_IndL06
        ,pg6.Product_Grp_Ranking_String		as Product_Grp_Ranking_StringL06
        ,tphb2.Product_Grp_Hier_Level_Cd6	as Product_Grp_Heir_CdL06

        ,pg7.Product_Grp_Id 			as Product_Grp_IdL07
        ,pg7.Product_Grp_Name			as Product_Grp_NameL07
        ,pg7.Product_Grp_Desc			as Product_Grp_DescL07
        ,pg7.Product_Grp_Upgrd_Elgbl_Ind	as Product_Grp_Upgrd_Elgbl_IndL07
        ,pg7.Product_Grp_Upgrd_Family_Ind	as Product_Grp_Upgrd_Famly_IndL07
        ,pg7.Product_Grp_Ranking_String		as Product_Grp_Ranking_StringL07
        ,tphb2.Product_Grp_Hier_Level_Cd7	as Product_Grp_Heir_CdL07

        ,pg8.Product_Grp_Id 			as Product_Grp_IdL08
        ,pg8.Product_Grp_Name			as Product_Grp_NameL08
        ,pg8.Product_Grp_Desc			as Product_Grp_DescL08
        ,pg8.Product_Grp_Upgrd_Elgbl_Ind	as Product_Grp_Upgrd_Elgbl_IndL08
        ,pg8.Product_Grp_Upgrd_Family_Ind	as Product_Grp_Upgrd_Famly_IndL08
        ,pg8.Product_Grp_Ranking_String		as Product_Grp_Ranking_StringL08
        ,tphb2.Product_Grp_Hier_Level_Cd8	as Product_Grp_Heir_CdL08

        ,pg9.Product_Grp_Id 			as Product_Grp_IdL09
        ,pg9.Product_Grp_Name			as Product_Grp_NameL09
        ,pg9.Product_Grp_Desc			as Product_Grp_DescL09
        ,pg9.Product_Grp_Upgrd_Elgbl_Ind	as Product_Grp_Upgrd_Elgbl_IndL09
        ,pg9.Product_Grp_Upgrd_Family_Ind	as Product_Grp_Upgrd_Famly_IndL09
        ,pg9.Product_Grp_Ranking_String		as Product_Grp_Ranking_StringL09
        ,tphb2.Product_Grp_Hier_Level_Cd9	as Product_Grp_Heir_CdL09

        ,pg10.Product_Grp_Id 			as Product_Grp_IdL10
        ,pg10.Product_Grp_Name		as Product_Grp_NameL10
        ,pg10.Product_Grp_Desc			as Product_Grp_DescL10
        ,pg10.Product_Grp_Upgrd_Elgbl_Ind	as Product_Grp_Upgrd_Elgbl_IndL10
        ,pg10.Product_Grp_Upgrd_Family_Ind	as Product_Grp_Upgrd_Famly_IndL10
        ,pg10.Product_Grp_Ranking_String	as Product_Grp_Ranking_StringL10
        ,tphb2.Product_Grp_Hier_Level_Cd10	as Product_Grp_Heir_CdL10

        ,pg11.Product_Grp_Id 			as Product_Grp_IdL11
        ,pg11.Product_Grp_Name		as Product_Grp_NameL11
        ,pg11.Product_Grp_Desc			as Product_Grp_DescL11
        ,pg11.Product_Grp_Upgrd_Elgbl_Ind	as Product_Grp_Upgrd_Elgbl_IndL11
        ,pg11.Product_Grp_Upgrd_Family_Ind	as Product_Grp_Upgrd_Famly_IndL11
        ,pg11.Product_Grp_Ranking_String	as Product_Grp_Ranking_StringL11
        ,tphb2.Product_Grp_Hier_Level_Cd11	as Product_Grp_Heir_CdL11

      FROM Product_Group_Association pga

      INNER JOIN Product p
        ON pga.Product_Id  = p.Product_Id
	  --AND :dChangeDate BETWEEN p.Product_Start_Dt AND p.Product_End_Dt

      INNER JOIN TempProductHierBuild2 tphb2
        ON tphb2.Product_Grp_IdLeaf = pga.Product_Grp_Id

      LEFT OUTER JOIN Product_Hierarchy_Type pht
        ON tphb2.Product_Hier_Type_Cd = pht.Product_Hier_Type_Cd

      LEFT OUTER JOIN Product_Group pg1
        ON tphb2.Product_Grp_Id1 = pg1.Product_Grp_Id

      LEFT OUTER JOIN Product_Group pg2
        ON tphb2.Product_Grp_Id2 = pg2.Product_Grp_Id

      LEFT OUTER JOIN Product_Group pg3
        ON tphb2.Product_Grp_Id3 = pg3.Product_Grp_Id

      LEFT OUTER JOIN Product_Group pg4
        ON tphb2.Product_Grp_Id4 = pg4.Product_Grp_Id

      LEFT OUTER JOIN Product_Group pg5
        ON tphb2.Product_Grp_Id5 = pg5.Product_Grp_Id

      LEFT OUTER JOIN Product_Group pg6
        ON tphb2.Product_Grp_Id6 = pg6.Product_Grp_Id

      LEFT OUTER JOIN Product_Group pg7
        ON tphb2.Product_Grp_Id7 = pg7.Product_Grp_Id

      LEFT OUTER JOIN Product_Group pg8
        ON tphb2.Product_Grp_Id8 = pg8.Product_Grp_Id

      LEFT OUTER JOIN Product_Group pg9
        ON tphb2.Product_Grp_Id9 = pg9.Product_Grp_Id

      LEFT OUTER JOIN Product_Group pg10
        ON tphb2.Product_Grp_Id10 = pg10.Product_Grp_Id

      LEFT OUTER JOIN Product_Group pg11
        ON tphb2.Product_Grp_Id11 = pg11.Product_Grp_Id

      --WHERE :dChangeDate BETWEEN pga.Product_Ass_Start_Dt AND pga.Product_Ass_End_Dt
	--AND :dChangeDate BETWEEN pga.Record_Start_Dt AND pga.Record_End_Dt
	--AND '00:00:00' BETWEEN pga.Product_Ass_Start_Tm AND pga.Product_Ass_End_Tm
	--AND '00:00:00' BETWEEN pga.Record_Start_Tm AND pga.Record_End_Tm
   ;

  SET cMessage = 'CHKP 15 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Inserted';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

  UPDATE SCReport.DimProduct
    SET 
      UpgradeEligibleFlag =
        CASE WHEN
          COALESCE(Product_Grp_Upgrd_Elgbl_IndL01,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Elgbl_IndL02,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Elgbl_IndL03,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Elgbl_IndL04,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Elgbl_IndL05,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Elgbl_IndL06,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Elgbl_IndL07,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Elgbl_IndL08,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Elgbl_IndL09,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Elgbl_IndL10,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Elgbl_IndL11,'T') = 'T'
          THEN 'T'
        ELSE 'F'
        END,
      UpgradeFamilyEligibleFlag =
        CASE WHEN
          COALESCE(Product_Grp_Upgrd_Famly_IndL01,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Famly_IndL02,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Famly_IndL03,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Famly_IndL04,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Famly_IndL05,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Famly_IndL06,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Famly_IndL07,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Famly_IndL08,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Famly_IndL09,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Famly_IndL10,'T') = 'T'
            AND COALESCE(Product_Grp_Upgrd_Famly_IndL11,'T') = 'T'
          THEN 'T'
        ELSE 'F'
        END,
      UpgradeRanking =
        CAST(CASE WHEN Product_Grp_Ranking_StringL01 IS NULL THEN '000000' ELSE SUBSTRING('000000' FROM CHAR_LENGTH(TRIM(Product_Grp_Ranking_StringL01)) + 1) || TRIM(Product_Grp_Ranking_StringL01) END AS CHAR(6)) ||
        CAST(CASE WHEN Product_Grp_Ranking_StringL02 IS NULL THEN '000000' ELSE SUBSTRING('000000' FROM CHAR_LENGTH(TRIM(Product_Grp_Ranking_StringL02)) + 1) || TRIM(Product_Grp_Ranking_StringL02) END AS CHAR(6)) ||
        CAST(CASE WHEN Product_Grp_Ranking_StringL03 IS NULL THEN '000000' ELSE SUBSTRING('000000' FROM CHAR_LENGTH(TRIM(Product_Grp_Ranking_StringL03)) + 1) || TRIM(Product_Grp_Ranking_StringL03) END AS CHAR(6)) ||
        CAST(CASE WHEN Product_Grp_Ranking_StringL04 IS NULL THEN '000000' ELSE SUBSTRING('000000' FROM CHAR_LENGTH(TRIM(Product_Grp_Ranking_StringL04)) + 1) || TRIM(Product_Grp_Ranking_StringL04) END AS CHAR(6)) ||
        CAST(CASE WHEN Product_Grp_Ranking_StringL05 IS NULL THEN '000000' ELSE SUBSTRING('000000' FROM CHAR_LENGTH(TRIM(Product_Grp_Ranking_StringL05)) + 1) || TRIM(Product_Grp_Ranking_StringL05) END AS CHAR(6)) ||
        CAST(CASE WHEN Product_Grp_Ranking_StringL06 IS NULL THEN '000000' ELSE SUBSTRING('000000' FROM CHAR_LENGTH(TRIM(Product_Grp_Ranking_StringL06)) + 1) || TRIM(Product_Grp_Ranking_StringL06) END AS CHAR(6)) ||
        CAST(CASE WHEN Product_Grp_Ranking_StringL07 IS NULL THEN '000000' ELSE SUBSTRING('000000' FROM CHAR_LENGTH(TRIM(Product_Grp_Ranking_StringL07)) + 1) || TRIM(Product_Grp_Ranking_StringL07) END AS CHAR(6)) ||
        CAST(CASE WHEN Product_Grp_Ranking_StringL08 IS NULL THEN '000000' ELSE SUBSTRING('000000' FROM CHAR_LENGTH(TRIM(Product_Grp_Ranking_StringL08)) + 1) || TRIM(Product_Grp_Ranking_StringL08) END AS CHAR(6)) ||
        CAST(CASE WHEN Product_Grp_Ranking_StringL09 IS NULL THEN '000000' ELSE SUBSTRING('000000' FROM CHAR_LENGTH(TRIM(Product_Grp_Ranking_StringL09)) + 1) || TRIM(Product_Grp_Ranking_StringL09) END AS CHAR(6)) ||
        CAST(CASE WHEN Product_Grp_Ranking_StringL10 IS NULL THEN '000000' ELSE SUBSTRING('000000' FROM CHAR_LENGTH(TRIM(Product_Grp_Ranking_StringL10)) + 1) || TRIM(Product_Grp_Ranking_StringL10) END AS CHAR(6)) ||
        CAST(CASE WHEN Product_Grp_Ranking_StringL11 IS NULL THEN '000000' ELSE SUBSTRING('000000' FROM CHAR_LENGTH(TRIM(Product_Grp_Ranking_StringL10)) + 1) || TRIM(Product_Grp_Ranking_StringL10) END AS CHAR(6)) 
  ;

  SET cMessage = 'CHKP 16 - RowCount: ' || (cast(Activity_Count as Varchar(15)))||' Updated';
  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsChkpTime,:tsEndTime,:cMessage,:cSPName,:nProcessKey);
  SET tsChkpTime  = CURRENT_TIMESTAMP(2);

--=====================================================================================


	SELECT count(0) INTO :errPGACount FROM Product_Group_Association pg0
          INNER JOIN Product_Group_Hierarchy pgh1
            ON pg0.Product_Grp_Id = pgh1.Child_Product_Grp_Id
              AND :dChangeDate BETWEEN pgh1.Product_Grp_Related_Start_Dt AND pgh1.Product_Grp_Related_End_Dt
              AND :dChangeDate BETWEEN pgh1.Record_Start_Dt AND pgh1.Record_End_Dt
              AND '00:00:00' BETWEEN pgh1.Product_Grp_Related_Start_Tm AND pgh1.Product_Grp_Related_End_Tm
              AND '00:00:00' BETWEEN pgh1.Record_Start_Tm AND pgh1.Record_End_Tm
        ;
	SELECT count(0) INTO :errDPCount FROM SCReport.DimProduct;

	IF errPGACount <> errDPCount THEN
		SET bError = 1;
		SET cMessage  = 'Record count in Product_Group_Association does not match with DimProduct';
  		CALL RTF_ProcessMessage_Add ('E',0,:cMessage,:cSPName,:nProcessKey,0); 
	END IF;


END MainProc;
--=====================================================================================
--<<ExitFunction>>
  IF bError = 1 THEN 
    SET cMessage  = 'FAILED RUN TIME';
  ELSE
    SET cMessage  = 'TOTAL RUN TIME' ;
  END IF;

  SET tsEndTime = CURRENT_TIMESTAMP(2);
  CALL RTF_ProcessMessage_RunTime(:tsStartTime, :tsEndTime, :cMessage, :cSPName, :nProcessKey);
 
--  LoadProducts
END;