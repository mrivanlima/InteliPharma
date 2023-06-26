CREATE TABLE [App].[ProductPurchase] (
    [ProductPurchaseId]   INT             IDENTITY (1, 1) NOT NULL,
    [ProductId]           INT             NULL,
    [PurchaseId]          INT             NULL,
    [Quantity]            INT             NULL,
    [Price]               DECIMAL (10, 2) NULL,
    [PurchaseDate]        DATETIME        NULL,
    [Serial]              VARCHAR (10)    NULL,
    [ProductBarCode]      VARCHAR (40)    NULL,
    [ProductCode]         VARCHAR (20)    NULL,
    [NCMSH]               VARCHAR (10)    NULL,
    [CMCST]               VARCHAR (20)    NULL,
    [CFOP]                VARCHAR (20)    NULL,
    [UN]                  SMALLINT        NULL,
    [UnitValue]           DECIMAL (10, 2) NULL,
    [TotalValue]          DECIMAL (10, 2) NULL,
    [ICMSBaseCalculation] DECIMAL (10, 2) NULL,
    [ICMSValue]           DECIMAL (10, 2) NULL,
    [IPIValue]            DECIMAL (10, 2) NULL,
    [ICMSPercent]         DECIMAL (10, 2) NULL,
    [IPIPercent]          DECIMAL (10, 2) NULL,
    CONSTRAINT [PK_ProductPurchase] PRIMARY KEY CLUSTERED ([ProductPurchaseId] ASC)
);

