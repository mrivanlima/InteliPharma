CREATE TABLE [App].[ContactType] (
    [ContactTypeId]          TINYINT       IDENTITY (1, 1) NOT NULL,
    [ContactTypeName]        VARCHAR (20)  NOT NULL,
    [ContactTypeDescription] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_ContactType] PRIMARY KEY CLUSTERED ([ContactTypeId] ASC),
    CONSTRAINT [UQ_ContactTypeName] UNIQUE NONCLUSTERED ([ContactTypeName] ASC)
);

