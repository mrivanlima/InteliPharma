CREATE TABLE [App].[ProfessionalSpecialty] (
    [ProfessionalSpecialtyId] INT          IDENTITY (1, 1) NOT NULL,
    [SpecialtyId]             SMALLINT     NULL,
    [ProfessionalId]          VARCHAR (50) NULL,
    CONSTRAINT [PK_ProfessionalSpecialty] PRIMARY KEY CLUSTERED ([ProfessionalSpecialtyId] ASC),
    CONSTRAINT [UQ_ProfessionalSpecialtyName] UNIQUE NONCLUSTERED ([SpecialtyId] ASC, [ProfessionalId] ASC)
);

