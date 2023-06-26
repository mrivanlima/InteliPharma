CREATE TABLE [App].[UserStore] (
    [UserStoreId] BIGINT IDENTITY (1, 1) NOT NULL,
    [UserId]      INT    NOT NULL,
    [StoreId]     INT    NOT NULL,
    [IsDefault]   BIT    DEFAULT ((0)) NULL,
    CONSTRAINT [PK_UserStore] PRIMARY KEY CLUSTERED ([UserStoreId] ASC),
    CONSTRAINT [FK_UserStoreStore] FOREIGN KEY ([StoreId]) REFERENCES [App].[Store] ([StoreId]),
    CONSTRAINT [FK_UserStoreUser] FOREIGN KEY ([UserId]) REFERENCES [Security].[UserLogin] ([UserId]),
    CONSTRAINT [UQ_UserStore] UNIQUE NONCLUSTERED ([UserId] ASC, [StoreId] ASC)
);

