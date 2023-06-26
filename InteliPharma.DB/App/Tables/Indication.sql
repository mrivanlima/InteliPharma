CREATE TABLE [App].[Indication] (
    [IndicationId]          INT           IDENTITY (1, 1) NOT NULL,
    [IndicationDescription] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Indication] PRIMARY KEY CLUSTERED ([IndicationId] ASC),
    CONSTRAINT [UQ_IndicationDescription] UNIQUE NONCLUSTERED ([IndicationDescription] ASC)
);

