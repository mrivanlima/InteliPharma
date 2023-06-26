CREATE TABLE [Security].[ExternalProvider] (
    [ExternalProviderId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [Providername]       VARCHAR (50)  NOT NULL,
    [WSEndPoint]         VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_ExternalProvider] PRIMARY KEY CLUSTERED ([ExternalProviderId] ASC)
);

