CREATE TABLE [App].[Classification] (
    [ClassificationId]   TINYINT      IDENTITY (1, 1) NOT NULL,
    [ClassificationName] VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_Classification] PRIMARY KEY CLUSTERED ([ClassificationId] ASC),
    CONSTRAINT [UQ_ClassificationName] UNIQUE NONCLUSTERED ([ClassificationName] ASC)
);

