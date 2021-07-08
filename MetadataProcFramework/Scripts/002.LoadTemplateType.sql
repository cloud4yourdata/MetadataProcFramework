DECLARE @loadTemplateType TABLE
(
  [Id] INT,
  [Name] NVARCHAR (50),
  [Description] NVARCHAR (255)
);

INSERT INTO @loadTemplateType([Id],[Name],[Description])
VALUES
(1,'LOAD-META-DATA','Load source objects metadata (tables,columns,columns types...) '),
(2,'LOAD-ROWS-COUNT','Load data source rows count'),
(3,'LOAD-DATA','Load source data');

MERGE [load].LoadTemplateType AS trg
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

