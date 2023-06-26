CREATE TABLE [App].[ActivePrinciple] (
    [ActivePrincipleId]   INT           IDENTITY (1, 1) NOT NULL,
    [ActivePrincipleName] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_ActivePrinciple] PRIMARY KEY CLUSTERED ([ActivePrincipleId] ASC),
    CONSTRAINT [UQ_ActivePrincipleName] UNIQUE NONCLUSTERED ([ActivePrincipleName] ASC)
);

