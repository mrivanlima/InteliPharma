CREATE TABLE [App].[UserDisease] (
    [UserDiseaseId] INT IDENTITY (1, 1) NOT NULL,
    [UserId]        INT NULL,
    [DiseaseId]     INT NULL,
    CONSTRAINT [PK_UserDisease] PRIMARY KEY CLUSTERED ([UserDiseaseId] ASC),
    CONSTRAINT [FK_UserDiseaseDisease] FOREIGN KEY ([DiseaseId]) REFERENCES [App].[Disease] ([DiseaseId]),
    CONSTRAINT [FK_UserDiseaseUser] FOREIGN KEY ([UserId]) REFERENCES [Security].[UserLogin] ([UserId])
);

