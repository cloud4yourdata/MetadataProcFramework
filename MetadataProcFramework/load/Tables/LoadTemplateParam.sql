CREATE TABLE [load].[LoadTemplateParam]
(
  [Id] INT NOT NULL,
  [Name] NVARCHAR (50) NOT NULL,
  [Description] NVARCHAR (255) NOT NULL,
  CONSTRAINT [PK_LoadTemplateParam] PRIMARY KEY CLUSTERED ([Id] ASC)
)
