CREATE TABLE [load].[DataSet]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[DataSourceId] INT NOT NULL,
	[Name] VARCHAR(255) NOT NULL,
	[Schema] VARCHAR(255) NULL,
	[Description] NVARCHAR(255) NULL,
	[IsDeletedInSource] BIT,
	[ChangeDate] DATETIME2(7) NOT NULL
	CONSTRAINT [DF_DataSet_ChangeDate] DEFAULT SYSDATETIME(),
	[IsActive] BIT NOT NULL 
	CONSTRAINT [DF_DataSet_IsActive] DEFAULT 1,
	CONSTRAINT [PK_DataSet] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_DataSet_DataSourceId] 
  FOREIGN KEY ([DataSourceId]) REFERENCES [load].[DataSource] ([Id])
);

GO
CREATE UNIQUE INDEX [IX_U_DataSet_DataSourceId_Schema_Name] 
	ON [load].[DataSet](DataSourceId,[Schema],[Name]);
