CREATE TABLE [App].[Neighborhood] (
    [NeighborhoodId]        INT        IDENTITY (1, 1) NOT NULL,
    [CityId]                SMALLINT        NOT NULL,
    [NeighborhoodName]      VARCHAR (200)   NOT NULL,
    [Longitude]             DECIMAL (12, 9) NULL,
    [Latitude]              DECIMAL (12, 9) NULL,
    [NeighborhoodNameASCII] VARCHAR (200)   NOT NULL,
    CONSTRAINT [PK_Neighborhood] PRIMARY KEY CLUSTERED ([NeighborhoodId] ASC)
);



