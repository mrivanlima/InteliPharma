CREATE TABLE [App].[PharmaceuticalAdministration] (
    [PharmaceuticalAdministrationId]          INT           IDENTITY (1, 1) NOT NULL,
    [PharmaceuticalAdministrationDescription] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_PharmaceuticalAdministration] PRIMARY KEY CLUSTERED ([PharmaceuticalAdministrationId] ASC),
    CONSTRAINT [UQ_PharmaceuticalAdministrationDescription] UNIQUE NONCLUSTERED ([PharmaceuticalAdministrationDescription] ASC)
);

