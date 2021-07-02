CREATE TABLE [load].[DataSetProperty]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[DataSetId] INT NOT NULL,
	[Name] VARCHAR(255) NOT NULL,
	[OrdinalPosition] INT NOT NULL,
	[DataType] VARCHAR(255) NOT NULL,
	[DataTypePrecision]  VARCHAR(128),
	[IsPrimaryKey] BIT NOT NULL,
	[IsNullable] BIT NOT NULL,
	[IsDeletedInSource] BIT,
	[ChangeDate] DATETIME2(7) NOT NULL
	CONSTRAINT [DF_DataSetProperty_ChangeDate] DEFAULT SYSDATETIME(),
	[IsActive] BIT NOT NULL 
	CONSTRAINT [DF_DataSetProperty_IsActive] DEFAULT 1,
	CONSTRAINT [PK_DataSetProperty] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_DataSetProperty_DataSetId] 
  FOREIGN KEY ([DataSetId]) REFERENCES [load].[DataSet] ([Id]),
);
GO
CREATE UNIQUE INDEX [IX_U_DataSetProperty_DataSetId_Name] 
	ON [load].[DataSetProperty](DataSetId,[Name]);
