CREATE TABLE [App].[Dosage] (
    [DosageId]    INT           IDENTITY (1, 1) NOT NULL,
    [DosageValue] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Dosage] PRIMARY KEY CLUSTERED ([DosageId] ASC),
    CONSTRAINT [UQ_Dosage] UNIQUE NONCLUSTERED ([DosageValue] ASC)
);

