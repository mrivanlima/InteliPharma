CREATE TABLE [App].[ProductCartUser] (
    [ProductCartUserId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [ProductId]         BIGINT   NOT NULL,
    [CartId]            BIGINT   NOT NULL,
    [UserId]            INT      NOT NULL,
    [AddedOn]           DATETIME NULL,
    [Active]            BIT      NULL,
    CONSTRAINT [PK_ProductCartUser] PRIMARY KEY CLUSTERED ([ProductCartUserId] ASC)
);

