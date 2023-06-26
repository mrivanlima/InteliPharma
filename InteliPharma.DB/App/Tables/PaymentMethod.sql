CREATE TABLE [App].[PaymentMethod] (
    [PaymentMethodId]   TINYINT      IDENTITY (1, 1) NOT NULL,
    [PaymentMethodName] VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_PaymentMethod] PRIMARY KEY CLUSTERED ([PaymentMethodId] ASC),
    CONSTRAINT [UQ_PaymentMethodName] UNIQUE NONCLUSTERED ([PaymentMethodName] ASC)
);

