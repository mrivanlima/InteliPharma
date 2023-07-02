CREATE TABLE [App].[Street] (
    [StreetId]       INT             IDENTITY (1, 1) NOT NULL,
    [NeighborhoodId] INT        NOT NULL,
    [StreetName]     VARCHAR (200)    NOT NULL,
    [StreetNameASCII]     VARCHAR (200)    NOT NULL,
    [ZipCodeCode]   VARCHAR(10) NOT NULL,
    [Longitude]      DECIMAL (12, 9) NULL,
    [Latitude]       DECIMAL (12, 9) NULL,
    CONSTRAINT [PK_Street] PRIMARY KEY CLUSTERED ([StreetId] ASC),
    CONSTRAINT [FK_StreetNeighborhood] FOREIGN KEY ([NeighborhoodId]) REFERENCES [App].[Neighborhood] ([NeighborhoodId])
);

