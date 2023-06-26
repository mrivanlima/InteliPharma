CREATE TABLE [App].[OperationNature] (
    [OperationNatureId]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [OperationNatureName] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_OperationNature] PRIMARY KEY CLUSTERED ([OperationNatureId] ASC),
    CONSTRAINT [UQ_OperationNatureName] UNIQUE NONCLUSTERED ([OperationNatureName] ASC)
);

