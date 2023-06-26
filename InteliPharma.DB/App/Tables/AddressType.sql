CREATE TABLE [App].[AddressType] (
    [AddressTypeId]          SMALLINT     IDENTITY (1, 1) NOT NULL,
    [AddressTypeDescription] VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_AddressTypeId] PRIMARY KEY CLUSTERED ([AddressTypeId] ASC)
);

