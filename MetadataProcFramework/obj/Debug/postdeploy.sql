-- This file contains SQL statements that will be executed after the build script.
-- Write your own SQL object definition here, and it'll be included in your package.
DECLARE @DataSourceType AS TABLE (
    [Id] INT NOT NULL
    , [Name] VARCHAR(50) NOT NULL
    , [Description] NVARCHAR(255)
    , [DefaulDataSetPropertiesMetaQuery] VARCHAR(MAX)
    );
DECLARE @defaulDataSetPropertiesMetaQuery VARCHAR(MAX);

SET @defaulDataSetPropertiesMetaQuery = 
    'WITH ObjectInfo
 AS (
    SELECT col.[name] AS ColumnName
        , tab.[name] AS TableName
        , s.[name] AS TableSchema
    FROM sys.tables tab
    INNER JOIN sys.indexes pk
        ON tab.object_id = pk.object_id
            AND pk.is_primary_key = 1
    INNER JOIN sys.index_columns ic
        ON ic.object_id = pk.object_id
            AND ic.index_id = pk.index_id
    INNER JOIN sys.columns col
        ON pk.object_id = col.object_id
            AND col.column_id = ic.column_id
    INNER JOIN sys.schemas s
        ON tab.schema_id = s.schema_id
    )
 SELECT 
    %%DataSourceId%% AS DataSourceId 
    ,t.TABLE_NAME AS DataSetName
    , c.TABLE_SCHEMA AS DataSetSchema
    , c.COLUMN_NAME AS DataSetPropertyName
    , c.ORDINAL_POSITION AS DataSetPropertyOrdinalPosition
    , c.DATA_TYPE AS DataSetPropertyDataType
    , CASE 
        WHEN c.NUMERIC_PRECISION IS NOT NULL
            AND c.NUMERIC_SCALE IS NOT NULL
            AND c.DATA_TYPE NOT IN (''int'')
            THEN CONCAT (
                    ''(''
                    , CAST(c.NUMERIC_PRECISION AS VARCHAR)
                    , '',''
                    , CAST(c.NUMERIC_SCALE AS VARCHAR)
                    , '')''
                    )
        WHEN c.CHARACTER_MAXIMUM_LENGTH IS NOT NULL
            THEN CONCAT (
                    ''(''
                    , CAST(c.CHARACTER_MAXIMUM_LENGTH AS VARCHAR)
                    , '')''
                    )
        END AS DataSetPropertyDataTypePrecision
    , TRY_CAST(CASE 
            WHEN oi.ColumnName IS NOT NULL
                THEN 1
            ELSE 0
            END AS BIT) AS DataSetPropertyIsPrimaryKey
    , CASE 
        WHEN c.IS_NULLABLE = ''YES''
            THEN CAST(1 AS BIT)
        WHEN c.IS_NULLABLE = ''NO''
            THEN CAST(0 AS BIT)
        ELSE CAST(1 AS BIT)
        END AS DataSetPropertyIsNullable
 FROM INFORMATION_SCHEMA.TABLES AS t
 INNER JOIN INFORMATION_SCHEMA.COLUMNS AS c
    ON t.TABLE_NAME = c.TABLE_NAME
        AND t.TABLE_SCHEMA = c.TABLE_SCHEMA
 LEFT JOIN ObjectInfo AS oi
    ON t.TABLE_NAME = oi.TableName
        AND c.COLUMN_NAME = oi.ColumnName
        AND t.TABLE_SCHEMA = oi.TableSchema
    WHERE t.TABLE_TYPE =''BASE TABLE'' AND t.TABLE_SCHEMA <> ''sys'' '
    ;

INSERT INTO @DataSourceType (
    [Id]
    , [Name]
    , [Description]
    , [DefaulDataSetPropertiesMetaQuery]
    )
VALUES (
    1
    , 'MSSQL SERVER'
    , 'MSSQL SERVER'
    , @defaulDataSetPropertiesMetaQuery
    );

SET XACT_ABORT ON;

BEGIN TRAN

MERGE [load].DataSourceType AS trg
USING (
    SELECT Id
        , [Name]
        , [Description]
        , [DefaulDataSetPropertiesMetaQuery]
    FROM @DataSourceType
    ) AS src
    ON (trg.Id = src.Id)
WHEN MATCHED
    THEN
        UPDATE
        SET [Name] = src.[Name]
            , [Description] = src.[Description]
            , [DefaulDataSetPropertiesMetaQuery] = src.[DefaulDataSetPropertiesMetaQuery]
WHEN NOT MATCHED
    THEN
        INSERT (
            Id
            , [Name]
            , [Description]
            , [DefaulDataSetPropertiesMetaQuery]
            )
        VALUES (
            src.Id
            , src.[Name]
            , src.[Description]
            , src.[DefaulDataSetPropertiesMetaQuery]
            );

COMMIT TRAN;
DECLARE @DataSource AS TABLE
(
    [DataSourceTypeId] INT NOT NULL,
    [Name] VARCHAR(255) NOT NULL,
    [Description] NVARCHAR(255) NOT NULL
);
INSERT INTO @DataSource
    (DataSourceTypeId,[Name],[Description])
VALUES(1, 'AdventureWorksLT', 'Sample AdventureWorksLT DS');

SET XACT_ABORT ON;

BEGIN TRAN

MERGE [load].DataSource AS trg
USING (
    SELECT
    DataSourceTypeId
        , [Name]
        , [Description]
FROM @DataSource
    ) AS src
    ON (trg.[Name] = src.[Name])
WHEN MATCHED
    THEN
        UPDATE
        SET DataSourceTypeId =src.DataSourceTypeId
            , [Description] = src.[Description]
WHEN NOT MATCHED
    THEN
        INSERT (
            DataSourceTypeId
            , [Name]
            , [Description]
            )
        VALUES (
            src.DataSourceTypeId
            , src.[Name]
            , src.[Description]
            );

COMMIT TRAN;
GO
