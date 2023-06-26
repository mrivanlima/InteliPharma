CREATE TABLE [App].[Address] (
    [AddressId] INT             IDENTITY (1, 1) NOT NULL,
    [ZipCodeId] INT             NOT NULL,
    [Number]    VARCHAR (30)    NULL,
    [Block]     VARCHAR (20)    NULL,
    [Lote]      VARCHAR (20)    NULL,
    [Longitude] DECIMAL (12, 9) NULL,
    [Latitude]  DECIMAL (12, 9) NULL,
    CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED ([AddressId] ASC)
);

