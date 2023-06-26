CREATE TABLE [Security].[UserLoginExternal] (
    [UserId]                INT           NOT NULL,
    [ExternalProviderID]    SMALLINT      NOT NULL,
    [ExternalproviderToken] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_UserLoginExternal] PRIMARY KEY CLUSTERED ([UserId] ASC),
    CONSTRAINT [FK_UserLoginExternalExternalProvider] FOREIGN KEY ([ExternalProviderID]) REFERENCES [Security].[ExternalProvider] ([ExternalProviderId]),
    CONSTRAINT [FK_UserLoginExternalUserLogin] FOREIGN KEY ([UserId]) REFERENCES [Security].[UserLogin] ([UserId])
);

