CREATE TABLE [Security].[UserRole] (
    [UserRoleId] INT     IDENTITY (1, 1) NOT NULL,
    [UserId]     INT     NOT NULL,
    [RoleId]     TINYINT NOT NULL,
    [Active]     BIT     DEFAULT ((1)) NULL,
    CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED ([UserRoleId] ASC),
    CONSTRAINT [FK_UserRoleRole] FOREIGN KEY ([RoleId]) REFERENCES [Security].[Role] ([RoleId]),
    CONSTRAINT [FK_UserRoleUser] FOREIGN KEY ([UserId]) REFERENCES [Security].[UserLogin] ([UserId]),
    CONSTRAINT [UQ_UserRole] UNIQUE NONCLUSTERED ([UserId] ASC, [RoleId] ASC)
);

