CREATE TABLE [stg].[City] (
    [CityId]        SMALLINT        IDENTITY (1, 1) NOT NULL,
    [StateId]       TINYINT         NOT NULL,
    [CityName]      VARCHAR (200)   NOT NULL,
    [CityNameASCII] VARCHAR (200)   NOT NULL,
    [Longitude]     DECIMAL (12, 9) NULL,
    [Latitude]      DECIMAL (12, 9) NULL,
    CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED ([CityId] ASC)
);

