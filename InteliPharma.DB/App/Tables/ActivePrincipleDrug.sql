CREATE TABLE [App].[ActivePrincipleDrug] (
    [ActivePrincipleDrugId] INT IDENTITY (1, 1) NOT NULL,
    [DrugId]                INT NULL,
    [ActivePrincipleId]     INT NULL,
    CONSTRAINT [PK_ActivePrincipleDrug] PRIMARY KEY CLUSTERED ([ActivePrincipleDrugId] ASC),
    CONSTRAINT [FK_ActivePrincipleDrugActivePrinciple] FOREIGN KEY ([ActivePrincipleId]) REFERENCES [App].[ActivePrinciple] ([ActivePrincipleId]),
    CONSTRAINT [FK_ActivePrincipleDrugDrug] FOREIGN KEY ([DrugId]) REFERENCES [App].[Drug] ([DrugId]),
    CONSTRAINT [UQ_ActivePrincipleDrug] UNIQUE NONCLUSTERED ([DrugId] ASC, [ActivePrincipleId] ASC)
);

