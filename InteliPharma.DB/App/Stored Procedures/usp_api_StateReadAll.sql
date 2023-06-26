

CREATE   PROCEDURE usp_api_StateReadAll
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT StateId,
	       StateName, 
	       Longitude,
		   Latitude
	FROM App.[State];
END;