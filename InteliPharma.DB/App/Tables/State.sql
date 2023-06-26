CREATE TABLE [App].[State] (
    [StateId]   TINYINT         IDENTITY (1, 1) NOT NULL,
    [StateName] VARCHAR (20)    NOT NULL,
    [Longitude] DECIMAL (12, 9) NULL,
    [Latitude]  DECIMAL (12, 9) NULL,
    CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED ([StateId] ASC),
    CONSTRAINT [UQ_StateName] UNIQUE NONCLUSTERED ([StateName] ASC)
);

