CREATE TABLE [App].[City] (
    [CityId]    SMALLINT        IDENTITY (1, 1) NOT NULL,
    [StateId]   TINYINT         NOT NULL,
    [CityName]  VARCHAR (20)    NOT NULL,
    [Longitude] DECIMAL (12, 9) NULL,
    [Latitude]  DECIMAL (12, 9) NULL,
    CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED ([CityId] ASC),
    CONSTRAINT [FK_CityState] FOREIGN KEY ([StateId]) REFERENCES [App].[State] ([StateId]),
    CONSTRAINT [UQ_CityName] UNIQUE NONCLUSTERED ([CityName] ASC, [StateId])
);

