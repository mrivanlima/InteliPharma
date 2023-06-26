CREATE TABLE [App].[Street] (
    [StreetId]       INT             IDENTITY (1, 1) NOT NULL,
    [NeighborhoodId] SMALLINT        NOT NULL,
    [StreetName]     VARCHAR (50)    NOT NULL,
    [Longitude]      DECIMAL (12, 9) NULL,
    [Latitude]       DECIMAL (12, 9) NULL,
    CONSTRAINT [PK_Street] PRIMARY KEY CLUSTERED ([StreetId] ASC),
    CONSTRAINT [FK_StreetNeighborhood] FOREIGN KEY ([NeighborhoodId]) REFERENCES [App].[Neighborhood] ([NeighborhoodId])
);

