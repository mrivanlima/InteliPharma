
-----------------------------------------------------------
-----------------------------------------------------------
CREATE   PROCEDURE usp_api_CityReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	CityId,
			StateId,
			CityName,
			Longitude,
			Latitude
	FROM App.City;
END;