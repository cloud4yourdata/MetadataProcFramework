CREATE TABLE [load].[LoadConfig]
(
  [Id] INT NOT NULL IDENTITY(1,1),
  [DataSourceId] INT NOT NULL,
  [ConfigName] VARCHAR(255) NOT NULL,
  [ContainerName] VARCHAR(255) NOT NULL,
  [MainFolderName] VARCHAR(255) NOT NULL,
  CONSTRAINT [PK_LoadConfig] PRIMARY KEY CLUSTERED ([Id] ASC)
)
