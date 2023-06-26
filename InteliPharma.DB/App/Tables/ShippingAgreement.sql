CREATE TABLE [App].[ShippingAgreement] (
    [ShippingAgreementId] TINYINT      IDENTITY (1, 1) NOT NULL,
    [ShippingName]        VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_ShippingAgreement] PRIMARY KEY CLUSTERED ([ShippingAgreementId] ASC),
    CONSTRAINT [UQ_ShippingName] UNIQUE NONCLUSTERED ([ShippingName] ASC)
);

