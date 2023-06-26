CREATE TABLE [App].[Disease] (
    [DiseaseId]    INT          IDENTITY (1, 1) NOT NULL,
    [DieseaseName] VARCHAR (50) NULL,
    CONSTRAINT [PK_Disease] PRIMARY KEY CLUSTERED ([DiseaseId] ASC)
);

