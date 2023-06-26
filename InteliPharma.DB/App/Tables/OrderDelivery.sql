CREATE TABLE [App].[OrderDelivery] (
    [OrderDeliveryId]   BIGINT   IDENTITY (1, 1) NOT NULL,
    [DeliveryId]        BIGINT   NULL,
    [OrderId]           INT      NULL,
    [DriverId]          INT      NULL,
    [AddressId]         INT      NULL,
    [ProductCartUserId] BIGINT   NULL,
    [DeliveryStartDate] DATETIME NULL,
    [DeliveryEndDate]   DATETIME NULL,
    [Completed]         BIT      NULL,
    CONSTRAINT [PK_OrderDelivery] PRIMARY KEY CLUSTERED ([OrderDeliveryId] ASC)
);

