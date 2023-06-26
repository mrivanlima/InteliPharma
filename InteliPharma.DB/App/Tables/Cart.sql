CREATE TABLE [App].[Cart] (
    [CartId]       BIGINT   IDENTITY (1, 1) NOT NULL,
    [CreationDate] DATETIME NULL,
    CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED ([CartId] ASC)
);

