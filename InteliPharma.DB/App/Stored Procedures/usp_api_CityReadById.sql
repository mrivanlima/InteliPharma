
CREATE   PROCEDURE App.usp_api_CityReadById
	@CityId SMALLINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT	CityId,
			StateId,
			CityName,
			Longitude,
			Latitude
	FROM App.City
	WHERE CityId = @CityId;
END;