CREATE TABLE [App].[Prescription] (
    [PrescriptionId]   BIGINT IDENTITY (1, 1) NOT NULL,
    [ProfessionalId]   INT    NOT NULL,
    [PatientId]        INT    NOT NULL,
    [PrescriptionDate] DATE   NOT NULL,
    CONSTRAINT [PK_Prescription] PRIMARY KEY CLUSTERED ([PrescriptionId] ASC)
);

