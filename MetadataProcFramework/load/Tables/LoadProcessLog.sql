CREATE TABLE [load].[LoadProcessLog]
(
  [Id] INT NOT NULL IDENTITY(1,1),
  [ProcLogPipelineId] VARCHAR(255) NOT NULL,
  [LoadConfigId] INT NOT NULL,
  [StartDate] DATETIME2(7) NOT NULL
  CONSTRAINT [DF_LoadProcessLog_StartDate] DEFAULT SYSDATETIME(),
  [EndDate] DATETIME2(7),
  CONSTRAINT [PK_LoadProcessLog] PRIMARY KEY CLUSTERED ([Id] ASC),
  CONSTRAINT [FK_LoadDataSetConfig_LoadModeId] 
  FOREIGN KEY ([LoadConfigId]) REFERENCES [load].[LoadMode] ([Id])
)
