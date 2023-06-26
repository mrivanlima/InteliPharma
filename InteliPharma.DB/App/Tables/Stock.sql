CREATE TABLE [App].[Stock] (
    [StockId]         BIGINT       IDENTITY (1, 1) NOT NULL,
    [ProductId]       INT          NULL,
    [Lote]            VARCHAR (20) NULL,
    [FabricationDate] DATE         NULL,
    [ExpirationDate]  DATE         NULL,
    [Quantity]        INT          NULL,
    CONSTRAINT [PK_Stock] PRIMARY KEY CLUSTERED ([StockId] ASC)
);

