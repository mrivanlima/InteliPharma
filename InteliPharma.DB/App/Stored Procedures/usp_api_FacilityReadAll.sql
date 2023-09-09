﻿
CREATE   PROCEDURE App.usp_api_FacilityReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	FacilityId,
			Facilityname,
			AddressId
	FROM App.Facility;
END;
