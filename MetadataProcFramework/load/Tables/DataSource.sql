CREATE TABLE [load].[DataSource]
(
  [Id] INT NOT NULL IDENTITY(1,1),
  [DataSourceTypeId] INT NOT NULL,
  [Name] VARCHAR(255) NOT NULL,
  [Description] NVARCHAR(255) NOT NULL,
  [DataSetPropertiesMetaQuery] VARCHAR(MAX),
  CONSTRAINT [PK_DataSource] PRIMARY KEY CLUSTERED ([Id] ASC),
  CONSTRAINT [FK_DataSourceDataSourceTypeId] 
  FOREIGN KEY ([DataSourceTypeId]) REFERENCES [load].[DataSourceType] ([Id])
);

GO
CREATE UNIQUE INDEX [IX_U_DataSource_Name] ON [load].[DataSource]([Name]);
