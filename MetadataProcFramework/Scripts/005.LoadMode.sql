DECLARE @loadModeType TABLE
(
  [Id] INT,
  [Name] NVARCHAR (50),
  [Description] NVARCHAR (255)
);

INSERT INTO @loadModeType([Id],[Name],[Description])
VALUES
(1,'FULL LOAD','All data is loaded '),
(2,'INCREMENTAL LOAD','Only subset is loaded (based on watermark)');

MERGE [load].LoadMode AS trg
USING (
    SELECT Id
        , [Name]
        , [Description]
    FROM @loadTemplateType
    ) AS src
    ON (trg.Id = src.Id)
WHEN MATCHED
    THEN
        UPDATE
        SET [Name] = src.[Name]
            , [Description] = src.[Description]
WHEN NOT MATCHED
    THEN
        INSERT (
            Id
            , [Name]
            , [Description]
            )
        VALUES (
            src.Id
            , src.[Name]
            , src.[Description]
            );

