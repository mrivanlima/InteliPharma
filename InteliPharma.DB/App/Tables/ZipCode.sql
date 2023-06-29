CREATE TABLE [App].[ZipCode] (
    [ZipCodeId]   INT             IDENTITY (1, 1) NOT NULL,
    [ZipCodeCode] CHAR (8)        NOT NULL,
    [StreetId]    INT             NULL,
    [ZipCodeFrom] VARCHAR (50)    NULL,
    [ZipCodeTo]   VARCHAR (50)    NULL,
    [Longitude]   DECIMAL (18, 5) NULL,
    [Latitude]    DECIMAL (18, 5) NULL,
    CONSTRAINT [PK_ZipCode] PRIMARY KEY CLUSTERED ([ZipCodeId] ASC),
    CONSTRAINT [UQ_ZipCodeCode] UNIQUE NONCLUSTERED ([ZipCodeCode] ASC)
);



