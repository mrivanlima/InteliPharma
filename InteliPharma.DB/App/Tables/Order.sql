CREATE TABLE [App].[Order] (
    [OrderId]    BIGINT       IDENTITY (1, 1) NOT NULL,
    [CartId]     BIGINT       NOT NULL,
    [TotalPrice] DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED ([OrderId] ASC)
);

