CREATE TABLE [App].[Specialty] (
    [SpecialtyId]   SMALLINT     IDENTITY (1, 1) NOT NULL,
    [SpecialtyName] VARCHAR (50) NULL,
    CONSTRAINT [PK_Specialty] PRIMARY KEY CLUSTERED ([SpecialtyId] ASC),
    CONSTRAINT [UQ_SpecialtyName] UNIQUE NONCLUSTERED ([SpecialtyName] ASC)
);

