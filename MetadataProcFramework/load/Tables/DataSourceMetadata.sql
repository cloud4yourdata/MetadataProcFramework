CREATE TABLE [load].[DataSourceMetadata]
(
  [Id] INT NOT NULL IDENTITY(1,1),
  [DataSourceId] INT NOT NULL,
  [DataSetName] VARCHAR(255) NOT NULL,
  [DataSetSchema] VARCHAR(255) NULL,
  [DataSetPropertyName] VARCHAR(255) NOT NULL,
  [DataSetPropertyOrdinalPosition] INT NOT NULL,
	[DataSetPropertyDataType]  VARCHAR(255) NOT NULL,
	[DataSetPropertyDataTypePrecision] VARCHAR(128),
	[DataSetPropertyIsPrimaryKey] BIT NOT NULL,
	[DataSetPropertyIsNullable] BIT NOT NULL,
  CONSTRAINT [PK_DataSourceMetadata] PRIMARY KEY CLUSTERED ([Id] ASC)
)
