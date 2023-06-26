CREATE TABLE [App].[Store] (
    [StoreId]   INT           IDENTITY (1, 1) NOT NULL,
    [StoreName] VARCHAR (200) NOT NULL,
    [AddressId] INT           NOT NULL,
    CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED ([StoreId] ASC),
    CONSTRAINT [FK_StoreAddress] FOREIGN KEY ([AddressId]) REFERENCES [App].[Address] ([AddressId])
);

