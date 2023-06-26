CREATE TABLE [App].[Payment] (
    [PaymentId]       TINYINT IDENTITY (1, 1) NOT NULL,
    [PaymentMethodId] TINYINT NOT NULL,
    CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED ([PaymentId] ASC)
);

