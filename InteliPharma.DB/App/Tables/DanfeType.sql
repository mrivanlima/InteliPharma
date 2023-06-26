CREATE TABLE [App].[DanfeType] (
    [DanfeTypeId]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [DanfeTypeName] VARCHAR (200) NOT NULL,
    [DanfeTypeCode] TINYINT       NOT NULL,
    CONSTRAINT [PK_DanfeType] PRIMARY KEY CLUSTERED ([DanfeTypeId] ASC),
    CONSTRAINT [UQ_DanfeTypeName] UNIQUE NONCLUSTERED ([DanfeTypeName] ASC)
);

