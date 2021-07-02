CREATE PROCEDURE [load].usp_SynchroDataSetMetadata
AS
BEGIN
  SET XACT_ABORT ON;
  BEGIN TRAN
  --DataSet
  INSERT INTO [load].DataSet
    (DataSourceId,[Name],[Schema],[Description],IsActive)
  SELECT DISTINCT src.DataSourceId, src.DataSetName AS [Name],
    src.DataSetSchema AS [Schema], src.DataSetName AS [Description],
    CAST(1 AS BIT) AS IsActive
  FROM [load].[DataSourceMetadata] AS src
    LEFT JOIN [load].DataSet AS trg
    ON trg.DataSourceId = src.DataSourceId
      AND trg.[Schema] = src.[DataSetSchema]
      AND trg.[Name] = src.[DataSetName]
  WHERE trg.DataSourceId IS NULL;


  UPDATE trg SET trg.IsDeletedInSource = 1, ChangeDate = SYSDATETIME()
    FROM [load].DataSet AS trg
    LEFT JOIN [load].[DataSourceMetadata] AS src
    ON trg.DataSourceId = src.DataSourceId
      AND trg.[Schema] = src.[DataSetSchema]
      AND trg.[Name] = src.[DataSetName] 
  WHERE src.DataSourceId IS NULL;

  --DataProperty
  MERGE [load].DataSetProperty AS trg
USING
(
 SELECT ds.Id AS DataSetId, src.DataSetPropertyName AS [Name],
    src.DataSetPropertyOrdinalPosition AS OrdinalPosition,
    src.DataSetPropertyDataType AS DataType,
    src.DataSetPropertyDataTypePrecision AS DataTypePrecision,
    src.DataSetPropertyIsPrimaryKey AS IsPrimaryKey,
    src.DataSetPropertyIsNullable AS IsNullable,
    CAST(1 AS BIT) AS IsActive
  FROM [load].[DataSourceMetadata] AS src
    JOIN [load].DataSet AS ds
    ON ds.DataSourceId = src.DataSourceId
      AND ds.[Schema] = src.[DataSetSchema]
      AND ds.[Name] = src.[DataSetName]
) AS src
ON trg.DataSetId = src.DataSetId AND trg.[Name] = src.[Name]
WHEN MATCHED THEN
UPDATE SET OrdinalPosition = src.OrdinalPosition,
DataType = src.DataType,
DataTypePrecision = src.DataTypePrecision,
IsPrimaryKey = src.IsPrimaryKey,
IsNullable = src.IsNullable,
ChangeDate = SYSDATETIME()
WHEN NOT MATCHED THEN
INSERT (DataSetId,[Name],OrdinalPosition,DataType,DataTypePrecision,IsPrimaryKey,IsNullable)
VALUES (src.DataSetId,src.[Name],src.OrdinalPosition,src.DataType,src.DataTypePrecision,src.IsPrimaryKey,src.IsNullable);

  WITH
    DataProperty
    AS
    (
      SELECT ds.Id AS DataSetId, src.DataSetPropertyName AS [Name],
        src.DataSetPropertyOrdinalPosition AS OrdinalPosition,
        src.DataSetPropertyDataType AS DataType,
        src.DataSetPropertyDataTypePrecision AS DataTypePrecision,
        src.DataSetPropertyIsPrimaryKey AS IsPrimaryKey,
        src.DataSetPropertyIsNullable AS IsNullable,
        CAST(1 AS BIT) AS IsActive
      FROM [load].[DataSourceMetadata] AS src
        JOIN [load].DataSet AS ds
        ON ds.DataSourceId = src.DataSourceId
          AND ds.[Schema] = src.[DataSetSchema]
          AND ds.[Name] = src.[DataSetName]
    )
UPDATE dsp SET IsDeletedInSource = 1, ChangeDate = SYSDATETIME() 
FROM [load].DataSetProperty AS dsp
    LEFT JOIN DataProperty AS dp ON dp.DataSetId = dsp.DataSetId
      AND dp.[Name] = dsp.[Name]
WHERE dp.DataSetId IS NULL


  COMMIT TRAN
END
