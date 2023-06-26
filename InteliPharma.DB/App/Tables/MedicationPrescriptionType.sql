CREATE TABLE [App].[MedicationPrescriptionType] (
    [MedicationPrescriptionTypeId] BIGINT  IDENTITY (1, 1) NOT NULL,
    [MedicationId]                 INT     NOT NULL,
    [PrescriptionId]               BIGINT  NOT NULL,
    [PrescriptionTypeId]           TINYINT NULL,
    [Quantity]                     TINYINT NULL,
    CONSTRAINT [PK_MedicationPrescriptionType] PRIMARY KEY CLUSTERED ([PrescriptionId] ASC),
    CONSTRAINT [FK_MedicationPrescriptionTypeMedication] FOREIGN KEY ([MedicationId]) REFERENCES [App].[Medication] ([MedicationId]),
    CONSTRAINT [FK_MedicationPrescriptionTypePresc] FOREIGN KEY ([PrescriptionId]) REFERENCES [App].[Prescription] ([PrescriptionId]),
    CONSTRAINT [FK_MedicationPrescriptionTypePrescType] FOREIGN KEY ([PrescriptionTypeId]) REFERENCES [App].[PrescriptionType] ([PrescriptionTypeId])
);

