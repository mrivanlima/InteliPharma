CREATE TABLE [App].[ZipCode] (
    [ZipCodeId]   INT          IDENTITY (1, 1) NOT NULL,
    [ZipCodeCode] CHAR (8)     NOT NULL,
    [StreetId]    INT          NOT NULL,
    [ZipCodeFrom] VARCHAR (50) NULL,
    [ZipCodeTo]   VARCHAR (50) NULL,
    CONSTRAINT [PK_ZipCode] PRIMARY KEY CLUSTERED ([ZipCodeId] ASC),
    CONSTRAINT [UQ_ZipCodeCode] UNIQUE NONCLUSTERED ([ZipCodeCode] ASC)
);

