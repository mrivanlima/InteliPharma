CREATE TABLE [App].[PrescriptionType] (
    [PrescriptionTypeId]   TINYINT      IDENTITY (1, 1) NOT NULL,
    [PrescriptionTypeName] VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_PrescriptionTypeId] PRIMARY KEY CLUSTERED ([PrescriptionTypeId] ASC)
);

