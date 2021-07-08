DECLARE @loadTemplateParam TABLE
(
  [Id] INT,
  [Name] NVARCHAR (50),
  [Description] NVARCHAR (255)
);

INSERT INTO @loadTemplateParam(Id,[Name],[Description])
VALUES
(1,'%%DataSourceId%%', 'Data Source Id'),
(2,'%%FullDataSetName%%','Data Set Full Name e.g. Schema.Table'),
(3,'%%DataSetUniquePropertyList%%','Data Set unique property list e.g. PKs columns'),
(4,'%%MaxRowsPerFile%%','Max rows per file e.g. 1000000.0 it must be float'),
(5,'%%DataSetPropertyList%%','Data Set property list e.g. columns col1,col2,col3'),
(6,'%%LoadFileGroup%%','Load file group e.g. 0 or 1')
;

MERGE [load].LoadTemplateParam AS trg
USING (
    SELECT Id
        , [Name]
        , [Description]
    FROM @loadTemplateParam
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

