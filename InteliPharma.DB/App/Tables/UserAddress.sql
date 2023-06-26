CREATE TABLE [App].[UserAddress] (
    [UserAddressId] INT      IDENTITY (1, 1) NOT NULL,
    [AddressId]     INT      NOT NULL,
    [UserId]        INT      NOT NULL,
    [AddressTypeId] SMALLINT NOT NULL,
    [Active]        BIT      NULL,
    [Default]       BIT      NULL,
    CONSTRAINT [PK_UserAddress] PRIMARY KEY CLUSTERED ([UserAddressId] ASC)
);

