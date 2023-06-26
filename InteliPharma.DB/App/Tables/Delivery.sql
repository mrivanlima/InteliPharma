CREATE TABLE [App].[Delivery] (
    [DeliveryId]   BIGINT   IDENTITY (1, 1) NOT NULL,
    [CreatedDate]  DATETIME NULL,
    [AssignedDate] DATETIME NULL,
    CONSTRAINT [PK_Delivery] PRIMARY KEY CLUSTERED ([DeliveryId] ASC)
);

