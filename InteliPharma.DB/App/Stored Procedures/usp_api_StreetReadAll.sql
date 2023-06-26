CREATE   PROCEDURE usp_api_StreetReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	
		StreetId,
		NeighborhoodId,
		StreetName,
		Longitude,
		Latitude
	FROM App.Street;
END