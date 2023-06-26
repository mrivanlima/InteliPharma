CREATE TABLE [App].[Facility] (
    [FacilityId]   INT           IDENTITY (1, 1) NOT NULL,
    [Facilityname] VARCHAR (100) NULL,
    [AddressId]    INT           NULL,
    CONSTRAINT [PK_Facility] PRIMARY KEY CLUSTERED ([FacilityId] ASC)
);

