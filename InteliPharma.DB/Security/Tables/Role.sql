CREATE TABLE [Security].[Role] (
    [RoleId]          TINYINT       IDENTITY (1, 1) NOT NULL,
    [RoleDescription] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED ([RoleId] ASC),
    CONSTRAINT [UQ_RoleDescription] UNIQUE NONCLUSTERED ([RoleDescription] ASC)
);

