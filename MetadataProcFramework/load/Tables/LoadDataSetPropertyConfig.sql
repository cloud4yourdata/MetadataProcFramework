CREATE TABLE [load].[LoadDataSetPropertyConfig]
(
  [Id] INT NOT NULL IDENTITY(1,1),
  [LoadDataSetConfigId] INT,
  [SourceDataSetPropertyId] INT,
  [Name] VARCHAR(255) NOT NULL,
  [Transformation] VARCHAR(255) NULL,
  [IsWaterMarkColumn] BIT NOT NULL,
  CONSTRAINT [PK_LoadDataSetPropertyConfig] PRIMARY KEY CLUSTERED ([Id] ASC)
)
