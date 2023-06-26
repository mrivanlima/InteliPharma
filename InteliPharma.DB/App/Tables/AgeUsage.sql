CREATE TABLE [App].[AgeUsage] (
    [AgeUsageId]          INT           IDENTITY (1, 1) NOT NULL,
    [AgeUsageDescription] VARCHAR (100) NOT NULL,
    [Threshold]           VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_AgeUsage] PRIMARY KEY CLUSTERED ([AgeUsageId] ASC)
);

