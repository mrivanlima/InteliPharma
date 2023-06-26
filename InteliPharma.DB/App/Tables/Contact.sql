CREATE TABLE [App].[Contact] (
    [ContactId]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [ContactName] VARCHAR (200) NULL,
    CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED ([ContactId] ASC)
);

