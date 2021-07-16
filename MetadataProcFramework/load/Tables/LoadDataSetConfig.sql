CREATE TABLE [load].[LoadDataSetConfig]
(
  [Id] INT NOT NULL IDENTITY(1,1),
  [LoadConfigId] INT NOT NULL,
  [DataSetId] INT NOT NULL,
  [LoadModeId] INT NOT NULL,
  CONSTRAINT [PK_LoadDataSetConfig] PRIMARY KEY CLUSTERED ([Id] ASC),
  CONSTRAINT [FK_LoadDataSetConfig_LoadConfigId]
  FOREIGN KEY ([LoadConfigId]) REFERENCES [load].[LoadConfig] ([Id]),
  CONSTRAINT [FK_LoadDataSetConfig_DataSetId] 
  FOREIGN KEY ([DataSetId]) REFERENCES [load].[DataSet] ([Id]),
  CONSTRAINT [FK_LoadDataSetConfig_LoadModeId] 
  FOREIGN KEY ([LoadModeId]) REFERENCES [load].[LoadMode] ([Id])
)
