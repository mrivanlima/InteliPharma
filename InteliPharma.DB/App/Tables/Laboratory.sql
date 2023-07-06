CREATE TABLE [App].[Laboratory] (
    [LaboratoryId]        INT           IDENTITY (1, 1) NOT NULL,
    [LaboratoryName]      VARCHAR (500) NOT NULL,
    [LaboratoryNameASCII] VARCHAR (500) NOT NULL,
    [AddressId]           INT           NULL,
    [CNPJ]                VARCHAR (30)  NULL,
    [StateSubscription]   VARCHAR (50)  NULL,
    CONSTRAINT [PK_Laboratory] PRIMARY KEY CLUSTERED ([LaboratoryId] ASC)
);

