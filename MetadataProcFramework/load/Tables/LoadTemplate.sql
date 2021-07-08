CREATE TABLE [load].[LoadTemplate]
(
  [Id] INT NOT NULL IDENTITY(1,1),
  [LoadTemplateTypeId] INT NOT NULL,
  [DataSourceTypeId] INT NOT NULL,
  [Template] NVARCHAR(MAX) NOT NULL,
  CONSTRAINT [PK_LoadTemplate] PRIMARY KEY CLUSTERED ([Id] ASC),
  CONSTRAINT [FK_LoadTemplateLoadTemplateTypeId] 
  FOREIGN KEY ([LoadTemplateTypeId]) REFERENCES [load].[LoadTemplateType] ([Id]),
  CONSTRAINT [FK_LoadTemplateDataSourceTypeId] 
  FOREIGN KEY ([DataSourceTypeId]) REFERENCES [load].[DataSourceType] ([Id])
)
GO
CREATE UNIQUE INDEX [IX_U_LoadTemplate] 
  ON [load].[LoadTemplate]([LoadTemplateTypeId],[DataSourceTypeId]);
