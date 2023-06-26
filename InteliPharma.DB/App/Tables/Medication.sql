CREATE TABLE [App].[Medication] (
    [MedicationId]                   INT           IDENTITY (1, 1) NOT NULL,
    [DrugId]                         INT           NOT NULL,
    [ClassificationId]               TINYINT       NOT NULL,
    [ManufacturerId]                 SMALLINT      NOT NULL,
    [MedicationTypeId]               TINYINT       NOT NULL,
    [AgeUsageId]                     INT           NOT NULL,
    [PharmaceuticalAdministrationId] INT           NOT NULL,
    [PharmaceuticalFormId]           INT           NOT NULL,
    [ActivePrincipleId]              INT           NOT NULL,
    [IndicationId]                   INT           NOT NULL,
    [AgeUsageDescription]            VARCHAR (100) NULL,
    [Threshold]                      VARCHAR (100) NULL,
    CONSTRAINT [PK_Medication] PRIMARY KEY CLUSTERED ([MedicationId] ASC)
);

