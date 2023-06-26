CREATE TABLE [App].[DosageUnit] (
    [DosageUnitId] SMALLINT     IDENTITY (1, 1) NOT NULL,
    [UnitName]     VARCHAR (40) NULL,
    [UnitAbbrev]   VARCHAR (5)  NULL,
    CONSTRAINT [PK_DosageUnit] PRIMARY KEY CLUSTERED ([DosageUnitId] ASC),
    CONSTRAINT [UQ_UnitAbbrev] UNIQUE NONCLUSTERED ([UnitAbbrev] ASC),
    CONSTRAINT [UQ_UnitName] UNIQUE NONCLUSTERED ([UnitName] ASC)
);

