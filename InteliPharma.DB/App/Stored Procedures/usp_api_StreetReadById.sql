
CREATE   PROCEDURE App.usp_api_StreetReadById
	@StreetId INT
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
	FROM App.Street
	WHERE StreetId = @StreetId;
END;