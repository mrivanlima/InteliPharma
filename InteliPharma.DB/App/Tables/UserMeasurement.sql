CREATE TABLE [App].[UserMeasurement] (
    [UserMeasurementId]   INT  IDENTITY (1, 1) NOT NULL,
    [UserId]              INT  NULL,
    [MeasurementId]       INT  NULL,
    [UserMeasurementDate] DATE NULL,
    CONSTRAINT [PK_UserMeasurement] PRIMARY KEY CLUSTERED ([UserMeasurementId] ASC),
    CONSTRAINT [FK_UserMeasurementMeasurement] FOREIGN KEY ([MeasurementId]) REFERENCES [App].[Measurement] ([MeasurementId]),
    CONSTRAINT [FK_UserMeasurementUser] FOREIGN KEY ([UserId]) REFERENCES [Security].[UserLogin] ([UserId])
);

