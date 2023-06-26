﻿CREATE TABLE [App].[Drug] (
    [DrugId]   INT           IDENTITY (1, 1) NOT NULL,
    [DrugName] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Drug] PRIMARY KEY CLUSTERED ([DrugId] ASC),
    CONSTRAINT [UQ_DrugName] UNIQUE NONCLUSTERED ([DrugName] ASC)
);

