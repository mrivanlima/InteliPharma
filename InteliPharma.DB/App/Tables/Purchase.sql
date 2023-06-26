CREATE TABLE [App].[Purchase] (
    [PurchaseId]               INT           IDENTITY (1, 1) NOT NULL,
    [DistributorId]            INT           NULL,
    [OperationNatureId]        SMALLINT      NULL,
    [TaxCalculationId]         SMALLINT      NULL,
    [TransporterId]            SMALLINT      NULL,
    [ShippingAgreementId]      TINYINT       NULL,
    [PurchaseDate]             DATETIME      NULL,
    [PurchaseFiscalNote]       VARCHAR (20)  NULL,
    [DanfeBarCode]             VARCHAR (40)  NULL,
    [AccessKey]                VARCHAR (200) NULL,
    [AuthorizationProtocol]    VARCHAR (400) NULL,
    [StateSubscription]        VARCHAR (50)  NULL,
    [StateSubscriptionTribute] VARCHAR (50)  NULL,
    [CNPJ]                     VARCHAR (200) NULL,
    [EmissionDate]             DATE          NULL,
    [OperationDate]            DATE          NULL,
    [OperationTime]            TIME (7)      NULL,
    CONSTRAINT [PK_Purchase] PRIMARY KEY CLUSTERED ([PurchaseId] ASC)
);

