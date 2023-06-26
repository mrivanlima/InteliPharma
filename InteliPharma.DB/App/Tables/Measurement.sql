CREATE TABLE [App].[Measurement] (
    [MeasurementId]   INT          IDENTITY (1, 1) NOT NULL,
    [MeasurementName] VARCHAR (50) NULL,
    CONSTRAINT [PK_Measurement] PRIMARY KEY CLUSTERED ([MeasurementId] ASC)
);

