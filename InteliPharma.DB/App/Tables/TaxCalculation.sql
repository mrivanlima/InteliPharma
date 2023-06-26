CREATE TABLE [App].[TaxCalculation] (
    [TaxCalculationId]          INT             IDENTITY (1, 1) NOT NULL,
    [ICMSBaseCalculation]       DECIMAL (10, 2) NULL,
    [ICMSValue]                 DECIMAL (10, 2) NULL,
    [ICMSBaseStateCalculation]  DECIMAL (10, 2) NULL,
    [ICMSValueState]            DECIMAL (10, 2) NULL,
    [ValueImportation]          DECIMAL (10, 2) NULL,
    [ICMSValueStateRemit]       DECIMAL (10, 2) NULL,
    [ICPValue]                  DECIMAL (10, 2) NULL,
    [PISValue]                  DECIMAL (10, 2) NULL,
    [TotalProductValue]         DECIMAL (10, 2) NULL,
    [ShipmentValue]             DECIMAL (10, 2) NULL,
    [InsuranceValue]            DECIMAL (10, 2) NULL,
    [Discount]                  DECIMAL (10, 2) NULL,
    [OtherExpenses]             DECIMAL (10, 2) NULL,
    [IPITotalValue]             DECIMAL (10, 2) NULL,
    [ICMSValueStateDestination] DECIMAL (10, 2) NULL,
    [TotalTributationValue]     DECIMAL (10, 2) NULL,
    [ConfinsValue]              DECIMAL (10, 2) NULL,
    [TotalNoteValue]            DECIMAL (10, 2) NULL,
    CONSTRAINT [PK_TaxCalculation] PRIMARY KEY CLUSTERED ([TaxCalculationId] ASC)
);

