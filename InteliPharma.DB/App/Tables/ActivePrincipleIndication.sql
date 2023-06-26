CREATE TABLE [App].[ActivePrincipleIndication] (
    [ActivePrincipleIndicationId] INT IDENTITY (1, 1) NOT NULL,
    [ActivePrincipleId]           INT NOT NULL,
    [IndicationId]                INT NOT NULL,
    CONSTRAINT [PK_ActivePrincipleIndication] PRIMARY KEY CLUSTERED ([ActivePrincipleIndicationId] ASC),
    CONSTRAINT [FK_ActivePrincipleIndicationActivePrin] FOREIGN KEY ([ActivePrincipleId]) REFERENCES [App].[ActivePrinciple] ([ActivePrincipleId]),
    CONSTRAINT [FK_ActivePrincipleIndicationIndication] FOREIGN KEY ([IndicationId]) REFERENCES [App].[Indication] ([IndicationId])
);

