
-------------------------------------------------------------
-------------------------------------------------------------

CREATE   PROCEDURE usp_api_NeighborhoodReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	
		NeighborhoodId,
		CityId,
		NeighborhoodName,
		Longitude,
		Latitude
	FROM App.Neighborhood;
END;