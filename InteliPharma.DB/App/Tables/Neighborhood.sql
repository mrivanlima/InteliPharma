CREATE TABLE [App].[Neighborhood] (
    [NeighborhoodId]   SMALLINT        IDENTITY (1, 1) NOT NULL,
    [CityId]           SMALLINT        NOT NULL,
    [NeighborhoodName] VARCHAR (50)    NOT NULL,
    [Longitude]        DECIMAL (12, 9) NULL,
    [Latitude]         DECIMAL (12, 9) NULL,
    CONSTRAINT [PK_Neighborhood] PRIMARY KEY CLUSTERED ([NeighborhoodId] ASC)
);

