CREATE TABLE [App].[FaciltiyContact] (
    [FaciltiyContactId] BIGINT IDENTITY (1, 1) NOT NULL,
    [FacilityId]        INT    NOT NULL,
    [ContactId]         BIGINT NULL,
    CONSTRAINT [PK_FaciltiyContact] PRIMARY KEY CLUSTERED ([FaciltiyContactId] ASC)
);

