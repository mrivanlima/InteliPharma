CREATE TABLE [App].[Danfe] (
    [DanfeId]     BIGINT       IDENTITY (1, 1) NOT NULL,
    [DanfeTypeId] SMALLINT     NOT NULL,
    [Serial]      VARCHAR (40) NOT NULL,
    [Page]        VARCHAR (20) NULL,
    CONSTRAINT [PK_Danfe] PRIMARY KEY CLUSTERED ([DanfeId] ASC)
);

