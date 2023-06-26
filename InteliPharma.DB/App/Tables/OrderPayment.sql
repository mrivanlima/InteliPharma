CREATE TABLE [App].[OrderPayment] (
    [OrderPaymentId] BIGINT  IDENTITY (1, 1) NOT NULL,
    [OrderId]        BIGINT  NOT NULL,
    [PaymentId]      TINYINT NOT NULL,
    CONSTRAINT [PK_OrderPayment] PRIMARY KEY CLUSTERED ([OrderPaymentId] ASC)
);

