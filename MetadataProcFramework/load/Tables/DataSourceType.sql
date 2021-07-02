CREATE TABLE [load].[DataSourceType] (
    [Id] INT NOT NULL
    , [Name] NVARCHAR(50) NOT NULL
    , [Description] NVARCHAR(255) NULL
	, [DefaulDataSetPropertiesMetaQuery] VARCHAR(MAX)
    , CONSTRAINT [PK_DataSourceType] PRIMARY KEY CLUSTERED ([Id] ASC)
    )
GO
CREATE UNIQUE INDEX [IX_U_DataSourceType_Name] ON [load].[DataSourceType]([Name]);