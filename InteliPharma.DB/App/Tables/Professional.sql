CREATE TABLE [App].[Professional] (
    [ProfessionalId]                INT          IDENTITY (1, 1) NOT NULL,
    [ProfessionalName]              VARCHAR (50) NULL,
    [ProfessionalAssociationNumber] VARCHAR (20) NULL,
    CONSTRAINT [PK_Professional] PRIMARY KEY CLUSTERED ([ProfessionalId] ASC),
    CONSTRAINT [UQ_ProfessionalName] UNIQUE NONCLUSTERED ([ProfessionalName] ASC)
);

