CREATE TABLE [App].[Product] (
    [ProductId]      INT             IDENTITY (1, 1) NOT NULL,
    [ProductBarCode] DATETIME        NULL,
    [Price]          DECIMAL (10, 2) NULL,
    [Active]         BIT             NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([ProductId] ASC)
);

