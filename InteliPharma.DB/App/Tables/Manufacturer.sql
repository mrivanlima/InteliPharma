CREATE TABLE [App].[Manufacturer] (
    [ManufacturerId]          SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ManufacturerName]        VARCHAR (100) NOT NULL,
    [ManufacturerPhoneNumber] VARCHAR (13)  NULL,
    CONSTRAINT [PK_Manufacturer] PRIMARY KEY CLUSTERED ([ManufacturerId] ASC),
    CONSTRAINT [UQ_ManufacturerName] UNIQUE NONCLUSTERED ([ManufacturerName] ASC)
);

