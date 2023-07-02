
CREATE   PROCEDURE App.usp_api_StateReadById
	@StateId TINYINT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT StateName, 
	       Longitude,
		   Latitude,
		   StateAbbreviation
	FROM App.[State]
	where StateId = @StateId;
END;