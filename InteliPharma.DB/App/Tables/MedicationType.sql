CREATE TABLE [App].[MedicationType] (
    [MedicationTypeId]   TINYINT      IDENTITY (1, 1) NOT NULL,
    [MedicationTypeName] VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_MedicationType] PRIMARY KEY CLUSTERED ([MedicationTypeId] ASC),
    CONSTRAINT [UQ_MedicationTypeName] UNIQUE NONCLUSTERED ([MedicationTypeName] ASC)
);

