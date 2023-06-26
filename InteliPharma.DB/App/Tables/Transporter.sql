CREATE TABLE [App].[Transporter] (
    [TransporterId]     SMALLINT     IDENTITY (1, 1) NOT NULL,
    [AddressId]         INT          NOT NULL,
    [TransporterName]   VARCHAR (30) NOT NULL,
    [ANTTCode]          VARCHAR (20) NULL,
    [CNPJ]              VARCHAR (20) NULL,
    [StateSubscription] VARCHAR (20) NULL,
    CONSTRAINT [PK_Transporter] PRIMARY KEY CLUSTERED ([TransporterId] ASC)
);

