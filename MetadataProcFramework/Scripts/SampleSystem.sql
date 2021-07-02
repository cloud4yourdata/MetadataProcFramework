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