CREATE TABLE [App].[PharmaceuticalForm] (
    [PharmaceuticalFormId]          INT           IDENTITY (1, 1) NOT NULL,
    [PharmaceuticalFormDescription] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_PharmaceuticalForm] PRIMARY KEY CLUSTERED ([PharmaceuticalFormId] ASC),
    CONSTRAINT [UQ_PharmaceuticalFormDescription] UNIQUE NONCLUSTERED ([PharmaceuticalFormDescription] ASC)
);

