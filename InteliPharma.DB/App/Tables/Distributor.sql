CREATE TABLE [App].[Distributor] (
    [DistributorId]     INT           IDENTITY (1, 1) NOT NULL,
    [DistributorName]   VARCHAR (500) NOT NULL,
    [AddressId]         INT           NOT NULL,
    [CNPJ]              VARCHAR (30)  NULL,
    [StateSubscription] VARCHAR (50)  NULL,
    CONSTRAINT [PK_Distributor] PRIMARY KEY CLUSTERED ([DistributorId] ASC)
);

