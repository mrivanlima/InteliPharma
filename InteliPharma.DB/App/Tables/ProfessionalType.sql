CREATE TABLE [App].[ProfessionalType] (
    [ProfessionalTypeId]   TINYINT      IDENTITY (1, 1) NOT NULL,
    [ProfessionalTypeName] VARCHAR (50) NULL,
    CONSTRAINT [PK_ProfessionalType] PRIMARY KEY CLUSTERED ([ProfessionalTypeId] ASC),
    CONSTRAINT [UQ_ProfessionalTypeName] UNIQUE NONCLUSTERED ([ProfessionalTypeName] ASC)
);

